import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String stateNegeri;
  final String area;

  LocationModel({
    required this.stateNegeri,
    required this.area,
  });

  @override
  List<Object> get props => [stateNegeri, area];

  LocationModel copyWith({
    String? stateNegeri,
    String? area,
  }) {
    return LocationModel(
      stateNegeri: stateNegeri ?? this.stateNegeri,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'state': stateNegeri});
    result.addAll({'area': area});

    return result;
  }

  factory LocationModel.fromSnapshot(DocumentSnapshot snapshot) {
    return LocationModel(
      stateNegeri: snapshot['state'] ?? '',
      area: snapshot['area'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(area: map['area'], stateNegeri: map["state"]);
  }

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source));

  @override
  String toString() => 'LocationModel(negeri: $stateNegeri, area: $area)';

  Map<String, Object> toDocument() {
    return {'state': stateNegeri, 'area': area};
  }
}
