public with sharing class OrdemDomain {

    private Ordem__c ordem;

    public double getTotal(){
        return ordem.Total__c;
    }

    public OrdemDomain(Ordem__c ordem){
        this.ordem = ordem;
    }

    public void recalculaTotal(){
        if(ordem.Preco__c !=null && ordem.Quantidade__c != null){
            ordem.Total__c = ordem.Quantidade__c * ordem.Preco__c;
        } else {
            ordem.adderror('Os valores de quantidade e preço não foram preenchidos');
        }
    }

    public void recalculaQuantidade(){
        if(ordem.Preco__c != null && ordem.Total__c != null){
            ordem.Quantidade__c = ordem.Total__c / ordem.Preco__c;
        } else {
            ordem.adderror('Os valores de preço não foram preenchidos');
        }
    }

    public Boolean isFieldDifferent(sObjectField field, Ordem__c compareOrdem){
        return ordem.get(field) != compareOrdem.get(field);
    }
}
