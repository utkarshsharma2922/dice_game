import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/ui/authentication.dart';
import 'package:dice_game/ui/home_page.dart';
import 'package:dice_game/util/constants.dart';
import 'package:dice_game/view_models/dice_model.dart';
import 'package:dice_game/view_models/global_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  runApp(DiceApp());
}

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticatorService()),
        ChangeNotifierProvider(create: (_) => GlobalData()),
        ChangeNotifierProvider(create: (_) =>DiceModel())
      ],
      child: MaterialApp(
        title: 'Dice game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: THEME_COLOR,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

