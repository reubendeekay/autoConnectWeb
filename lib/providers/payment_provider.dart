import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoconnectweb/models/transaction_model.dart';
import 'package:flutter/foundation.dart';

class PaymentProvider with ChangeNotifier {
  List<TransactionModel>? _transactions;
  List<TransactionModel>? get transactions => _transactions;

  Future<void> getTransactions() async {
    final results =
        await FirebaseFirestore.instance.collection('transactions').get();

    _transactions = results.docs
        .map((doc) => TransactionModel.fromJson(doc.data()))
        .toList();

    notifyListeners();
  }
}
