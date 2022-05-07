// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:autoconnectweb/helpers/my_loader.dart';
import 'package:autoconnectweb/main.dart';
import 'package:autoconnectweb/providers/auth_provider.dart';
import 'package:autoconnectweb/responsive.dart';

import 'package:autoconnectweb/sections/auth/widgets/custom_button.dart';
import 'package:autoconnectweb/sections/auth/widgets/custom_textfield.dart';
import 'package:autoconnectweb/sections/auth/widgets/cutom_image.dart';
import 'package:autoconnectweb/sections/auth/widgets/text_widget.dart';
import 'package:autoconnectweb/sections/auth/widgets/wsized.dart';
import 'package:autoconnectweb/sections/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  String? email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Container(
            color: const Color.fromARGB(255, 40, 42, 57),
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 40, 42, 57),
                          shape: BoxShape.circle,
                        ),
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      TextWidget(
                        text: ' AutoConnect Admin.',
                        textcolor: Colors.white,
                        textsize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      // WSizedBox(wval: 0.1, hval: 0),
                      // TextWidget(
                      //   text: 'Home',
                      //   textcolor: Colors.grey,
                      //   textsize: 20,
                      //   fontWeight: FontWeight.normal,
                      // ),
                      // WSizedBox(wval: 0.1, hval: 0),
                      // TextWidget(
                      //   text: 'Join',
                      //   textcolor: Colors.grey,
                      //   textsize: 20,
                      //   fontWeight: FontWeight.normal,
                      // ),
                    ],
                  ),
                  WSizedBox(wval: 0, hval: 0.2),
                  Row(
                    children: [
                      WSizedBox(wval: 0.05, hval: 0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'ADMIN PANEL',
                            textcolor: Colors.grey,
                            textsize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          WSizedBox(wval: 0, hval: 0.02),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextWidget(
                                text: 'Sign in',
                                textcolor: Colors.white,
                                textsize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                          WSizedBox(wval: 0, hval: 0.03),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Not an Admin ?',
                                textcolor: Colors.grey,
                                textsize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                              TextWidget(
                                text: ' Request',
                                textcolor: Colors.blue,
                                textsize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                          WSizedBox(wval: 0, hval: 0.03),
                          CustomTextField(
                              borderradius: 20,
                              bordercolor: Color.fromARGB(255, 50, 54, 69),
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                              widh: Responsive.isMobile(context) ? 0.7 : 0.32,
                              height: 0.055,
                              icon: Icons.mail,
                              iconColor: Colors.grey,
                              hinttext: 'email',
                              hintColor: Colors.grey,
                              fontsize: 15,
                              obscureText: false),
                          WSizedBox(wval: 0, hval: 0.02),
                          CustomTextField(
                              borderradius: 20,
                              bordercolor: Color.fromARGB(255, 50, 54, 69),
                              widh: Responsive.isMobile(context) ? 0.7 : 0.32,
                              height: 0.055,
                              icon: Icons.lock,
                              onChanged: (val) {
                                setState(() {
                                  password = val;
                                });
                              },
                              iconColor: Colors.grey,
                              hinttext: 'password',
                              hintColor: Colors.grey,
                              fontsize: 15,
                              obscureText: true),
                          WSizedBox(wval: 0, hval: 0.04),
                          isLoading
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  width:
                                      MediaQuery.of(context).size.width * 0.32,
                                  child: RaisedButton(
                                    color: Color.fromARGB(255, 29, 144, 244),
                                    onPressed: () {},
                                    child: const MyLoader(),
                                  ),
                                )
                              : CustomButton(
                                  buttontext: 'Login ',
                                  width:
                                      Responsive.isMobile(context) ? 0.7 : 0.32,
                                  height: 0.065,
                                  bordercolor:
                                      Color.fromARGB(255, 29, 144, 244),
                                  borderradius: 25,
                                  fontsize: 12,
                                  fontweight: FontWeight.bold,
                                  fontcolor: Colors.white,
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    try {
                                      print(email!);
                                      print(password);
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .login(
                                              email: email!.trim(),
                                              password: password!.trim());
                                      Get.off(() => InitialLoadingScreen());
                                    } catch (e) {
                                      print(e);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                    // Get.toNamed(AppPages.initial);
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
          if (!Responsive.isMobile(context))
            CustomImageWidget(
              height: 1,
              width: Responsive.isTablet(context) ? 0.35 : 0.5,
              imgpath: 'assets/images/bg.png',
            ),
        ],
      ),
    );
  }
}
