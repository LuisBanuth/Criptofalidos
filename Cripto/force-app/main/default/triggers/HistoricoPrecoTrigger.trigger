trigger HistoricoPrecoTrigger on HistoricoDePreco__c (after insert) {
    new HistoricoDePrecoTrigerHandler().run();
}