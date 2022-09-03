import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/models/location_model.dart';

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
}
