global class SchedulerGetPreco implements Schedulable{

    public SchedulerGetPreco() {

    }

    global void execute(SchedulableContext sc){
        //BinanceAPI.updatePrices();
        SchedulerGetPrecoHelper.atualizaCotacaoAtualTodosMercadosAtivos();
    }
}