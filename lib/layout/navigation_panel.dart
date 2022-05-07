import 'package:autoconnectweb/models/enums/navigation_items.dart';
import 'package:autoconnectweb/providers/ui_provider.dart';
import 'package:autoconnectweb/responsive.dart';
import 'package:autoconnectweb/widgets/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationPanel extends StatefulWidget {
  final Axis axis;
  const NavigationPanel({Key? key, required this.axis}) : super(key: key);

  @override
  State<NavigationPanel> createState() => _NavigationPanelState();
}

class _NavigationPanelState extends State<NavigationPanel> {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return Container(
      constraints: const BoxConstraints(minWidth: 80),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: Responsive.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
          : const EdgeInsets.all(10),
      child: widget.axis == Axis.vertical
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logo.png", height: 50),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            uiProvider.setSelectedIndex(e.index);
                            setState(() {});
                          },
                          icon: e.icon,
                          isActive: e.index == uiProvider.selectedIndex,
                        ),
                      )
                      .toList(),
                ),
                Container()
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset("assets/logo.png", height: 20),
                Row(
                  children: NavigationItems.values
                      .map(
                        (e) => NavigationButton(
                          onPressed: () {
                            uiProvider.setSelectedIndex(e.index);
                            setState(() {});
                          },
                          icon: e.icon,
                          isActive: e.index == uiProvider.selectedIndex,
                        ),
                      )
                      .toList(),
                ),
                Container()
              ],
            ),
    );
  }
}
