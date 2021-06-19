public with sharing class MercadoTriggerHandler extends TriggerHandler{
    public MercadoTriggerHandler() {

    }

    // public override void afterUpdate(){
    //     List<Mercado__c> mercados = trigger.new;
    //     List<Ordem__c> ordensToUpdate = new List<Ordem__c>();

    //     List<Mercado__c> mercadoTriggerList = [select Id, CotacaoAtual__c, (select Id, Preco__c from Ordens__r 
    //     where status__c = 'Aguardando') from Mercado__c where Id in :Trigger.newMap.keySet()];

    //     //List<Ordem__c> ordens = [select Id, Name from Ordem__c where Id in :mercadosId and Status__c = 'Aguardando'];
        
    //     for(Mercado__c mercado : mercadoTriggerList){
    //         for(Ordem__c ordem : mercado.Ordens__r){
    //             if(ordem.Mercado__c == mercado.Id)
    //             {
    //                 double precoAntigo = trigger.oldMap.get(mercado.id).preco__c;
    //                 double precoOrdem = ordem.preco__c;
    //                 double preconovo = mercado.preco__c;
    //                 if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
    //                 {
    //                     ordensToUpdate.add(new Ordem__c(Id = ordem.Id, Status__c = 'Executada'));
    //                 }
    //             }
    //         }
    //     }

    //     update ordensToUpdate;
    // }
}
