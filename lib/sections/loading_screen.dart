import 'package:autoconnectweb/helpers/my_loader.dart';
import 'package:autoconnectweb/main.dart';
import 'package:autoconnectweb/providers/auth_provider.dart';
import 'package:autoconnectweb/providers/payment_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class InitialLoadingScreen extends StatefulWidget {
  const InitialLoadingScreen({Key? key}) : super(key: key);

  @override
  State<InitialLoadingScreen> createState() => _InitialLoadingScreenState();
}

class _InitialLoadingScreenState extends State<InitialLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<AuthProvider>(context, listen: false)
          .getCurrentUser(FirebaseAuth.instance.currentUser!.uid);
      await Provider.of<PaymentProvider>(context, listen: false)
          .getTransactions();

      Get.off(() => const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyLoader(
          dotSize: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
