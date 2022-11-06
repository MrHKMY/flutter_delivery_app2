import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:delivery_app2/models/location_model.dart';

class DriverModel extends Equatable {
  final String userId;
  final String name;
  final String phone;
  final String status;
  final int jobCompleted;
  final String state;
  final String area;
  final String onGoingJob;

  DriverModel(
      {required this.userId,
      required this.name,
      required this.phone,
      required this.status,
      required this.jobCompleted,
      required this.state,
      required this.area,
      required this.onGoingJob});

  @override
  List<Object> get props {
    return [
      userId,
      name,
      phone,
      status,
      jobCompleted,
      state,
      area,
      onGoingJob,
    ];
  }

  DriverModel copyWith({
    String? userId,
    String? name,
    String? phone,
    String? email,
    int? jobCompleted,
    String? state,
    String? area,
    String? onGoingJob,
  }) {
    return DriverModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: email ?? this.status,
      jobCompleted: jobCompleted ?? this.jobCompleted,
      state: state ?? this.state,
      area: area ?? this.area,
      onGoingJob: onGoingJob ?? this.onGoingJob,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'email': status});
    result.addAll({'jobCompleted': jobCompleted});
    result.addAll({'state': state});
    result.addAll({'area': area});
    result.addAll({'onGoingJob': onGoingJob});

    return result;
  }

  factory DriverModel.fromSnapshot(DocumentSnapshot snapshot) {
    return DriverModel(
      userId: snapshot['userId'] ?? '',
      name: snapshot['name'] ?? '',
      phone: snapshot['phone'] ?? '',
      status: snapshot['email'] ?? '',
      jobCompleted: snapshot['jobCompleted']?.toInt() ?? 0,
      state: snapshot['state'] ?? '',
      area: snapshot['area'] ?? '',
      onGoingJob: snapshot['onGoingJob'] ?? '',
    );
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone']?.toInt() ?? 0,
      status: map['email'] ?? '',
      jobCompleted: map['jobCompleted']?.toInt() ?? 0,
      state: map['state'] ?? '',
      area: map['area'] ?? '',
      onGoingJob: map['onGoingJob'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DriverModel.fromJson(String source) =>
      DriverModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DriverModel(userId: $userId, name: $name, phone: $phone, email: $status, jobCompleted: $jobCompleted, state: $state, area: $area, onGoingJob: $onGoingJob)';
  }
}
