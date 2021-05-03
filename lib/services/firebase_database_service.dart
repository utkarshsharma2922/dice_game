import 'package:dice_game/model/user.dart';
import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/view_models/global_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class FirebaseDBService{

  static final FirebaseDBService instance = FirebaseDBService._internal();

  factory FirebaseDBService() {
    return instance;
  }

  FirebaseDBService._internal();

  final databaseRef = FirebaseDatabase.instance.reference();//database reference object
  final usersRef = FirebaseDatabase.instance.reference().child("users");

   createUserData() async{
     var user = GameUser(
       id: AuthenticatorService().user.uid,
       email: AuthenticatorService().user.email ,
       triesLeft: 10,
       results: "",
       totalScore: 0
     );
    await usersRef.child(AuthenticatorService().user.uid).update(user.toJson());
    GlobalData.instance.updateUserData(newData: user);
   }

   fetchUserData() async{
     await usersRef.child(AuthenticatorService().user.uid).once().then((DataSnapshot data){
       if (data.value != null){
         Map<String,dynamic> userMap = Map<String, dynamic>.from(data.value);
         GameUser user = GameUser.fromJson(userMap);
         GlobalData.instance.updateUserData(newData: user);
         print(data);
       }
     });
   }
   
   updateUserScore({int diceValue})async{
     var userData = GlobalData().userData;
     GameUser newData = GameUser(
       id:  userData.id,
       email: userData.email,
       triesLeft: userData.triesLeft,
       results: userData.results,
       totalScore: userData.totalScore
     );
     newData.triesLeft -= 1;
     newData.totalScore = newData.totalScore + diceValue;
      var resultsArray = newData.results.split(",");
      resultsArray.remove("");
      resultsArray.add("$diceValue");
      newData.results = resultsArray.join(",");
      GlobalData.instance.updateUserData(newData: newData);
     await usersRef.child(AuthenticatorService().user.uid).update(newData.toJson());
   }

   Future<Map<String,dynamic>>fetchAllUsersSortedByMaxScore() async{
     DataSnapshot data = await usersRef.orderByChild("total_score").limitToFirst(10).once();
     return Map<String,dynamic>.from(data.value);
   }
}