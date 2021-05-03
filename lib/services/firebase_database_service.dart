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
       triesLeft: 10,
       results: "",
       totalScore: 0
     );
    await usersRef.child(AuthenticatorService().user.uid).update(user.toJson());
    GlobalData.instance.updateUserData(newData: user);

   }

}