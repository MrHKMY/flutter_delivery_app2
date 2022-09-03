import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/screens/admin/view_location_screen.dart';
import 'package:delivery_app2/screens/admin/view_specific.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(user.email!),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Text("Log out")),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (AddLocationScreen()));
                  },
                  child: Text("Add Location")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => (ViewLocationScreen()));
                  },
                  child: Text("View Location")),
              ElevatedButton(
                  onPressed: () {},
                  child: Text("View Order/Specific State only")),
              ElevatedButton(onPressed: () {}, child: Text("View All Driver")),
              ElevatedButton(onPressed: () {}, child: Text("View Reports")),
              ElevatedButton(onPressed: () {}, child: Text("Generate pdf")),
            ],
          ),
        ),
      ),
    );
  }
}
