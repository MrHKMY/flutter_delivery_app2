import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/driver_controller.dart';
import 'package:delivery_app2/controller/order_controller.dart';
import 'package:delivery_app2/models/driver_model.dart';
import 'package:delivery_app2/screens/admin/admin_view_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AdminAssignDriver extends StatefulWidget {
  AdminAssignDriver({
    Key? key,
    required this.driverArea,
    required this.orderID,
  }) : super(key: key);

  String driverArea;
  String orderID;

  @override
  State<AdminAssignDriver> createState() => _AdminAssignDriverState();
}

class _AdminAssignDriverState extends State<AdminAssignDriver> {
  final DriverController driverController = Get.put(DriverController());
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Drivers")),
      body: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("drivers")
                .where("area", isEqualTo: widget.driverArea)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No data"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    if (ds["onGoingJob"] == "No") {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text("${ds["name"]}"),
                                Text("${ds["phone"]}"),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  orderController.updateOrderStatus(
                                      widget.orderID,
                                      'status',
                                      "In-Progress",
                                      "driverAssigned",
                                      "${ds["userId"]}");

                                  driverController.updateDriverStatus(
                                      "${ds["phone"]}",
                                      'onGoingJob',
                                      "Yes",
                                      "currentJobID",
                                      widget.orderID);

                                  Get.off(() => (AdminViewOrder()));
                                  print("Driver assigned.");
                                },
                                child: Text("Select")),
                          ],
                        ),
                      );
                    } else {
                      return Text("No driver available");
                    }
                  });
            },
          ),
        )
      ]),
    );
  }
}
