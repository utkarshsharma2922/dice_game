import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Components{

  static void showMessage({String msg,BuildContext passedContext,String okBtnText = "Ok",Function okBtnPressed}) {
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
                  if (okBtnPressed != null){
                    okBtnPressed();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showErrorMessage({String msg,BuildContext passedContext,String okBtnText = "Ok",Function okBtnPressed}) {
    showDialog(
      context: passedContext,
      builder: (BuildContext context) {
        return Container(
          height: 50,
          child: CupertinoAlertDialog(
            title: Text("Oops"),
            content: Center(child: Text(msg)),
            actions: <Widget>[
              TextButton(
                child: Text(okBtnText),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (okBtnPressed != null){
                    okBtnPressed();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget getText(String text, Color color, double size,
      {TextAlign alignment = TextAlign.start,
        int maxLines,
        TextDecoration underlineStyle = TextDecoration.none}) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: alignment,
      style: TextStyle(
          color: color,
          fontSize: size,
          decoration: underlineStyle),
    );
  }
}