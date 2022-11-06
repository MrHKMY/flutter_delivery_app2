import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/order_controller.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/widgets/orders_widget.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Orders"),
          bottom: TabBar(
            unselectedLabelColor: Colors.white,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue[900]),
            tabs: [
              Tab(
                child: Container(
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Pending"),
                  ),
                ),
              ),
              const Tab(
                text: "In-Progress",
              ),
              const Tab(
                text: "Completed",
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          Column(
            children: [
              Expanded(
                  child: Obx(
                () => ListView.builder(
                    itemCount: orderController.getOrders.length,
                    itemBuilder: (BuildContext context, int index) =>
                        //todo: Add CircularProgressIndicator for loading the data state
                        OrderCard(
                            orderModel: orderController.getOrders[index])),
              )),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("orders")
                .where("status", isEqualTo: "New Order")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.length <= 0) {
                return Center(
                  child: Text("No data"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                        snapshot.data!.docs[index]['orderNumber'].toString());
                  });
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("orders")
                .where("status", isEqualTo: "Complete")
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.length <= 0) {
                return Center(
                  child: Text("No data"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(
                        snapshot.data!.docs[index]['orderNumber'].toString());
                  });
            },
          ),
        ]),
      ),
    ));
  }
}
