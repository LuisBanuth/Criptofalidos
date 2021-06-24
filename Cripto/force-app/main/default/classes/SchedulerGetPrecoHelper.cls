public with sharing class SchedulerGetPrecoHelper {
    public SchedulerGetPrecoHelper() {

    }

    @Future(Callout=true)
    public static void atualizaCotacaoAtualTodosMercadosAtivos(){
        Map<String, double> priceMap = new Map<String, double>();
        List<BinanceApi.SymbolPrice> spList = BinanceAPI.getPrice();
        
        for(BinanceApi.SymbolPrice sp : spList){
            priceMap.put(sp.symbol, Double.valueof(sp.price));
        }
        List<Mercado__c> mercadoList= [select name, ContinuousName__c FROM Mercado__c where Ativo__c = TRUE and ContinuousName__c in :priceMap.keySet()];

        for(Mercado__c merc : mercadoList){
            merc.CotacaoAtual__c = priceMap.get(merc.ContinuousName__c);
        }
        update mercadoList;
    }
}