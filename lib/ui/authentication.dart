import 'package:dice_game/services/authenticator_service.dart';
import 'package:dice_game/shared_ui/loader.dart';
import 'package:dice_game/util/validator.dart';
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
        title: Center(child: Text("Login/Signup")),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: _emailController,
                validator: Validator().emailValidation,
                decoration: InputDecoration(
                    hintText: "Email"
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                validator: Validator().passwordValidation,
                decoration: InputDecoration(
                  hintText: "Password"
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Login"),
                    onPressed: (){
                      _login();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text("Signup"),
                    onPressed: (){
                      _signup();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _login(){
    if (_formKey.currentState.validate()){
      AuthenticatorService().signInWith(email: _emailController.text, password: _passwordController.text);
    }
  }
  _signup(){
    if (_formKey.currentState.validate()){
      AuthenticatorService().signUpWith(email: _emailController.text, password: _passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Testing")));

    }
  }
}
