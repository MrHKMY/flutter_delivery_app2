import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final DatabaseService databaseService = DatabaseService();
  var getOrders = <OrderModel>[].obs;
  String data = "no data";
  bool isLoading = false;

  @override
  void onInit() {
    getOrders.bindStream(databaseService.getOrders());

    super.onInit();
  }
}
