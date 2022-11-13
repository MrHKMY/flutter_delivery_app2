import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/models/driver_model.dart';
import 'package:delivery_app2/models/location_model.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference location =
      FirebaseFirestore.instance.collection('location');

  Future<void> saveNewLocation(
    String state,
    String area,
  ) {
    return location.add({'state': state, 'area': area});
  }

  Stream<List<LocationModel>> getLocation() {
    return location.snapshots().map((snapshot) =>
        snapshot.docs.map((e) => LocationModel.fromSnapshot(e)).toList());
  }

  Stream<List<LocationModel>> getLocationFiltered(LocationModel locationModel) {
    print(locationModel.stateNegeri);
    return _firebaseFirestore
        .collection("location")
        .where('state', isEqualTo: locationModel.stateNegeri)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => LocationModel.fromSnapshot(e)).toList();
    });
  }

  Future<void> saveDriverInfo(DriverModel driverModel
      // String name,
      // String uid,
      // String phone,
      // int jobCompleted,
      // String state,
      // String area,
      // String status,
      ) {
    final user = FirebaseAuth.instance.currentUser!;
    return FirebaseFirestore.instance
        .collection('drivers')
        .doc(user.uid)
        .set(driverModel.toMap()
            //   {
            //   'name': name,
            //   'uid': uid,
            //   'phone': phone,
            //   'jobCompleted': jobCompleted,
            //   'state': state,
            //   'area': area,
            //   'status': status,
            // }
            );
  }

  saveOrder(OrderModel orderModel) async {
    await _firebaseFirestore.collection("orders").add(orderModel.toMap());
  }

  Stream<List<OrderModel>> getOrders() {
    return _firebaseFirestore.collection("orders").snapshots().map((snapshot) =>
        snapshot.docs.map((e) => OrderModel.fromSnapshot(e)).toList());
  }

  Stream<List<DriverModel>> getDrivers() {
    return _firebaseFirestore.collection("drivers").snapshots().map(
        (snapshot) =>
            snapshot.docs.map((e) => DriverModel.fromSnapshot(e)).toList());
  }

  saveTracking(int orderNumber) async {
    int added = orderNumber + 1;
    await _firebaseFirestore
        .collection("tracking")
        .doc("trackingDocumentID")
        .update({'orderNumber': added});
  }

  Future<void> updateDriverStatus(
    String driverModel,
    String field,
    String newValue,
  ) {
    return _firebaseFirestore
        .collection("drivers")
        .where("phone", isEqualTo: driverModel)
        .get()
        .then((value) => {
              value.docs.first.reference.update({field: newValue})
            });
  }
}
