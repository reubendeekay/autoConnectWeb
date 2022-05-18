import 'package:autoconnectweb/helpers/my_loader.dart';
import 'package:flutter/material.dart';

class WithdrawWidget extends StatefulWidget {
  const WithdrawWidget({
    Key? key,
    this.balance,
  }) : super(key: key);

  final double? balance;

  @override
  State<WithdrawWidget> createState() => _WithdrawWidgetState();
}

class _WithdrawWidgetState extends State<WithdrawWidget> {
  String? amount;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              margin: const EdgeInsets.only(bottom: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 70,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Withdraw Funds',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.pinkAccent),
                  ),
                  const Divider()
                ],
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  amount = value;
                });
                amount = value;
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Enter amount',
                  border: InputBorder.none,
                  fillColor: Colors.grey[200],
                  filled: true),
            ),
          ),
          Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: RaisedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        Navigator.of(context).pop();
                      },
                color: Colors.blue,
                child: isLoading
                    ? const MyLoader()
                    : const Text(
                        'Withdraw',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'The amount withdrawn will be credited to the phone number registered with the host provider account. Contact admin for any queries',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
