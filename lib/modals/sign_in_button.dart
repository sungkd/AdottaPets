import 'package:adottapets/modals/login_form.dart';
import 'package:adottapets/modals/signup_form.dart';
import 'package:adottapets/modals/toggle.dart';
import 'package:adottapets/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) =>  Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.red[800],
      borderRadius: BorderRadius.circular(10),
    ),
    child: OutlinedButton.icon(
      label: RichText(
        text: TextSpan(
          text: 'Continue with Google',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      icon: FaIcon(FontAwesomeIcons.google,
      color: Colors.white,),
      onPressed:  () async {
        Provider.of<AuthService>(context,listen: false).signInWithGoogle()
        .whenComplete(() {
          print('Sign In');
        });
      },
    ),
  );
}


class EmailSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>  Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.blue[700],
      borderRadius: BorderRadius.circular(10),
    ),
    child: OutlinedButton.icon(
      label: RichText(
        text: TextSpan(
          text: 'Sign In with Email',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
      icon: FaIcon(FontAwesomeIcons.envelopeOpen,
        color: Colors.white,),
      onPressed:  () {
        // emailAuthSheet(context);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Toggle(),
        )
        );
      },
    ),
  );

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(context: context,
        enableDrag: true,
        isScrollControlled: true,
        builder: (context)
    {
      return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blueGrey[800],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: Colors.white,),
              ),
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      color: Colors.blue,
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.pushReplacement(context,PageTransition
                          (child: LoginForm(),
                            type: PageTransitionType.leftToRight)
                        );
                        // Provider.of<LoginForm>(context,listen: false).logInSheet(context);
                      }),

                  MaterialButton(
                      color: Colors.red,
                      child: Text("Sign Up "),
                      onPressed: () {
                      Navigator.pushReplacement(context,PageTransition
                        (child: SignUp(),
                        type: PageTransitionType.leftToRight)
                      );
                        // Provider.of<LoginForm>(context,listen: false)
                        //     .signUpSheet(context);
                      }),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

}