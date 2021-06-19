({
    retrievePrice : function(component, event, helper) {
        helper.retrievePrice(component, event, helper);
    },

    handleChange : function(component, event, helper) {
        //console.log(event.getParam("checked"));
        component.set("v.opMercado", !event.getParam("checked"));
        helper.retrievePrice(component, event, helper);
    },

    handleSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Sucesso',
            message : "Registro inserido",
            type : "success",
            duration : "2000"
        });
        toastEvent.fire();

        var orderEvt = $A.get("e.c:OrdemEvent");
        orderEvt.setParams({
            "Context" : "TradeCmp"
        });
        orderEvt.fire();

        component.find('ordemField').forEach(function(f){
            f.reset();
        });

        // var navEvt = $A.get("e.force:navigateToSObject");
        // navEvt.setParams({
        //     "recordId": event.getParam().result.Id,
        //     "slideDevName": "related"
        // });
        // navEvt.fire();


        
        
    },

    handleOrder : function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");

        var action = component.get("c.getRecordTypeId");
        action.setParams({
            "ordemType" : "Compra"
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

                component.find('ordemForm').submit(fields);
            }else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action);
    },

    handleQuantPriceChange : function(component, event, helper) {
        var preco = component.get('v.price');
        var quantidade = component.get('v.quantidade');
        var total = preco * quantidade;
        component.set('v.total', total);
    },

    handleTotalChange : function(component, event, helper) {
        var preco = component.get('v.price');
        var total = component.get('v.total');
        var quantidade = total / preco;
        component.set('v.quantidade', quantidade);
    },
})
