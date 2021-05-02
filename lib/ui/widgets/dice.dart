import 'dart:async';
import 'dart:math';

import 'package:dice_game/util/constants.dart';
import 'package:dice_game/view_models/dice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Dice extends StatefulWidget {

  final Key key;
  final bool isMock;
  const Dice({this.key,this.isMock = false});

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
  Timer _timer;

  @override
  void initState() {
    if (widget.isMock){
      SchedulerBinding.instance.addPostFrameCallback((_) {
        roll();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentRollCount > numberOfRolls) {
        timer.cancel();
        _currentRollCount = 0;
        if (widget.isMock == false){
          Provider.of<DiceModel>(context,listen: false).updateDiceValue(value: _diceNumber + 1);
        }
      }else{
        if (this.mounted){
          setState(() {
            _diceNumber = Random().nextInt(5);
            _currentRollCount ++;
          });
        }
      }
    });
  }
}
