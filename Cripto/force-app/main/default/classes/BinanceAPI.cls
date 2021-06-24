public with sharing class BinanceAPI {

    @Future(Callout=true)
    public static void updatePrices(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        List<SymbolPrice> spList = new List<SymbolPrice>();

        if (response.getStatusCode() == 200) {
            spList = (List<SymbolPrice>)JSON.deserialize(response.getBody(), List<SymbolPrice>.class);
        }

        Map<String,  Double> priceMap = new Map<String, Double>();
        
        for(BinanceApi.SymbolPrice sp : spList){
            priceMap.put(sp.symbol, Double.valueof(sp.price));
        }
        List<Mercado__c> mercadoList= [select Id,ContinuousName__c FROM Mercado__c where Ativo__c = TRUE and ContinuousName__c in :priceMap.keySet()];
        List<HistoricoDePreco__c> histPreco = new List<HistoricoDePreco__c>();

        for(Mercado__c merc : mercadoList){
            histPreco.add(new HistoricoDePreco__c(
                Mercado__c = merc.Id,
                Preco__c = priceMap.get(merc.ContinuousName__c)
            ));
            
        }
        insert histPreco;
    }

    @AuraEnabled
    public static List<SymbolPrice> getPrice(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<SymbolPrice> spList = (List<SymbolPrice>)JSON.deserialize(response.getBody(), List<SymbolPrice>.class);
            return spList;
        }else{
            return null;
        }
    }

    @AuraEnabled
    public static String getPrice(String mercadoId){
        Mercado__c mercado = [SELECT Id, MoedaPrimaria__c, MoedaSecundaria__c 
                              FROM Mercado__c
                              WHERE Id = :mercadoId];

        String pair = mercado.MoedaPrimaria__c + mercado.MoedaSecundaria__c;
        pair = pair.replace('USD', 'USDT');

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.binance.com/api/v3/ticker/price?symbol=' + pair);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            SymbolPrice sp = (SymbolPrice)JSON.deserialize(response.getBody(), SymbolPrice.class);
            return sp.price;
        }else{
            return 'Erro ao acessar a API da Binance!';
        }
    }

    public Class SymbolPrice{
        public String symbol {get; set;}
        public String price {get; set;}
    }

    @AuraEnabled
    public static String getRecordTypeId(String ordemType){
        Id rTypeId = Schema.SObjectType.Ordem__c.getRecordTypeInfosByDeveloperName().get(ordemType).getRecordTypeId();
        return rTypeId;
    }
}