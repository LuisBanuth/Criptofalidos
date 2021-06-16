public with sharing class OrdemController {
    @AuraEnabled(cacheable=true)
    public static List<Mercado__c> getMercados(){
        List<Mercado__c> mercado = [select Id, Name from Mercado__c WITH SECURITY_ENFORCED];
        return mercado;
    }

    @AuraEnabled(cacheable=true)
    public static List<Carteira__c> getCarteiras(){
        List<Carteira__c> carteiras =  [select Id, Name from Carteira__c WITH SECURITY_ENFORCED];
        return carteiras;
    }

    @AuraEnabled(cacheable=true)
    public static List<RecordType> getOrdemType(){
        List<RecordType> tipoOrdem = [select Id,Name from RecordType where sObjectType='Ordem__c'];
        return tipoOrdem;
    }

    @AuraEnabled(cacheable=true)
    public static List<String> getStatusOptions(){
        List<String> pickListValuesList= new List<String>();
         Schema.DescribeFieldResult fieldResult = Ordem__c.Status__c.getDescribe();
         List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry pickListVal : ple){
             pickListValuesList.add(pickListVal.getLabel());
         }     
         return pickListValuesList;
     }
}