import 'package:dice_game/model/user.dart';
import 'package:flutter/material.dart';

class GlobalData extends ChangeNotifier {
  static final GlobalData instance = GlobalData._internal();

  factory GlobalData() {
    return instance;
  }

  GlobalData._internal();

  GameUser userData;

  updateUserData({GameUser newData}) {
    this.userData = newData;
    notifyListeners();
  }

  removeUserData() {
    this.userData = null;
    notifyListeners();
  }
}
