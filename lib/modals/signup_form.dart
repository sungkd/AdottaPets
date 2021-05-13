import 'dart:io';
import 'package:adottapets/constants/decorate.dart';
import 'package:adottapets/constants/loading.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:adottapets/services/auth.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  TextEditingController  _userNameController = TextEditingController();
  TextEditingController _emailController    = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();

    super.dispose();
  }

  bool isHidden = true;
  bool submitValid = false;
  bool _otpMatches = false;
  bool loading = false;

  dynamic result;
  double _containerWidth = 380;


  PickedFile pickedImage;
  dynamic _url;
  File _image;
  File imageFile;
  String fileName = '';

  Future getImage(String _gallery) async {


    final picker = ImagePicker();

    if(_gallery == 'gallery') {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
    }
    fileName = path.basename(pickedImage.path);
    imageFile = File(pickedImage.path);

    setState(() {
      _image = imageFile;

    });

  }

  getImageURL({String name}) async {
    _url  = await FirebaseStorage.instance.ref(fileName).getDownloadURL();
  }



  //Function to send the OTP to the user
  void sendOtp() async {
    EmailAuth.sessionName = "AdottaPets";
    bool result =
    await EmailAuth.sendOtp(receiverMail: _emailController.value.text);
    if (result) {
      setState(() {
        submitValid = true;
      });
    }
    else {
      setState(() {
        submitValid = false;
      });
    }
  }


  // Function to verify if the Data provided is true
  void verify() {
    bool verify = EmailAuth.validate(receiverMail: _emailController.value.text,
        userOTP: _otpController.value.text);

    if(verify) {
      setState(() {
        _otpMatches = true;
      });
    }
    else
    {
      setState(() {
        _otpMatches = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffFF045C5C),
        elevation: 20,
        title: RichText(text: TextSpan(
            text: 'Hooman Registration',
            style: TextStyle(color: Colors.white,
              letterSpacing: 1.2,)),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xffFF045C5C),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: _image == null ? InkResponse(
                        onTap: () {
                          //Select image from gallery
                          getImage('gallery');
                        },
                        child: FaIcon(FontAwesomeIcons.camera,
                          size: 50,),
                      ) : InkResponse(
                        onTap: () {
                          //Select image from gallery
                          getImage('gallery');
                        },
                        child: CircleAvatar(
                          backgroundImage: FileImage(_image,
                              scale: 1),
                          radius: 70,
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: _image != null ? EdgeInsets.all(0) : EdgeInsets.all(35),
                      decoration: _image != null ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200]
                      ) : BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),

                    SizedBox(height: 15,),

                    //User Name
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Username',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      maxLength: 10,
                      controller: _userNameController,
                      style: TextStyle(color: Colors.black87),
                      decoration: richTextDecoration.copyWith(
                          labelText: 'Enter username',
                          suffixIcon: _userNameController.text.isEmpty ? Container(width: 0)
                              : IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                _userNameController.clear();
                              },
                          )
                      ), //richTextDecoration.copyWith
                    ),

                    SizedBox(height: 20,),
                    //Email
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
                                _emailController.clear();
                              },
                          )
                      ), //richTextDecoration.copyWith
                    ),

                    SizedBox(height: 20,),
                    //Password
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
                    SizedBox(height: 10,),
                    TextFormField(
                      maxLength: 16,
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

                    SizedBox(height: 20,),

                    //Confirm Password
                    RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Confirm Password',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      maxLength: 16,
                      obscureText: isHidden,
                      style: TextStyle(color: Colors.black87),
                      decoration: richTextDecoration.copyWith(
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                              icon: isHidden ? FaIcon(FontAwesomeIcons.eyeSlash)
                                  : FaIcon(FontAwesomeIcons.eye),
                              onPressed: togglePasswordVisibility
                          )
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                    ),

                    SizedBox(height: 20,),

                    //Confirm
                    TextButton(
                      child: Text('Next',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                      style: textButtonStyle,
                      onPressed: () async {

                        FocusScope.of(context).requestFocus(new FocusNode());


                        if(_image != null) {
                          if(_userNameController.text.isNotEmpty &&
                              _userNameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty &&
                              _confirmPasswordController.text.isNotEmpty)
                          {
                            if(_passwordController.text.toLowerCase() ==
                                _confirmPasswordController.text.toLowerCase() )
                            {
                              if(_passwordController.text.length == 8) {

                                result = '';
                                result = await _auth.fetchSignInMethodsForEmail
                                        (_emailController.text);

                                if(result.isEmpty) {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(backgroundColor: Colors.teal[800],
                                        content: Text('Sending OTP to ${_emailController.text}'
                                    ),)
                                  );


                                  EmailAuth.sessionName = "AdottaPets";
                                  submitValid = await EmailAuth
                                      .sendOtp(receiverMail: _emailController.value.text);

                                  if(submitValid) {
                                    enterOtp(context);

                                  }
                                  else{
                                    warningText(context,'Invalid Email OTP not sent');
                                    submitValid = false;
                                    result = '';
                                  }

                                }
                                else {
                                  warningText(context,'Email already registered with other user');
                                }


                              }
                              else
                              {
                                warningText(context,'Password must have 8 characters');
                              }
                            }
                            else
                            {
                              warningText(context,'Passwords Didn\'t Match');
                            }
                          }
                          else {
                            warningText(context,'All fields are mandatory');
                          }
                        }
                        else
                          {
                            warningText(context,'Please select an image');
                          }
                      },
                    ),

                    //Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(text: TextSpan(
                            text: 'Already have an account?',
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
                          child: Text('Login'),
                        )
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: _containerWidth,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
              ),
          ),
        ),
      ),
    );

  }
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
              color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
          ),

        ),
      );
    });
  }


  void togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  enterOtp(BuildContext context) {

    FirebaseStorage storage = FirebaseStorage.instance;

    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        color: Colors.teal[900],
        height: MediaQuery.of(context).size.height * 0.50,
        width: MediaQuery.of(context).size.width ,
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _otpController,
                decoration: richTextDecoration.copyWith(
                  hintText: 'Enter OTP',
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
            ElevatedButton(
                onPressed: () async {


                  verify();

                  if(_otpMatches) {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Navigator.pop(context);

                    setState( () => loading = true);

                    //Sign Up user
                    Provider.of<AuthService>(context,listen: false)
                        .registerUser(_emailController.text,
                        _passwordController.text).whenComplete(() async {

                          User _user = FirebaseAuth.instance.currentUser;

                          //Upload user image
                          await storage.ref(fileName).putFile(
                                imageFile,
                                SettableMetadata(customMetadata: {
                                  'uploaded_by': _userNameController.text,
                                  'description': DateTime.now().toString()})
                            ).whenComplete(() async {
                              _url = await FirebaseStorage.instance
                                  .ref(fileName).getDownloadURL();

                              //Update User details
                              await _user.updateProfile(
                                  displayName: _userNameController.text,
                                  photoURL: _url).whenComplete(() {
                              });
                            });
                    });
                  }
                  else {
                    warningText(context, 'Invalid OTP');
                  }
                },
                child: Text('Verify & Login'),
            ),
          ],
        ),
      );
    });
  }

}




