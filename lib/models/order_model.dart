import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String senderName;
  final String senderPhone;
  final String senderAddress;
  final String senderState;
  final String senderArea;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final String receiverState;
  final String receiverArea;
  final int orderNumber;
  final String status;

  OrderModel({
    required this.senderName,
    required this.senderPhone,
    required this.senderAddress,
    required this.senderState,
    required this.senderArea,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    required this.receiverState,
    required this.receiverArea,
    required this.orderNumber,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      senderName,
      senderPhone,
      senderAddress,
      senderState,
      senderArea,
      receiverName,
      receiverPhone,
      receiverAddress,
      receiverState,
      receiverArea,
      orderNumber,
      status,
    ];
  }

  OrderModel copyWith({
    String? senderName,
    String? senderPhone,
    String? senderAddress,
    String? senderState,
    String? senderArea,
    String? receiverName,
    String? receiverPhone,
    String? receiverAddress,
    String? receiverState,
    String? receiverArea,
    int? orderNumber,
    String? status,
  }) {
    return OrderModel(
      senderName: senderName ?? this.senderName,
      senderPhone: senderPhone ?? this.senderPhone,
      senderAddress: senderAddress ?? this.senderAddress,
      senderState: senderState ?? this.senderState,
      senderArea: senderArea ?? this.senderArea,
      receiverName: receiverName ?? this.receiverName,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      receiverAddress: receiverAddress ?? this.receiverAddress,
      receiverState: receiverState ?? this.receiverState,
      receiverArea: receiverArea ?? this.receiverArea,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'senderName': senderName});
    result.addAll({'senderPhone': senderPhone});
    result.addAll({'senderAddress': senderAddress});
    result.addAll({'senderState': senderState});
    result.addAll({'senderArea': senderArea});
    result.addAll({'receiverName': receiverName});
    result.addAll({'receiverPhone': receiverPhone});
    result.addAll({'receiverAddress': receiverAddress});
    result.addAll({'receiverState': receiverState});
    result.addAll({'receiverArea': receiverArea});
    result.addAll({'orderNumber': orderNumber});
    result.addAll({'status': status});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      senderName: map['senderName'] ?? '',
      senderPhone: map['senderPhone'] ?? '',
      senderAddress: map['senderAddress'] ?? '',
      senderState: map['senderState'] ?? '',
      senderArea: map['senderArea'] ?? '',
      receiverName: map['receiverName'] ?? '',
      receiverPhone: map['receiverPhone'] ?? '',
      receiverAddress: map['receiverAddress'] ?? '',
      receiverState: map['receiverState'] ?? '',
      receiverArea: map['receiverArea'] ?? '',
      orderNumber: map['orderNumber']?.toInt() ?? 0,
      status: map['status'] ?? '',
    );
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot map) {
    return OrderModel(
      senderName: map['senderName'] ?? '',
      senderPhone: map['senderPhone'] ?? '',
      senderAddress: map['senderAddress'] ?? '',
      senderState: map['senderState'] ?? '',
      senderArea: map['senderArea'] ?? '',
      receiverName: map['receiverName'] ?? '',
      receiverPhone: map['receiverPhone'] ?? '',
      receiverAddress: map['receiverAddress'] ?? '',
      receiverState: map['receiverState'] ?? '',
      receiverArea: map['receiverArea'] ?? '',
      orderNumber: map['orderNumber']?.toInt() ?? 0,
      status: map['status'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(senderName: $senderName, senderPhone: $senderPhone, senderAddress: $senderAddress, senderState: $senderState, senderArea: $senderArea, receiverName: $receiverName, receiverPhone: $receiverPhone, receiverAddress: $receiverAddress, receiverState: $receiverState, receiverArea: $receiverArea, orderNumber: $orderNumber, status: $status)';
  }
}
