import 'package:adottapets/modals/login_form.dart';
import 'package:adottapets/modals/signup_form.dart';
import 'package:flutter/material.dart';

class Toggle extends StatefulWidget {
  const Toggle({Key key}) : super(key: key);

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {

  bool showSignIn = true;

  void toggleView() {
    setState( () => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn) {
      return LoginForm(toggleView:toggleView);
    }
    else
    {
      return SignUp(toggleView:toggleView);
    }
  }
}
