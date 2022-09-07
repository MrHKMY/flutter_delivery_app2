import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:delivery_app2/models/location_model.dart';

class DriverModel extends Equatable {
  final String userId;
  final String name;
  final int phone;
  final String email;
  final int jobCompleted;
  final String state;
  final String area;

  DriverModel(
      {required this.userId,
      required this.name,
      required this.phone,
      required this.email,
      required this.jobCompleted,
      required this.state,
      required this.area});

  @override
  List<Object> get props {
    return [
      userId,
      name,
      phone,
      email,
      jobCompleted,
      state,
      area,
    ];
  }

  DriverModel copyWith({
    String? userId,
    String? name,
    int? phone,
    String? email,
    int? jobCompleted,
    String? state,
    String? area,
  }) {
    return DriverModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      jobCompleted: jobCompleted ?? this.jobCompleted,
      state: state ?? this.state,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'email': email});
    result.addAll({'jobCompleted': jobCompleted});
    result.addAll({'state': state});
    result.addAll({'area': area});

    return result;
  }

  factory DriverModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DriverModel(
      userId: snapshot['userId'] ?? '',
      name: snapshot['name'] ?? '',
      phone: snapshot['phone']?.toInt() ?? 0,
      email: snapshot['email'] ?? '',
      jobCompleted: snapshot['jobCompleted']?.toInt() ?? 0,
      state: snapshot['state'] ?? '',
      area: snapshot['area'] ?? '',
    );
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone']?.toInt() ?? 0,
      email: map['email'] ?? '',
      jobCompleted: map['jobCompleted']?.toInt() ?? 0,
      state: map['state'] ?? '',
      area: map['area'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverModel(userId: $userId, name: $name, phone: $phone, email: $email, jobCompleted: $jobCompleted, state: $state, area: $area)';
  }
}
