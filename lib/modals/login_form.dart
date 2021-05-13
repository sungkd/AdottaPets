import 'package:adottapets/constants/decorate.dart';
import 'package:adottapets/constants/loading.dart';
import 'package:adottapets/modals/sign_in_button.dart';
import 'package:adottapets/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {

  final Function toggleView;
  LoginForm({this.toggleView});


  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController _emailController    = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _resetPasswordController = TextEditingController();

  bool isHidden = true;
  bool loading = false;

  double _containerWidth = 380;
  double _containerHeight = 500;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _resetPasswordController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF045C5C),
        elevation: 20,
        title: Text('Adotta Pets'),
        centerTitle: true,
        leading: Center(
          child: FaIcon(FontAwesomeIcons.dog,
          size: 20,),
        ),
      ),
      backgroundColor: Color(0xffFF045C5C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: 'Email',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(color: Colors.black87),
                          decoration: richTextDecoration.copyWith(
                              labelText: 'Enter Email',
                              suffixIcon: _emailController.text.isEmpty ? Container(width: 0)
                                  : IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _emailController.clear(); }
                              )
                          ), //richTextDecoration.copyWith
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                text: 'Password',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    enableDrag: true,
                                    isScrollControlled: true,
                                    context: context, builder: (context) {
                                  return Container(
                                    color: Colors.teal[700],
                                    height: 400,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'Password Reset',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              wordSpacing: 1.0,
                                              letterSpacing: 1.2,),
                                          ),
                                        ),
                                        SizedBox(height: 15,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                          child: TextField(
                                            controller: _resetPasswordController,
                                            decoration: richTextDecoration.copyWith(
                                              hintText: 'Enter email ID',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16
                                              ),
                                            ),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        ElevatedButton(
                                          onPressed: () {
                                            Provider.of<AuthService>(context,
                                                listen: false)
                                                .resetPassword(_resetPasswordController.text);

                                          Navigator.pop(context);

                                          if(_resetPasswordController.text.isNotEmpty){
                                            warningText(context,
                                                'Reset link sent to'
                                                    ' ${_resetPasswordController.text}');


                                          }
                                          else
                                            {
                                              warningText(context, 'Please enter email ID');
                                            }

                                          },
                                          child: Text('Reset'),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                );
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:Size(5,5)),
                              child: Text('Forgot Password?'),
                            )
                          ],
                        ),
                        TextFormField(
                          obscureText: isHidden,
                          style: TextStyle(color: Colors.black87),
                          decoration: richTextDecoration.copyWith(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  icon: isHidden ? FaIcon(FontAwesomeIcons.eyeSlash)
                                      : FaIcon(FontAwesomeIcons.eye),
                                  onPressed: togglePasswordVisibility
                              )
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                        ),
                        SizedBox(height: 25,),
                        TextButton(
                          child: Text('Login',
                            style: TextStyle(
                                color: Colors.white
                            ),),
                          style: textButtonStyle,
                          onPressed: () async {

                            FocusScope.of(context).requestFocus(new FocusNode());

                            setState( () => loading = true);

                          if(_emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {

                            dynamic result = await Provider
                                .of<AuthService>(context,listen: false)
                                .sigInUser(_emailController.text,
                                _passwordController.text);

                            if(result == null) {
                              warningText(context, 'Invalid email or password');
                            }
                          }
                          else {
                            warningText(context, 'All fields are mandatory');
                          }

                          },
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(color: Colors.black,
                                  fontSize: 15,
                                )
                            ),
                            ),
                            TextButton(
                              onPressed: () {
                                widget.toggleView();
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize:Size(5,5)),
                              child: Text('Sign Up'),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        Center(child: GoogleSignInButton()),
                      ],
                    ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: _containerWidth,
                  height: _containerHeight,
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  warningText(BuildContext context, String message) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.teal[800],
        ),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(message, style: TextStyle(
              color: Colors.white, fontSize: 16.0,
              fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

}


