class Validator{
  String emailValidation(dynamic value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is required";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid email";
    } else {
      return null;
    }
  }

  String passwordValidation(dynamic value) {
    if (value.length < 8)
      return "Password should be a minimum of 8 characters";
    else
      return null;
  }
}