trigger OrdemTrigger on Ordem__c (before insert, before update) {
    new OrdemTriggerHandler().run();

    //verificar se é quantidadep ou total p
    //ordermNova.TotalP__c = ordermNova.Tipo__c == 'Venda' ? ordermNova.Quantidade__c *-1 : ordermNova.Quantidade__c;
}