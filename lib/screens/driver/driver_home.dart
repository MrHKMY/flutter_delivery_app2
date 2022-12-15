import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/driver_controller.dart';
import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/screens/admin/admin_view_driver.dart';
import 'package:delivery_app2/screens/driver/driver_order_detail.dart';
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("orders")
                    .where("driverAssigned", isEqualTo: user.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No current job"),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          if (ds["status"] == "In-Progress" ||
                              ds["status"] == "Picked-Up") {
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => DriverOrderDetail(
                                    orderNumber: ds["orderNumber"]));
                              },
                              child: OrderCard(
                                  status: ds["status"],
                                  senderArea: ds["senderArea"],
                                  receiverArea: ds["receiverArea"],
                                  orderNumber: ds["orderNumber"]),
                            );
                          } else {
                            return Center(child: Text(" No current job"));
                          }
                        });
                  } else {
                    return const Text("Something went wrong");
                  }
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
