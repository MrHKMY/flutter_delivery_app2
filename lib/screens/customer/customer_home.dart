import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/screens/customer/confirmation_screen.dart';
import 'package:delivery_app2/screens/customer/create_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerHome extends StatelessWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Panel"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (CreateOrderScreen()));
                  },
                  child: Text("Crate Order")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (ConfirmationScreen()));
                  },
                  child: Text("Track Order")),
              ElevatedButton(onPressed: () {}, child: Text("Order History")),
            ],
          ),
        ),
      ),
    );
  }
}
