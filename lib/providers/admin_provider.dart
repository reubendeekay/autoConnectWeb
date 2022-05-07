import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminProvider with ChangeNotifier {
  final _mechRef = FirebaseFirestore.instance.collection('mechanics');

  Future<void> blockMechanic(String mechanicId) async {
    await _mechRef.doc(mechanicId).update({'status': 'blocked'});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mechanicId)
        .update({'isMechanic': false});
    notifyListeners();
  }

  Future<void> approveMechanic(String mechanicId) async {
    await _mechRef.doc(mechanicId).update({'status': 'approved'});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mechanicId)
        .update({'isMechanic': true});

    notifyListeners();
  }

  Future<void> deleteMechanic(String mechanicId) async {
    await _mechRef.doc(mechanicId).delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mechanicId)
        .update({'isMechanic': false});
    notifyListeners();
  }

  Future<void> denyMechanic(String mechanicId) async {
    await _mechRef.doc(mechanicId).update({'status': 'denied'});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(mechanicId)
        .update({'isMechanic': false});
    notifyListeners();
  }
}
