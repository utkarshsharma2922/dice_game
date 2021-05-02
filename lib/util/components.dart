import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components{

  static void showMessage(String msg,BuildContext passedContext,String okBtnText,Function okBtnPressed) {
    showDialog(
      context: passedContext,
      builder: (BuildContext context) {
        return Container(
          height: 50,
          child: CupertinoAlertDialog(
            title: Center(child: Text(msg)),
            content: null,
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
               TextButton(
                child: Text(okBtnText),
                onPressed: () {
                  Navigator.of(context).pop();
                  okBtnPressed();
                },
              ),
            ],
          ),
        );
      },
    );
  }

}