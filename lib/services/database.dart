import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/modals/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService extends ChangeNotifier {

  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  final CollectionReference petData = FirebaseFirestore.instance.collection('Data');

  Future updateUserData(String breed, String gender, String description,
      String name,  int phone,  String location, int age,
      String days, String area, int pin, bool neutered,
      String status, dynamic userId,
      String url, String url1, String url2,
      dynamic path, dynamic path1, dynamic path2,
      dynamic dateTime, dynamic email,
      dynamic username, dynamic userimg, dynamic userverify) async
  {

    return await petData.doc(uid).set(
        {
          'breed': breed,
          'gender': gender,
          'description': description,
          'name' : name,
          'phone': phone,
          'location': location,
          'age': age,
          'days': days,
          'area': area,
          'pin': pin,
          'neutered': neutered,
          'status': status,
          'userId': userId,
          'imgUrl': url,
          'imgUrl1': url1,
          'imgUrl2': url2,
          'path': path,
          'path1' : path1,
          'path2' : path2,
          'dateTime': dateTime,
          'email': email,
          'username': username,
          'userimg': userimg,
          'userverify': userverify,
        }
    );
  }

  //Get uploaded data into a list from snapshot
  List<DispData> _dispDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DispData(
        breed: doc.data()['breed'] ?? '',
        gender: doc.data()['gender'] ?? '',
        description: doc.data()['description'] ?? '',
        name: doc.data()['name'] ?? '',
        phone: doc.data()['phone'] ?? 0,
        location: doc.data()['location'] ?? '',
        age: doc.data()['age'] ?? 0,
        days: doc.data()['days'] ?? '',
        area: doc.data()['area'] ?? '',
        pin: doc.data()['pin'] ?? 0,
        neutered: doc.data()['neutered'] ?? false,
        status: doc.data()['status'] ?? '',
        userId: doc.data()['userId'] ?? '',
        uid: doc.id ?? '',
        imgUrl: doc.data()['imgUrl'] ?? '',
        imgUrl1: doc.data()['imgUrl1'] ?? '',
        imgUrl2: doc.data()['imgUrl2'] ?? '',
        path: doc.data()['path'] ?? '',
        path1: doc.data()['path1'] ?? '',
        path2: doc.data()['path2'] ?? '',
        dateTime: doc.data()['dateTime'] ?? '',
        email: doc.data()['email'] ?? '',
        userName: doc.data()['username'] ?? '',
        userimg: doc.data()['userimg'] ?? '',
        userverify: doc.data()['userverify'] ?? '',

      );
    }).toList();
  }

  //Get data from snapshot
  UploadData1 _uploadData1FromSnapshot (DocumentSnapshot snapshot) {
    return UploadData1(
      uid: uid,
      breed: snapshot.data()['breed'] ,
      gender: snapshot.data()['gender'] ,
      description: snapshot.data()['description'] ,
      name: snapshot.data()['name'] ,
      phone: snapshot.data()['phone'] ,
      location: snapshot.data()['location'] ,
      age:snapshot.data()['age'],
      days: snapshot.data()['days'],
      area: snapshot.data()['area'],
      pin: snapshot.data()['pin'],
      neutered: snapshot.data()['neutered'],
      status: snapshot.data()['status'] ,
      userId: snapshot.data()['userId'] ,
      imgUrl: snapshot.data()['imgUrl'] ,
      imgUrl1: snapshot.data()['imgUrl1'] ,
      imgUrl2: snapshot.data()['imgUrl2'] ,
      path: snapshot.data()['path'] ,
      path1: snapshot.data()['path1'] ,
      path2: snapshot.data()['path2'] ,
      dateTime: snapshot.data()['dateTime'] ,
      email: snapshot.data()['email'] ,
      username: snapshot.data()['username'] ,
      userimg: snapshot.data()['userimg'] ,
      userverify: snapshot.data()['userverify'] ,

    );
  }

  Future deleteData(dynamic _uid ) async {
    return petData.doc(_uid).delete();
  }

  Stream<QuerySnapshot> get petMeta {
    return petData.snapshots();
  }

  //Get snapshot of the database
  Stream<List<DispData>> get petUpload {
    return petData.snapshots().map(_dispDataFromSnapshot);
  }

  //Get user uploaded data
  Stream<UploadData1> get uploadData1 {
    return petData.doc(uid).snapshots().map(_uploadData1FromSnapshot);
  }
}