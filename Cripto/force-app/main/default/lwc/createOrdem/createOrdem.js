import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';

import getMercados from '@salesforce/apex/OrdemController.getMercados';
import getCarteiras from '@salesforce/apex/OrdemController.getCarteiras';
import getOrdemType from '@salesforce/apex/OrdemController.getOrdemType';

import ORDEM_OBJECT from '@salesforce/schema/Ordem__c';
import ORDEM_MERCADO_FIELD from '@salesforce/schema/Ordem__c.Mercado__c';
import ORDEM_PRECO_FIELD from '@salesforce/schema/Ordem__c.Preco__c';
import ORDEM_QUANTIDADE_FIELD from '@salesforce/schema/Ordem__c.Quantidade__c';
import ORDEM_TIPO_FIELD from '@salesforce/schema/Ordem__c.RecordTypeId';
import ORDEM_TOTAL_FIELD from '@salesforce/schema/Ordem__c.Total__c';
import ORDEM_CARTEIRA_FIELD from '@salesforce/schema/Ordem__c.Carteira__c';
import ORDEM_STATUS_FIELD from '@salesforce/schema/Ordem__c.Status__c';
import ORDEM_LABEL_TIPO_FIELD from '@salesforce/schema/Ordem__c.Tipo__c';

export default class CreateOrdem extends LightningElement {

    handleOrdem(){
        const recordInput = {
            apiName: ORDEM_OBJECT.objectApiName,
            fields: {
                [ORDEM_MERCADO_FIELD.fieldApiName] : this.mercado,
                [ORDEM_PRECO_FIELD.fieldApiName] : parseInt(this.preco),
                [ORDEM_QUANTIDADE_FIELD.fieldApiName] : parseInt(this.quantidade),
                [ORDEM_TIPO_FIELD.fieldApiName] : this.tipoOrdem,
                [ORDEM_TOTAL_FIELD.fieldApiName] : parseInt(this.total),
                [ORDEM_CARTEIRA_FIELD.fieldApiName] : this.carteira,
                [ORDEM_STATUS_FIELD.fieldApiName] : 'Aguardando',
                //[ORDEM_LABEL_TIPO_FIELD.fieldApiName] : this.labelTipoOrdem,
            }
        };
        createRecord(recordInput)
            .then(ordem => {
                this.mercadoPrimario = 'ok';
                const toastEvent = new ShowToastEvent({
                    title: "Ordem Criada",
                    message: "Record ID: " + ordem.id,
                    variant: "success"
                });
                this.dispatchEvent(toastEvent);
            })
            .catch(error => {
                this.mercadoPrimario = 'erro';
                const toastEvent = new ShowToastEvent({
                    title: "Erro",
                    message: error.message
                });
                this.dispatchEvent(toastEvent);
            });
    }


    mercados = [];
    @wire(getMercados)
    getMercados({error, data}){
        if(data){
            for(var i = 0; i < data.length; i++){
                this.mercados = [...this.mercados, { label: data[i].Name, value: data[i].Id },]
            }
        }
    }

    carteiras = [];
    @wire(getCarteiras)
    getCarteiras({error, data}){
        if(data){
            for(var i = 0; i < data.length; i++){
                this.carteiras = [...this.carteiras, { label: data[i].Name, value: data[i].Id },]
            }
        }
    }

    tiposOrdem = [];
    @wire(getOrdemType)
    getOrdemType({error, data}){
        if(data){
            for(var i = 0; i < data.length; i++){
                this.tiposOrdem = [...this.tiposOrdem, { label: data[i].Name, value: data[i].Id },]
            }
        }
    }

    @api mercado;
    @api mercadoPrimario;
    @api mercadoSecundario
    handleMercado(event){
        this.mercado = event.target.value;
        for(var i = 0; i < this.mercados.length; i++){
            if(this.mercados[i].value == this.mercado){
                if(this.tipoOrdem == '0125e0000001aB8AAI'){
                    this.mercadoPrimario = this.mercados[i].label.split('/')[1];
                    this.mercadoSecundario = this.mercados[i].label.split('/')[0];
                } else {
                    this.mercadoPrimario = this.mercados[i].label.split('/')[0];
                    this.mercadoSecundario = this.mercados[i].label.split('/')[1];
                }
            }
        }
    }

    @api carteira;
    handleCarteira(event){
        this.carteira = event.target.value;
    }

    @api tipoOrdem;
    @api labelTipoOrdem
    handleTipoOrdem(event){
        this.tipoOrdem = event.target.value;
        // for(var i = 0; i < this.tiposOrdem.length; i++){
        //     if(this.tiposOrdem[i].Id == this.tipoOrdem){
        //         this.labelTipoOrdem = this.tiposOrdem[i].Name;
        //     }
        // }
    }

    @api preco;
    handlePreco(event){
        this.preco = event.target.value;
        if(this.preco > 0 && this.quantidade >0){
            this.total = this.preco * this.quantidade;
        }
    }

    @api quantidade;
    handleQuantidade(event){
        this.quantidade = event.target.value;
        if(this.preco > 0 && this.quantidade >0){
            this.total = this.preco * this.quantidade;
        }
    }

    @api total;
    handleTotal(event){
        this.total = event.target.value;
        if(this.preco >0 && this.total > 0){
            this.quantidade = this.total / this.preco;
        }
    }
}