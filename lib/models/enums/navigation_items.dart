import 'package:flutter/material.dart';

enum NavigationItems {
  home,
  users,
  panel,
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Icons.home;
      case NavigationItems.panel:
        return Icons.bar_chart;

      case NavigationItems.users:
        return Icons.person;
      default:
        return Icons.person;
    }
  }
}
