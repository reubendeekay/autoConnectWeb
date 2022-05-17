import 'package:autoconnectweb/models/transaction_model.dart';
import 'package:autoconnectweb/providers/invoice_provider.dart';
import 'package:autoconnectweb/providers/payment_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:autoconnectweb/styles/styles.dart';
import 'package:autoconnectweb/widgets/category_box.dart';
import 'package:autoconnectweb/widgets/currency_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class LatestTransactions extends StatelessWidget {
  LatestTransactions({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      title: "Latest Transactions",
      suffix: TextButton(
        child: Text(
          "All Transactions",
          style: TextStyle(
            color: Styles.defaultRedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () async {
          final invoice =
              Provider.of<PaymentProvider>(context, listen: false).invoice;

          await PdfInvoiceApi.generate(invoice);

          // PdfApi.openFile(pdfFile);
        },
      ),
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('transacations')
                  .orderBy('createdAt')
                  .limit(10)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'No transactions yet',
                    ),
                  );
                }
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = TransactionModel.fromJson(docs[index]);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data.profilePic!),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    data.name!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              intl.DateFormat.MMMd()
                                  .add_jm()
                                  .format(data.createdAt!.toDate()),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Visibility(
                            visible: !Responsive.isMobile(context),
                            child: Expanded(
                              child: Text(
                                "ID: ${data.id}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CurrencyText(
                                fontSize: 16,
                                currency: "KES ",
                                amount: double.parse(data.amount!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
