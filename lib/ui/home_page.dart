import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/shared_ui/loader.dart';
import 'package:dice_game/ui/widgets/dice.dart';
import 'package:dice_game/util/components.dart';
import 'package:dice_game/view_models/dice_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<DiceState> diceKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(icon: Icon(Icons.logout,color: Colors.white,), onPressed: (){
          _onPressedLogout();
        }),
        actions: [
          TextButton(
            child: Text("LeaderBoard",style: TextStyle(
              color: Colors.white
            ),),
            onPressed: (){
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ChangeNotifierProvider<DiceModel>(
            create: (_) =>DiceModel(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Welcome User",style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Tries: 10"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Your Score :  80"),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Dice(key: diceKey,),
                SizedBox(
                  height: 25,
                ),
                Consumer<DiceModel>(builder: (context,data,_){
                  return data.diceValue != 0 ? Text("You got   ${data.diceValue}"):Container();
                }),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  child: Text("Roll the dice",style: TextStyle(
                      color: Colors.white
                  ),),
                  onPressed: (){
                    diceKey.currentState.roll();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPressedLogout(){
    Components.showMessage("Are you sure you want to logout ?", context, "Logout", () async {
      Loader.showLoader(context);
      await FirebaseAuth.instance.signOut();
      Provider.of<AuthenticatorService>(context,listen: false).user = null;
      Loader.hideLoader();
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => AuthenticationScreen()));
    });
  }
}
