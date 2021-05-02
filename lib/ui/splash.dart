import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/home_page.dart';
import 'package:dice_game/ui/widgets/dice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _checkNavigation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Dice(isMock: true,),
      ),
    );
  }

  _checkNavigation(){
    var user = Provider.of<AuthenticatorService>(context,listen: false).user;
    if (user != null){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => HomePage()));
    }else{
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => AuthenticationScreen()));
    }
  }
}
