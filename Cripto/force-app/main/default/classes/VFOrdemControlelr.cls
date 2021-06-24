public class VFOrdemControlelr {

    public List<Ordem__c> ordemList {get; set;}

    public String currentValue {get; set;}

    public List<BinanceAPI.SymbolPrice> priceList {get; set;}
    public Date currentDate {get; set;}

    public VFOrdemControlelr(){

    }

    public VFOrdemControlelr(ApexPages.StandardController controller){
        Mercado__c mercado = (Mercado__c) controller.getRecord();

        this.ordemList = [SELECT Id, Name, OperacaoMercado__c, Tipo__c, Status__c, Quantidade__c, Total__c, Validade__c, Preco__c from Ordem__c where Mercado__c = :mercado.Id];

        for(Ordem__c o : ordemList) {
            o.Quantidade__c = o.Quantidade__c.setScale(6);
            o.Preco__c = o.Preco__c.setScale(6);
            o.Total__c = o.Total__c.setScale(6);
        }

        this.currentValue = BinanceAPI.getPrice(mercado.Id);

        this.priceList = BinanceAPI.getPrice();

        currentDate = Date.today();

    }
}
