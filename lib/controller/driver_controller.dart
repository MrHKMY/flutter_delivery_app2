import 'package:delivery_app2/models/driver_model.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  final DatabaseService databaseService = DatabaseService();
  var getDrivers = <DriverModel>[].obs;
  String data = "no data";
  bool isLoading = false;

  @override
  void onInit() {
    getDrivers.bindStream(databaseService.getDrivers());

    super.onInit();
  }
}
