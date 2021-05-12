import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {


  //Create user collection
  final CollectionReference _userCollection = FirebaseFirestore.instance
      .collection('Users');

  Future createUser(dynamic _uid, String _username, String _email, dynamic _imgUrl,
                    bool _verified) async
  {
    return await _userCollection.doc(_uid).set(
        {
          'uid': _uid,
          'username': _username,
          'email': _email,
          'imgurl': _imgUrl,
          'verified': _verified,
        }
    );
  }

}