import 'package:flutter/material.dart';

class DiceModel extends ChangeNotifier {
  static final DiceModel instance = DiceModel._internal();

  factory DiceModel() {
    return instance;
  }

  DiceModel._internal();
  int _value = 0;
  int get diceValue =>  _value;

  updateDiceValue({int value}){
    _value = value;
    notifyListeners();
  }
}
