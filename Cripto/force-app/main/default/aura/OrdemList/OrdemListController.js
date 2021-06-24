({
    handleInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Ordem', fieldName: 'Name', type: 'text'},
            {label: 'Tipo', fieldName: 'Tipo__c', type: 'text'},
            {label: 'Quantidade', fieldName: 'Quantidade__c', type: 'number', typeAttributes: { maximumSignificantDigits: 6}},
            {label: 'Preço', fieldName: 'Preco__c', type: 'number', typeAttributes: { maximumSignificantDigits: 6}},
            {label: 'Total', fieldName: 'Total__c', type: 'number', typeAttributes: { maximumSignificantDigits: 6}},
            {label: 'Op. Mercado?', fieldName: 'OperacaoMercado__c', type: 'boolean'},
            {label: 'Validade', fieldName: 'Validade__c', type: 'date'},
            {label: 'Status', fieldName: 'Status__c', type: 'text'}
        ]);

        var action = component.get("c.getOrderList");
        action.setParams({
            "markedId" : component.get('v.recordId')
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                var ordemList = response.getReturnValue();
                component.set('v.data', ordemList);
            }else{
                console.log("Erro: " + JSON.stringify(response.getError()));
            }
        });

        $A.enqueueAction(action);
    }
})