public with sharing class HistoricoDePrecoTrigerHandler extends TriggerHandler {
    public HistoricoDePrecoTrigerHandler() {

    }

    protected override void afterInsert(){
        // Map<String, HistoricoDePreco__c> mercadosMap = new Map<String, HistoricoDePreco__c>();
        // List<String> idsMercado = new List<String>();
        // List<Mercado__c> mercadosUpdate = new List<Mercado__c>();

        // for(HistoricoDePreco__c preco : (List<HistoricoDePreco__c>) trigger.new){
        //     HistoricoDePreco__c precoInMap = mercadosMap.get(preco.Mercado__c); //verifica se existe id no map
        //     if(precoInMap != null){ //se existir
        //         if(precoInMap.CreatedDate <= preco.CreatedDate){ //verifica se a data é menor ou igual
        //             mercadosMap.put(preco.Mercado__c, preco); //atualiza valor novo
        //         }
        //     } else {
        //         mercadosMap.put(preco.Mercado__c, preco); //caso nao exista, insere valor novo no map
        //         idsMercado.add(preco.Mercado__c);//e insere id do mercado na lista de ids
        //     }
        // }

        // for(String id : idsMercado){ 
        //     mercadosUpdate.add(new Mercado__c(Id = id, CotacaoAtual__c = mercadosMap.get(id).Preco__c)); //para cada id na lista, insere um mercado na lista de mercados
        // }

        Map<Id, Mercado__c> mercadosUpdate = new Map<Id, Mercado__c>();

        for(HistoricoDePreco__c preco : (List<HistoricoDePreco__c>) trigger.new){
            mercadosUpdate.put(preco.Mercado__c, new Mercado__c(Id=preco.Mercado__c, CotacaoAtual__c = preco.Preco__c));
        }

        update mercadosUpdate.values();
    }
}
