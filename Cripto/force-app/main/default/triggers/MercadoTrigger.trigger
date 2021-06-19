trigger MercadoTrigger on Mercado__c (before update) {
    // new MercadoTriggerHandler().run();

    // // Desenvolvedor Salesfoce Voldemorte
    // mercado__c merc = trigger.new[0];
    // list<Ordem_c> OrdemList = [Select id, precoc, statusc from Ordemc where mercado_c = :merc.id];
    // for(Ordem__c ord : OrdemList)
    // {
    //     if(ord.status__c == 'Aguardando')
    //     {
    //         double precoAntigo = trigger.oldMap.get(merc.id).preco__c;
    //         double precoOrdem = ord.preco__c;
    //         double preconovo = merc.preco__c;
    //         if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
    //         {
    //             ord.status__c = 'Executada';
    //             update ord;
    //         }
    //     }
    // }

    // // Desenvolvedor Salesfoce chera cu
    // List<Mercado__c> mercados = trigger.new;
    
    // for(Mercado__c mercado : (Mercado__c) trigger.new){
    //     list<Ordem_c> OrdemList = [Select id, precoc, statusc from Ordemc where mercado_c = :mercado.id];
    //     for(Ordem__c ord : OrdemList)
    //     {
    //         if(ord.status__c == 'Aguardando')
    //         {
    //             double precoAntigo = trigger.oldMap.get(mercado.id).preco__c;
    //             double precoOrdem = ord.preco__c;
    //             double preconovo = mercado.preco__c;
    //             if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
    //             {
    //                 ord.status__c = 'Executada';
    //                 update ord;
    //             }
    //         }
    //     }
    // }


    // // Desenvolvedor Salesfoce 
    // List<Mercado__c> mercados = trigger.new;
    // List<Id> mercadosId = new List<Id>();
    // List<Ordem__c> ordensToUpdate = new List<Ordem__c>();

    // for(Mercado__c mercado: mercados){
    //     mercadosId.add(mercado.id);
    // }

    // List<Ordem__c> ordens = [select Id, Name from Ordem__c where Id in :mercadosId and Status__c = 'Aguardando'];
    
    // for(Mercado__c mercado : (Mercado__c) trigger.new){
    //     for (Ordem__c ordem : ordens) {
    //         if(ordem.Mercado__c == mercado.Id)
    //         {
    //             double precoAntigo = trigger.oldMap.get(mercado.id).preco__c;
    //             double precoOrdem = ord.preco__c;
    //             double preconovo = mercado.preco__c;
    //             if((precoOrdem >=precoAntigo && precoOrdem<= preconovo) || (precoOrdem <=precoAntigo && precoOrdem >= preconovo))
    //             {
    //                 ordensToUpdate.add(new Ordem__c(Id = ordem.Id, Status__c = 'Executada'));
    //             }
    //         }
    //     }
    // }

    // update ordensToUpdate;
}