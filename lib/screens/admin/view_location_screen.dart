import 'package:delivery_app2/controller/location_controller.dart';
import 'package:delivery_app2/models/location_model.dart';
import 'package:delivery_app2/screens/admin/view_specific.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ViewLocationScreen extends StatelessWidget {
  ViewLocationScreen({Key? key}) : super(key: key);

  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Location")),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: locationController.getLocation.length,
                itemBuilder: (BuildContext context, int index) =>
                    //todo: Add CircularProgressIndicator for loading the data state
                    LocationCard(
                        locationModel: locationController.getLocation[index])),
          )),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final LocationModel locationModel;

  LocationCard({super.key, required this.locationModel});

  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        GestureDetector(
            onTap: () {
              //Get.to(() => UpdateData(formModel: formModel));
            },
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      print(locationModel.stateNegeri.toString());
                      Get.to(() => ViewSpecificScreen(
                            locationModel: locationModel,
                          ));
                    },
                    child:
                        Text("${(locationModel.stateNegeri.toString())} -- ")),
                Text(locationModel.area.toString()),
              ],
            ))
      ]),
    );
  }
}
