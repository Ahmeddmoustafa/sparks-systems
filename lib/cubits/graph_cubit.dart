import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sparks_app/data/data_repository.dart';
import 'package:sparks_app/resources/Managers/strings_manager.dart';
import 'package:sparks_app/models/order_model.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit({required this.dataRepository}) : super(const GraphState());

  final DataRepository dataRepository;

  void loadGraphData() async {
    try {
      final List<OrderModel> orders = await dataRepository.loadJsonData();
      emit(state.copyWith(newOrders: orders, newState: AppState.success));
    } catch (err) {
      emit(state.copyWith(
        newOrders: [],
        error: "Unable to load the orders",
        newState: AppState.error,
      ));
    }
  }

  void calculateMetrics() {
    int numOfReturns = 0;
    double totalSales = 0;
    int maxYvalue = 0;
    final Map<int, int> map = {...state.graphData};

    for (OrderModel order in state.orders) {
      // Calculate returns
      if (order.status == AppStrings.returnedType) numOfReturns += 1;

      // Calculate total sales for the orders
      if (order.status == AppStrings.orderedType ||
          order.status == AppStrings.deliveredType) {
        totalSales += order.price;
      }

      //Calculate graph data per each month
      map[order.registered.month] = map[order.registered.month] == null
          ? 1
          : map[order.registered.month]! + 1;

      //Calculate maximum value of the graph
      maxYvalue = map[order.registered.month]! > maxYvalue
          ? map[order.registered.month]!
          : maxYvalue;
    }
    // print(maxYvalue);
    emit(state.copyWith(
      newReturns: numOfReturns,
      sales: totalSales / state.orders.length,
      graphMap: map,
      newState: AppState.initial,
      max: maxYvalue,
    ));
  }
}
