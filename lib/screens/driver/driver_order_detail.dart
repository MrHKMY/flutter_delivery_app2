import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DriverOrderDetail extends StatefulWidget {
  int orderNumber;

  DriverOrderDetail({
    Key? key,
    required this.orderNumber,
  }) : super(key: key);

  @override
  State<DriverOrderDetail> createState() => _DriverOrderDetailState();
}

class _DriverOrderDetailState extends State<DriverOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("orderNumber", isEqualTo: widget.orderNumber)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          } else if (snapshot.hasData) {
            return SizedBox(
              height: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return OrderDetailWidget(
                      pName: ds["senderName"],
                      pPhone: ds["senderPhone"],
                      pLocation: ds["senderAddress"],
                      dName: ds["receiverName"],
                      dPhone: ds["receiverPhone"],
                      dLocation: ds["receiverAddress"],
                    );
                  }),
            );
          } else {
            return Row(
              children: const [
                Text("Something went wrong"),
              ],
            );
          }
        },
      ),
    );
  }
}

class OrderDetailWidget extends StatefulWidget {
  String pName;
  String pPhone;
  String pLocation;
  String dName;
  String dPhone;
  String dLocation;

  OrderDetailWidget({
    Key? key,
    required this.pName,
    required this.pPhone,
    required this.pLocation,
    required this.dName,
    required this.dPhone,
    required this.dLocation,
  }) : super(key: key);

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue[50],
          elevation: 3,
          child: Column(children: [
            const Text(
              "PICK-UP",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
            Text(widget.pName),
            Text(widget.pPhone),
            Text(widget.pLocation),
            ElevatedButton(
                onPressed: () {}, child: const Text("Confirm picked-up")),
          ]),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.yellow[50],
          elevation: 3,
          child: Column(children: [
            const Text(
              "DESTINATION",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 2,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.black,
            ),
            Text(widget.dName),
            Text(widget.dPhone),
            Text(widget.dLocation),
            ElevatedButton(onPressed: () {}, child: const Text("Delivered"))
          ]),
        ),
      ],
    );
  }
}
