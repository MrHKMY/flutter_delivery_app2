import 'package:delivery_app2/models/driver_model.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  final DatabaseService databaseService = DatabaseService();
  var getDrivers = <DriverModel>[].obs;
  var getDriversJob = <DriverModel>[].obs;
  String data = "no data";
  bool isLoading = false;

  @override
  void onInit() {
    getDrivers.bindStream(databaseService.getDrivers());
    getDriversJob.bindStream(databaseService.getDriversJob());

    super.onInit();
  }

  void updateDriverStatus(
    String driverModel,
    String field,
    String value,
    String fieldJob,
    String currentJobID,
  ) {
    databaseService.updateDriverStatus(
        driverModel, field, value, fieldJob, currentJobID);
  }
}
