public with sharing class OrdemTriggerHandler extends TriggerHandler{
    public OrdemTriggerHandler() {

        
    }

    protected override void beforeInsert(){
        for(Ordem__c ordermNova : (List<Ordem__c>) trigger.new){
            //Calculo do total
            if(ordermNova.Total__c == null){
                if(ordermNova.Preco__c !=null && ordermNova.Quantidade__c != null){
                    ordermNova.Total__c = ordermNova.Quantidade__c * ordermNova.Preco__c;
                } else {
                    ordermNova.adderror('Os valores de quantidade e preço não foram preenchidos');
                }
            }
            //Calculo da quantidade
            else{
                if(ordermNova.Preco__c !=null){
                    ordermNova.Quantidade__c = ordermNova.Total__c / ordermNova.Preco__c;
                } else {
                    ordermNova.adderror('Os valores de preço não foram preenchidos');
                }
            }
        }
    }

    protected override void beforeUpdate(){
        for(Ordem__c ordermNova : (List<Ordem__c>) trigger.new){
            Ordem__c ordemAntiga = (Ordem__c) trigger.oldMap.get(ordermNova.Id);

            if(ordermNova.Quantidade__c != null && ordermNova.Preco__c != null){
                //Erro de alteração de total
                if(ordemAntiga.Total__c != ordermNova.Total__c && ordermNova.Total__c  != ordermNova.Quantidade__c * ordermNova.Preco__c ){
                    ordermNova.adderror('O total não pode ser alterado manualmente depois que a ordem foi criada.');
                }
                //Recalculo do total
                if(ordemAntiga.Quantidade__c != ordermNova.Quantidade__c || ordemAntiga.Preco__c != ordermNova.Preco__c ){
                    ordermNova.Total__c = ordermNova.Quantidade__c * ordermNova.Preco__c;
                }
            } else {
                ordermNova.adderror('Os valores de quantidade e preço não foram preenchidos');
            }
        }
    }
}