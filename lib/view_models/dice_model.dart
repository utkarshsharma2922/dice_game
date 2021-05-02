import 'package:flutter/material.dart';

class DiceModel extends ChangeNotifier {
  static final DiceModel instance = DiceModel._internal();

  factory DiceModel() {
    return instance;
  }

  DiceModel._internal();
  int _value;
  int get diceValue =>  _value + 1;

  updateDiceValue({int value}){
    _value = value;
    notifyListeners();
  }
}
