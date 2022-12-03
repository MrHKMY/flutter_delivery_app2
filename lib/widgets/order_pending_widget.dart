import 'package:delivery_app2/screens/admin/admin_assign_driver.dart';
import 'package:delivery_app2/screens/admin/admin_view_driver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:delivery_app2/controller/order_controller.dart';

class OrderPendingCard extends StatelessWidget {
  String status;
  String senderArea;
  String receiverArea;
  int orderNumber;

  OrderPendingCard({
    Key? key,
    required this.status,
    required this.senderArea,
    required this.receiverArea,
    required this.orderNumber,
  }) : super(key: key);

  final OrderController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.blue[50],
        elevation: 3,
        child: Column(children: [
          GestureDetector(
              onTap: () {
                //Get.to(() => UpdateData(formModel: formModel));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Order: ${orderNumber.toString()}"),
                        GestureDetector(
                          onTap: () {
                            print("assigning driver");
                            Get.to(() => AdminAssignDriver(
                                  driverArea: senderArea,
                                  orderID: orderNumber.toString(),
                                ));
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red),
                              child: Text("Assign Driver")),
                        ),
                      ],
                    ),
                    Text("Status: $status"),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(senderArea),
                        const Icon(Icons.arrow_right_alt),
                        Text(receiverArea),
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
