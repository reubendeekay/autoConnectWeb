import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? imageUrl;
  bool? isAdmin;

  final String? userId;

  bool? isMechanic;
  final bool? isOnline;
  final int? lastSeen;

  UserModel(
      {this.userId,
      this.email,
      this.password,
      this.phoneNumber,
      this.fullName,
      this.imageUrl,
      this.isMechanic,
      this.isOnline,
      this.isAdmin,
      this.lastSeen});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'userId': userId,
      'isOnline': true,
      'lastSeen': Timestamp.now().millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['profilePic'],
      userId: json.id,
      isMechanic: json['isMechanic'],
      isOnline: json['isOnline'],
      lastSeen: json['lastSeen'],
      isAdmin: json['isAdmin'],
    );
  }
}
