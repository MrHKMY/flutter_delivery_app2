import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/models/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference location =
      FirebaseFirestore.instance.collection('location');
  final user = FirebaseAuth.instance.currentUser!;

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

  Future<void> saveDriverInfo(
    String name,
    String uid,
    String phone,
    int jobCompleted,
    String state,
    String area,
    String status,
  ) {
    return FirebaseFirestore.instance.collection('drivers').doc(user.uid).set({
      'name': name,
      'uid': uid,
      'phone': phone,
      'jobCompleted': jobCompleted,
      'state': state,
      'area': area,
      'status': status,
    });
  }
}
