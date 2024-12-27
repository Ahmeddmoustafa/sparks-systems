part of 'graph_cubit.dart';

enum AppState {
  initial,
  loading,
  success,
  error,
}

class GraphState extends Equatable {
  final AppState appState;
  final String errorText;
  final List<OrderModel> orders;
  final double avgSales;
  final int numOfReturns;
  final int maxValue;
  final Map<int, int> graphData;

  const GraphState({
    this.appState = AppState.initial,
    this.errorText = "",
    this.orders = const [],
    this.avgSales = 0.0,
    this.numOfReturns = 0,
    this.graphData = const {},
    this.maxValue = 10,
  });

  GraphState copyWith(
      {AppState? newState,
      String? error,
      List<OrderModel>? newOrders,
      double? sales,
      int? newReturns,
      Map<int, int>? graphMap,
      int? max}) {
    return GraphState(
      appState: newState ?? appState,
      errorText: error ?? errorText,
      avgSales: sales ?? avgSales,
      numOfReturns: newReturns ?? numOfReturns,
      orders: newOrders ?? orders,
      graphData: graphMap ?? graphData,
      maxValue: max ?? maxValue,
    );
  }

  @override
  List<Object?> get props => [
        appState,
        errorText,
        orders,
        avgSales,
        numOfReturns,
        graphData,
        maxValue
      ];
}
