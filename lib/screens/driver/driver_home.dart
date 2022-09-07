import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/widgets/signup_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

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
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => SignUpDataForm(userId: user.uid));
                  },
                  child: Text("Edit My Data")),
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
            ],
          ),
        ),
      ),
    );
  }
}
