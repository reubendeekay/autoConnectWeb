import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autoconnectweb/styles/styles.dart';
import 'package:autoconnectweb/widgets/bar_chart_with_title.dart';
import 'package:flutter/material.dart';

class ExpenseIncomeCharts extends StatelessWidget {
  const ExpenseIncomeCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.doc('account/finances').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          DocumentSnapshot doc = snapshot.data!;
          return Row(
            children: [
              Flexible(
                child: BarChartWithTitle(
                  title: "Balance",
                  amount: double.parse(doc['balance'].toString()),
                  barColor: Styles.defaultBlueColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: BarChartWithTitle(
                  title: "Revenue",
                  amount: double.parse(doc['totalRevenue'].toString()),
                  barColor: Styles.defaultRedColor,
                ),
              ),
            ],
          );
        });
  }
}
