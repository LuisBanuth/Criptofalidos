({
    retrievePrice : function(component, event, helper) {
        var action = component.get("c.getPrice");
        action.setParams({
            "mercadoId" : component.get("v.recordId")
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
               component.set('v.preco', response.getReturnValue());
               component.set('v.price', response.getReturnValue());
            }else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action);
    },
    handleOrder : function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");

        var action = component.get("c.getRecordTypeId");
        action.setParams({
            "ordemType" : component.get('v.recordTipo')
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var rtId = response.getReturnValue();
                fields["RecordTypeId"] = rtId;
                fields["Status__c"] = fields["OperacaoMercado__c"] ? "Executada" : "Aguardando";
                fields["Carteira__c"] = "a025e000001qle5AAA";

                if(fields["Preco__c"] == undefined){
                    fields["Preco__c"] = component.get("v.preco");
                }

                if(component.get('v.recordTipo') == 'Compra'){
                    component.find('ordemFormCompra').submit(fields);
                }else{
                    component.find('ordemFormVenda').submit(fields);
                }
            }else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action);
    },
})