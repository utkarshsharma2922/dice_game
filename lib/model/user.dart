
import 'dart:core';

import 'package:flutter/foundation.dart';

class GameUser extends ChangeNotifier{
  String id;
  int triesLeft;
  String results;
  int totalScore;

  GameUser({
   this.id,
    this.triesLeft,
    this.results,
    this.totalScore
});

  factory GameUser.fromJson(Map<String,dynamic>json){
    return GameUser(
      id:json["id"],
      triesLeft: json["tries_left"],
      results: json["results"],
      totalScore: json["total_score"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "tries_left": this.triesLeft,
      "results":this.results,
      "total_score":this.totalScore
    };
  }

}