trigger OrdemTrigger on Ordem__c (before insert, before update) {
    new OrdemTriggerHandler().run();
}