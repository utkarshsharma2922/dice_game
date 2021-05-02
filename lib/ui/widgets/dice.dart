import 'dart:async';
import 'dart:math';

import 'package:dice_game/util/constants.dart';
import 'package:flutter/material.dart';

class Dice extends StatefulWidget {

  final Key key;
  const Dice({this.key});

  @override
  DiceState createState() => DiceState();
}

class DiceState extends State<Dice> {

  final int numberOfRolls = 3;
  final List<String>numberPatterns = [
    '4',
    '2,6',
    '2,4,6',
    '0,2,6,8',
    '0,2,4,6,8',
    '0,1,2,6,7,8'
  ];

  int _currentRollCount = 0;
  int _diceNumber = 0;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amberAccent,width: 2.0)
      ),
      child: GridView.builder(gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context,index){
        print("Random Number : $_diceNumber");
        bool contains = numberPatterns[_diceNumber].split(",").map((e) => int.parse(e)).contains(index);
        return Container(
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: contains?Border.all(color: THEME_COLOR):Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5),
                color: contains ? THEME_COLOR : Colors.transparent
              ),
            ),
          ),
        );
      },itemCount: 9,),
    );
  }

  roll(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentRollCount > numberOfRolls) {
        timer.cancel();
        _currentRollCount = 0;
      }else{
        setState(() {
          _diceNumber = Random().nextInt(5);
          _currentRollCount ++;
        });
      }
    });
  }
}
