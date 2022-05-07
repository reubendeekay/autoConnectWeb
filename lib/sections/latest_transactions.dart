import 'package:autoconnectweb/data/mock_data.dart';
import 'package:autoconnectweb/providers/payment_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:autoconnectweb/styles/styles.dart';
import 'package:autoconnectweb/widgets/category_box.dart';
import 'package:autoconnectweb/widgets/currency_text.dart';
import 'package:flutter/material.dart';
import 'package:autoconnectweb/models/enums/transaction_type.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class LatestTransactions extends StatelessWidget {
  LatestTransactions({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<PaymentProvider>(context).transactions;
    return CategoryBox(
      title: "Latest Transactions",
      suffix: TextButton(
        child: Text(
          "",
          style: TextStyle(
            color: Styles.defaultRedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {},
      ),
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: transactions!.length,
            itemBuilder: (context, index) {
              final data = transactions[index];
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
                                backgroundImage: NetworkImage(data.profilePic!),
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
                          currency: "\$",
                          amount: double.parse(data.amount!),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
