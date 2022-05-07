import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? id;
  final String? profilePic;
  final String? amount;
  final String? name;
  final Timestamp? createdAt;
  final String? mechanicId;

  TransactionModel(
      {this.id,
      this.profilePic,
      this.amount,
      this.name,
      this.createdAt,
      this.mechanicId});

  factory TransactionModel.fromJson(dynamic json) {
    return TransactionModel(
      id: json['id'],
      profilePic: json['profilePic'],
      amount: json['amount'],
      name: json['name'],
      createdAt: json['createdAt'],
      mechanicId: json['mechanicId'],
    );
  }
}
