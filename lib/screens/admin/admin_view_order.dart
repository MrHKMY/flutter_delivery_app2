import 'package:delivery_app2/controller/order_controller.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/widgets/orders_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AdminViewOrder extends StatefulWidget {
  const AdminViewOrder({Key? key}) : super(key: key);

  @override
  State<AdminViewOrder> createState() => _AdminViewOrderState();
}

class _AdminViewOrderState extends State<AdminViewOrder> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("View Orders")),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: orderController.getOrders.length,
                itemBuilder: (BuildContext context, int index) =>
                    //todo: Add CircularProgressIndicator for loading the data state
                    OrderCard(orderModel: orderController.getOrders[index])),
          )),
        ],
      ),
    );
  }
}
