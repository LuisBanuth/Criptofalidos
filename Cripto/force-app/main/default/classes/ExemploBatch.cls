public with sharing class ExemploBatch implements Database.Batchable<sObject> {

    public ExemploBatch(){

    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id, Revisao__c from HistoricoDePreco__c');
    }

    public void execute(Database.BatchableContext bc, List<HistoricoDePreco__c> scope){
        for(HistoricoDePreco__c hp : scope){
            if(hp.Revisao__c == null){
                hp.Revisao__c = 0;
            } else {
                hp.Revisao__c++;
            }
        }
        update scope;
    }
    public void finish(Database.BatchableContext bc){

    }
}