import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/ui/home_page.dart';
import 'package:dice_game/ui/shared_ui/loader.dart';
import 'package:dice_game/ui/widgets/custom_textfield.dart';
import 'package:dice_game/ui/widgets/dice.dart';
import 'package:dice_game/util/components.dart';
import 'package:dice_game/util/constants.dart';
import 'package:dice_game/util/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Dice game",style: TextStyle(
          color: Colors.white
        ),)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 45,
              ),
              Dice(isMock: true,),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomTextField(
                    textEditingController: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    fieldValidator: Validator().emailValidation,
                    icon: Icons.email,
                    hint: "Email ",
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: CustomTextField(
                    textEditingController: _passwordController,
                    keyboardType: TextInputType.text,
                    fieldValidator: Validator().passwordValidation,
                    obscureText: true,
                    icon: Icons.lock,
                    hint: "Password",
                  )
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),),
                  child: Text("Login",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                  ),),
                  onPressed: (){
                    _login();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("OR",style: TextStyle(
                  color: THEME_COLOR,
                  fontSize: 16.0
                ),),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),),
                  child: Text("Signup",style: TextStyle(
                      color: Colors.white,
                    fontSize: 16.0
                  ),),
                  onPressed: (){
                    _signup();
                  },
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  _login() async{
    if (_formKey.currentState.validate()){
      Loader.showLoader(context);
      AuthResult result = await AuthenticatorService().signInWith(email: _emailController.text, password: _passwordController.text);
      Loader.hideLoader();
      _handleAuthResult(result: result);
    }
  }
  _signup() async{
    if (_formKey.currentState.validate()){
      Loader.showLoader(context);
      AuthResult result = await AuthenticatorService().signUpWith(email: _emailController.text, password: _passwordController.text);
      Loader.hideLoader();
      _handleAuthResult(result: result);
    }
  }

  _handleAuthResult({AuthResult result}){
    if (result.success){
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => HomePage()));
    }else{
      Components.showErrorMessage(msg: result.error,passedContext: context,);
    }
  }
}
