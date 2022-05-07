import 'package:autoconnectweb/providers/auth_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:autoconnectweb/sections/auth/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          Visibility(
            visible: Responsive.isDesktop(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Text(
                "Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: "Search something...",
                  icon: Icon(CupertinoIcons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _nameAndProfilePicture(
              context,
              user!.fullName!,
              user.imageUrl!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameAndProfilePicture(
      BuildContext context, String username, String imageUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: PopupMenuButton(
              icon: const Icon(
                CupertinoIcons.chevron_down,
                size: 16,
              ),
              itemBuilder: (i) {
                return const [
                  PopupMenuItem(child: Text("Log out"), value: 1),
                ];
              },
              onSelected: (i) async {
                if (i == 1) {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => const SignInScreen());
                }
              },
            )),
        Visibility(
          visible: !Responsive.isMobile(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ),
      ],
    );
  }
}
