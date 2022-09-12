import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key, required this.theOrder})
      : super(key: key);
  final int theOrder;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    int orderNum = widget.theOrder - 1;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Confirmation Screen"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Thank You',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            const Text(
              'Your order has been successfully placed',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Order Number: ${orderNum.toString()}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        )));
    // body: StreamBuilder<QuerySnapshot>(
    //   stream: FirebaseFirestore.instance.collection("tracking").snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     } else if (snapshot.connectionState == ConnectionState.active ||
    //         snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.hasError) {
    //         return const Text('Error');
    //       } else if (snapshot.hasData) {
    //         int a = snapshot.data!.docs[0]['orderNumber'];
    //         a = a - 1;

    //         return Center(
    //             child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text(
    //               'Thank You',
    //               style:
    //                   TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
    //             ),
    //             const Text(
    //               'Your order has been successfully placed',
    //               style: TextStyle(fontSize: 18),
    //             ),
    //             Text(
    //               "Order Number: ${a.toString()}",
    //               style: const TextStyle(
    //                   fontWeight: FontWeight.bold, fontSize: 18),
    //             ),
    //           ],
    //         ));
    //       } else {
    //         return const Text('Empty data');
    //       }
    //     } else {
    //       return Text('State: ${snapshot.connectionState}');
    //     }
    //   },
    // ));
  }
}
