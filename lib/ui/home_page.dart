import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/shared_ui/loader.dart';
import 'package:dice_game/ui/widgets/dice.dart';
import 'package:dice_game/util/components.dart';
import 'package:dice_game/util/constants.dart';
import 'package:dice_game/view_models/dice_model.dart';
import 'package:dice_game/view_models/global_data.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Home",style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
            _scaffoldKey.currentState.openEndDrawer();
          })
        ],
      ),
      endDrawer: Drawer(
        child: _getDrawer(),
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
                fontSize: 22.0
              ),),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Tries Remaining: ${Provider.of<GlobalData>(context,listen: true).userData.triesLeft}",style: TextStyle(
                      color: THEME_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Your Score :  ${Provider.of<GlobalData>(context,listen: true).userData.totalScore}",style: TextStyle(
                      color: THEME_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),),
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
                return data.diceValue != 0 ? Text("You got   ${data.diceValue}",style: TextStyle(
                  color: THEME_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),):Container();
              }),
              SizedBox(
                height: 25,
              ),
              Consumer<GlobalData>(builder: (context,data,_){
                return data.userData.triesLeft > 0 ?
                Container(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),),
                    child: Text("Roll the dice",style: TextStyle(
                        color: Colors.white
                    ),),
                    onPressed: (){
                      diceKey.currentState.roll();
                    },
                  ),
                ):
                Text("You've completed the game",style: TextStyle(
                  color: THEME_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),);
              },)

            ],
          ),
        ),
      ),
    );
  }

  _onPressedLogout(){
    Components.showMessage(msg:"Are you sure you want to logout ?", passedContext:context, okBtnText:"Logout",okBtnPressed: () async {
      Loader.showLoader(context);
      await FirebaseAuth.instance.signOut();
      Provider.of<AuthenticatorService>(context,listen: false).user = null;
      Loader.hideLoader();
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (_) => AuthenticationScreen()));
    });
  }

  Widget _getDrawer(){
    return Container(

      color: THEME_COLOR.shade600,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TextButton(onPressed: (){}, child: Text(
            "Leaderboard",style: TextStyle(
            color: Colors.white,
            fontSize: 18
            ),
          )),
          Divider(),
          TextButton(onPressed: (){
            Navigator.pop(context);
            _onPressedLogout();
          }, child: Text(
            "Logout",style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
          )),
          Divider(),
          TextButton(onPressed: (){}, child: Text(
            "Version 1.1",style: TextStyle(
              color: Colors.white,
              fontSize: 18
          ),
          )),
          Divider(),

        ],
      ),
    );
  }
}
