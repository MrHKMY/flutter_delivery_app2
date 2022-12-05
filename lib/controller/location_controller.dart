import 'package:delivery_app2/models/location_model.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final DatabaseService databaseService = DatabaseService();
  var getLocation = <LocationModel>[].obs;
  var getLocationSpecific = <LocationModel>[].obs;

  var getSpecific = <LocationModel>[].obs;

  @override
  void onInit() {
    getLocation.bindStream(databaseService.getLocation());
    // getSpecific(LocationModel locationModel) {
    //   getLocationSpecific
    //       .bindStream(databaseService.getLocationFiltered(locationModel));
    // }

    super.onInit();
  }
}
