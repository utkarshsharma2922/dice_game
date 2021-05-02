import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/shared_ui/loader.dart';
import 'package:dice_game/ui/widgets/dice.dart';
import 'package:dice_game/util/components.dart';
import 'package:dice_game/util/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tries: 10"),
                  Text("Your Score :  80")
                ],
              ),
              Dice()
            ],
          ),
        ),
      ),
    );
  }

  _onPressedLogout(){
    Components.showMessage("Are you sure you want to logout ?", context, "Logout", () async {
      Loader.showLoader(context);
      await FirebaseAuth.instance.signOut();
      Loader.hideLoader();
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => AuthenticationScreen()));
    });
  }
}
