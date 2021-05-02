import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/home_page.dart';
import 'package:dice_game/util/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

      ],
      child: MaterialApp(
        title: 'Dice game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: THEME_COLOR,
        ),
        home: HomePage(),
      ),
    );
  }
}

