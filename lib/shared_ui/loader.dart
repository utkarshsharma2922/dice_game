import 'package:dice_game/util/constants.dart';
import 'package:flutter/material.dart';

class Loader{
  static OverlayEntry loader ;
  static showLoader(BuildContext context,{String text = "Please wait"}){
    if (loader != null){ // Loader is already running
      return;
    }
    OverlayState overlayState = Overlay.of(context);
    loader = OverlayEntry(builder: (context) => Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [ BoxShadow(
                color: Colors.black45,
                blurRadius: 10.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
              )
              ],
            ),
            height: 120,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10,),
                  CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(THEME_COLOR.withOpacity(0.65))),
                  SizedBox(height: 20,),
                  Text(text + "...")
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
    overlayState.insert(loader);
  }
  static hideLoader(){
    if (loader != null){
      loader.remove();
      loader = null;
    }
  }
}