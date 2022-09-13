import 'package:delivery_app2/controller/order_controller.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {
  final OrderModel orderModel;

  OrderCard({super.key, required this.orderModel});

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
                    Text("Order: ${orderModel.orderNumber.toString()}"),
                    Text("Status: ${orderModel.status}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${orderModel.senderArea}"),
                        const Icon(Icons.arrow_right_alt),
                        Text("${orderModel.receiverArea}"),
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
