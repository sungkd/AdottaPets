import 'package:adottapets/modals/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';



class AuthService extends ChangeNotifier {

  dynamic _userUid;
  dynamic _signUpError;
  dynamic _loginError;

  dynamic get getUserUid => _userUid;
  dynamic get getSignUpError => _signUpError;
  dynamic get getLoginError => _loginError;


  // Used to access all Firebase functions
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Google Sign In Instance
  final googleSignIn = GoogleSignIn();

  //Create user object based on firebase user
  UserData _userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid, email: user.email) : null;
  }

  //Auth change user stream
  Stream<UserData> get uservalue {
    return _auth.authStateChanges().map((User uservalue) => _userFromFirebaseUser(uservalue));
  }


  // Sign In with email & password
  Future sigInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User userval = result.user;

      _userUid = userval.uid;

      notifyListeners();
      return _userFromFirebaseUser(userval);

    }

    catch(e) {
      print(e.toString());
      return null;
    }
  }


  // Register with email & password
  Future registerUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User userval = result.user;

      _userUid = userval.uid;
      _signUpError = '';

      notifyListeners();
      return _userFromFirebaseUser(userval);

    }
    catch(e) {
      print(e.toString());
      _signUpError = e.toString();
      return e.toString();
    }
    // catch(signUpError) {
    //   if(signUpError is PlatformException) {
    //     if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
    //       _signUpError = signUpError.code;
    //       notifyListeners();
    //       return _signUpError;
    //     }
    //   }
    // }
  }


  // Sign Out
  Future signOut() async {
    try {
      notifyListeners();

      User user = FirebaseAuth.instance.currentUser;
      print('signout - ${user.providerData[0].providerId}');

      if(user.providerData[0].providerId == 'google.com') {
        print('google');
        logoutFromGoogle();
      }
      else {
        print('non google');
        return await _auth.signOut();
      }

    }
    catch (e)
    {
      print(e.toString());
      return null;
    }
  }

  //Password Reset
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  //Google Sign In
  Future signInWithGoogle() async {

    final user = await googleSignIn.signIn();

    if(user == null) {
      return;
    }
    else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('uisd ${user.id} - ${user.displayName} -  - ${user.email}');
      notifyListeners();

    }
  }

  //Google Sign Out
  Future logoutFromGoogle() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }


}