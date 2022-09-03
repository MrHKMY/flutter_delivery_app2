import 'package:delivery_app2/screens/admin/admin_home.dart';
import 'package:delivery_app2/screens/admin/admin_login.dart';
import 'package:delivery_app2/screens/customer/customer_home.dart';
import 'package:delivery_app2/screens/driver/driver_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (AdminHome()));
                  },
                  child: Text("Admin")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (DriverHome()));
                  },
                  child: Text("Driver")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (CustomerHome()));
                  },
                  child: Text("Customer")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => (AdminLoginScreen()));
                      },
                      child: Text("Admin Log in")),
                  ElevatedButton(
                      onPressed: () {
                        //Get.to(() => (CustomerHome()));
                      },
                      child: Text("Driver Log in"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
