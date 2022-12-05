import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/driver_controller.dart';
import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/screens/admin/admin_view_driver.dart';
import 'package:delivery_app2/widgets/orders_widget.dart';
import 'package:delivery_app2/widgets/signup_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHome extends StatelessWidget {
  const DriverHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final DriverController driverController = Get.put(DriverController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Panel"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              //TODO : When admin assign driver, set the key using uid,
              //  then use streambuilder below
              //  check if order has the uid at the key, display the current driver's job

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("orders")
                    .where("driverAssigned", isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No current job"),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return OrderCard(
                            status: ds["status"],
                            senderArea: ds["senderArea"],
                            receiverArea: ds["receiverArea"],
                            orderNumber: ds["orderNumber"]);
                      });
                },
              ),

              ElevatedButton(
                  onPressed: () {}, child: const Text("Edit Profile")),
              ElevatedButton(
                  onPressed: () {}, child: const Text("View Past Jobs")),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => SignUpDataForm(userId: user.uid));
                  },
                  child: const Text("Edit My Data")),
              Row(
                children: [
                  Text(user.email!),
                  ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text("Log out")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
