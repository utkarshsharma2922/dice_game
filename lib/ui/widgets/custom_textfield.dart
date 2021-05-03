import 'package:dice_game/util/constants.dart';
import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final FormFieldValidator<String> fieldValidator;


  CustomTextField(
      {this.hint,
        this.textEditingController,
        this.keyboardType,
        this.icon,
        this.obscureText= false,
        this.fieldValidator,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: fieldValidator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: THEME_COLOR.shade200,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: THEME_COLOR.shade200, size: 20),
        hintText: hint,
        border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(30.0),
            ),
            borderSide: new BorderSide(color: THEME_COLOR)),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: THEME_COLOR, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: THEME_COLOR, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: THEME_COLOR, width: 1.0),
          borderRadius: BorderRadius.circular(30.0),
        ),        ),
    );
  }
}
