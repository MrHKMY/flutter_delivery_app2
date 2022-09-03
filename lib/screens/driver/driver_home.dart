import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Panel"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    //Get.to(() => (AddLocationScreen()));
                  },
                  child: Text("View Jobs")),
              ElevatedButton(onPressed: () {}, child: Text("My Ongoing Jobs")),
              ElevatedButton(onPressed: () {}, child: Text("Edit Profile")),
              ElevatedButton(onPressed: () {}, child: Text("View Past Jobs")),
            ],
          ),
        ),
      ),
    );
  }
}
