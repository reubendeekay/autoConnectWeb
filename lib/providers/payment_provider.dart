import 'package:autoconnectweb/models/invoice_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoconnectweb/models/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class PaymentProvider with ChangeNotifier {
  Invoice? _invoice;
  Invoice get invoice => _invoice!;

  Future<void> getTransactions() async {
    final results =
        await FirebaseFirestore.instance.collection('transacations').get();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    List<TransactionModel> transaction =
        results.docs.map((doc) => TransactionModel.fromJson(doc)).toList();

    _invoice = Invoice(
        info: InvoiceInfo(
            date: DateTime.now(),
            dueDate: DateTime.now(),
            description: 'All transacations to date',
            number: uid.substring(0, 11)),
        supplier: const Supplier(
            name: 'AutoConnect',
            address: 'Connecting Drivers to Mechanics',
            paymentInfo: 'Mpesa'),
        customer: const Customer(name: 'From all Customers'),
        items: transaction
            .map((k) => InvoiceItem(
                description: k.name!,
                date: k.createdAt!.toDate(),
                payer: k.customerName!,
                mechanic: k.mechanicName!,
                unitPrice: double.parse(k.amount!)))
            .toList());

    notifyListeners();
  }
}
