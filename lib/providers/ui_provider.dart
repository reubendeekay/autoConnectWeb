import 'package:autoconnectweb/models/mechanic_model.dart';
import 'package:flutter/foundation.dart';

class UIProvider with ChangeNotifier {
  int selectedIndex = 0;
  MechanicModel? selecetdMechanic;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setSelectedMechanic(MechanicModel? mechanic) {
    selecetdMechanic = mechanic;
    notifyListeners();
  }
}
