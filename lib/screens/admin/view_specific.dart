import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/location_controller.dart';
import 'package:delivery_app2/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ViewSpecificScreen extends StatelessWidget {
  ViewSpecificScreen({Key? key, required this.locationModel}) : super(key: key);

  final LocationModel locationModel;
  final LocationController locationController = Get.put(LocationController());
  //final dbRef = FirebaseDatabase.instance.reference().child("pets");

  // CollectionReference dbspecificlocation = FirebaseFirestore.instance
  //     .collection('location')
  //     .where("state", isEqualTo: locationModel.stateNegeri);

  getFilteredLocation() async {
    return FirebaseFirestore.instance
        .collection("location")
        .where("state", isEqualTo: locationModel.stateNegeri)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    print(locationModel.stateNegeri);
    return Scaffold(
      appBar: AppBar(title: Text("Specific Location")),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("location")
                .where("state", isEqualTo: locationModel.stateNegeri)
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
                    return Text(snapshot.data!.docs[index]['area']);
                  });
            },
          )),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final LocationModel locationModel;

  LocationCard({super.key, required this.locationModel});

  final LocationController locationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        GestureDetector(
            onTap: () {
              //Get.to(() => UpdateData(formModel: formModel));
            },
            child: Row(
              children: [
                Text("${(locationModel.stateNegeri.toString())} -- "),
                Text(locationModel.area.toString()),
              ],
            ))
      ]),
    );
  }
}
