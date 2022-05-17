import 'package:autoconnectweb/firebase_options.dart';
import 'package:autoconnectweb/layout/app_layout.dart';
import 'package:autoconnectweb/models/enums/card_type.dart';
import 'package:autoconnectweb/providers/admin_provider.dart';
import 'package:autoconnectweb/providers/auth_provider.dart';
import 'package:autoconnectweb/providers/chat_provider.dart';
import 'package:autoconnectweb/providers/mechanic_provider.dart';
import 'package:autoconnectweb/providers/payment_provider.dart';
import 'package:autoconnectweb/providers/ui_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:autoconnectweb/sections/auth/screens/documents/documents_overview.dart';
import 'package:autoconnectweb/sections/auth/screens/signin_screen.dart';
import 'package:autoconnectweb/sections/expense_income_chart.dart';
import 'package:autoconnectweb/sections/latest_transactions.dart';
import 'package:autoconnectweb/sections/loading_screen.dart';
import 'package:autoconnectweb/sections/statics_by_category.dart';
import 'package:autoconnectweb/sections/upgrade_pro_section.dart';
import 'package:autoconnectweb/sections/users/user_management.dart';
import 'package:autoconnectweb/sections/your_cards_section.dart';
import 'package:autoconnectweb/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const FintechDasboardApp());
}

class FintechDasboardApp extends StatelessWidget {
  const FintechDasboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MechanicProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => AdminProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AutoConnect Admin',
        theme: ThemeData(
          scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
          scrollbarTheme: Styles.scrollbarTheme,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const InitialLoadingScreen();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final index = Provider.of<UIProvider>(context).selectedIndex;
    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          content: options[index],
        ),
      ),
    );
  }
}

List<Widget> options = const [
  Dashboard(),
  UserManagement(),
  DocumentOverview(),
];

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Main Panel
        Expanded(
          child: Column(
            children: [
              const Expanded(
                flex: 2,
                child: ExpenseIncomeCharts(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Styles.defaultPadding,
                  ),
                  child: const BannerSection(),
                ),
              ),
              Expanded(
                flex: 2,
                child: LatestTransactions(),
              ),
            ],
          ),
          flex: 5,
        ),
        // Right Panel
        Visibility(
          visible: Responsive.isDesktop(context),
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: Styles.defaultPadding),
              child: Column(
                children: const [
                  CardsSection(),
                  Expanded(
                    child: StaticsByCategory(),
                  ),
                ],
              ),
            ),
            flex: 2,
          ),
        )
      ],
    );
  }
}
