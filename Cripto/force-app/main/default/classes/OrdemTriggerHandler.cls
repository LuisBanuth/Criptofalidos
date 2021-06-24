public with sharing class OrdemTriggerHandler extends TriggerHandler{
    public OrdemTriggerHandler() {

        
    }

    protected override void beforeInsert(){
        for(Ordem__c ordermNova : (List<Ordem__c>) trigger.new){
            OrdemDomain ordem = new OrdemDomain(ordermNova);

            if(ordem.getTotal() == null) ordem.recalculaTotal();
            else ordem.recalculaQuantidade();
        }
    }

    protected override void beforeUpdate(){
        for(Ordem__c ordermNova : (List<Ordem__c>) trigger.new){
            OrdemDomain ordem = new OrdemDomain(ordermNova);

            Ordem__c ordemAntiga = (Ordem__c) trigger.oldMap.get(ordermNova.Id);

            if(ordem.isFieldDifferent(Schema.Ordem__c.Total__c, ordemAntiga)) {    
               ordermNova.adderror('O total não pode ser alterado manualmente depois que a ordem foi criada.');
            }
                
            if(ordem.isFieldDifferent(Schema.Ordem__c.Quantidade__c, ordemAntiga) || ordem.isFieldDifferent(Schema.Ordem__c.Preco__c, ordemAntiga)) {
                ordem.recalculaTotal();
            }
        }
    }
}