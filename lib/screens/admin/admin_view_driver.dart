import 'package:delivery_app2/controller/driver_controller.dart';
import 'package:delivery_app2/models/driver_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AdminViewDriver extends StatefulWidget {
  const AdminViewDriver({Key? key}) : super(key: key);

  @override
  State<AdminViewDriver> createState() => _AdminViewDriverState();
}

class _AdminViewDriverState extends State<AdminViewDriver> {
  final DriverController driverController = Get.put(DriverController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List of Drivers")),
      body: Column(children: [
        Expanded(
            child: Obx(() => ListView.builder(
                itemCount: driverController.getDrivers.length,
                itemBuilder: (BuildContext context, int index) => DriverCard(
                    driverModel: driverController.getDrivers[index]))))
      ]),
    );
  }
}

class DriverCard extends StatelessWidget {
  final DriverModel driverModel;

  DriverCard({super.key, required this.driverModel});

  final DriverController driverController = Get.find();

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
                Text("${(driverModel.name.toString())} -- "),
                GestureDetector(
                    onTap: () {
                      print(driverModel.name.toString());
                      // Get.to(() => ViewSpecificScreen(
                      //       locationModel: locationModel,
                      //     ));
                    },
                    child: Text("${(driverModel.area.toString())} -- ")),
                Text(driverModel.status.toString()),
              ],
            ))
      ]),
    );
  }
}
