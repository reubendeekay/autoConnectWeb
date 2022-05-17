import 'package:autoconnectweb/models/mechanic_model.dart';
import 'package:autoconnectweb/sections/auth/screens/mechanic_profile/mechanic_profile_screen.dart';
import 'package:autoconnectweb/styles/styles.dart';
import 'package:autoconnectweb/models/enums/card_type.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  String get securedString {
    if (length > 4) {
      return "**** ${substring(length - 4)}";
    } else {
      return this;
    }
  }
}

class TopMechanicWidget extends StatelessWidget {
  final MechanicModel mechanic;

  const TopMechanicWidget({Key? key, required this.mechanic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctz) => Dialog(
                  child: SizedBox(
                    width: 400,
                    child: MechanicProfileScreen(
                      mechanic: mechanic,
                    ),
                  ),
                ));
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Styles.defaultLightWhiteColor,
          borderRadius: Styles.defaultBorderRadius,
        ),
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(mechanic.profile!),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mechanic.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    mechanic.phone!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}
