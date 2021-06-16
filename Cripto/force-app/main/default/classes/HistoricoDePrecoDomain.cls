public with sharing class HistoricoDePrecoDomain {

    private HistoricoDePreco__c historico;
    public HistoricoDePrecoDomain(HistoricoDePreco__c historico) {
        this.historico = historico;
    }

    public void atualizarPrecoMercado(){
        Id id = this.historico.Mercado__c;
        Mercado__c mercado = [select Id, Preco__c from Mercado__c where Id = :id];
        mercado.Preco__c = this.historico.Preco__c;
        update mercado;
    }
}
