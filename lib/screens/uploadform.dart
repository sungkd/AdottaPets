import 'dart:io';
import 'package:adottapets/constants/decorate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class UploadForm extends StatefulWidget {
  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  String _breed = '';
  String _name = '';
  String _location = '';
  String _gender = '';
  String _description = '';
  String _phone = '';
  String _age = '';
  String _area = '';
  String _pin = '';
  String _days = '';
  String url = '';
  String url1 = '';
  String url2 = '';

  String _neutered = 'no';
  bool _isNeutered = false;


  final List<String> petBreed = ['Indie', 'Mixed', 'Pure'];
  final List<String> petGender = ['Male', 'Female'];

  final _formKey = GlobalKey<FormState>();

  PickedFile pickedImage;
  File _image;
  File _image1;
  File _image2;
  File imageFile;
  File imageFile1;
  File imageFile2;

  String fileName = '';
  String fileName1 = '';
  String fileName2 = '';

  bool _isUploading = false;


  Future getImage(String _gallery, int _number) async {


    final picker = ImagePicker();

    if(_gallery == 'gallery') {
      pickedImage = await picker.getImage(source: ImageSource.gallery);
    }

    switch(_number) {
      case 0:
        fileName = path.basename(pickedImage.path);
        imageFile = File(pickedImage.path);

        setState(() {
          _image = imageFile;

        });
        break;

      case 1:
        fileName1 = path.basename(pickedImage.path);
        imageFile1 = File(pickedImage.path);

        setState(() {
          _image1 = imageFile1;

        });
        break;

      case 2:
        fileName2 = path.basename(pickedImage.path);
        imageFile2 = File(pickedImage.path);

        setState(() {
          _image2 = imageFile2;

        });
        break;
    }

    print('Filename - $fileName - $fileName1 - $fileName2');
    print('ImgFile - $imageFile - $imageFile1 - $imageFile2');

  }

  getImageURL({String name, int number}) async {

    switch(number) {
      case 0:
        url  = await FirebaseStorage.instance.ref(fileName).getDownloadURL();
        print('$url');

        break;

      case 1:
        url1  = await FirebaseStorage.instance.ref(fileName1).getDownloadURL();
        print('$url1');
        break;

      case 2:
        url2  = await FirebaseStorage.instance.ref(fileName2).getDownloadURL();
        print('$url2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    double _containerWidth = 380;
    double _containerHeight = 2000;

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy  kk:mm').format(now);

    final user = FirebaseAuth.instance.currentUser;
    final CollectionReference petData = FirebaseFirestore.instance.collection('Data');
    FirebaseStorage storage = FirebaseStorage.instance;


    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Color(0xffFF045C5C),
        elevation: 1.2,
        title: RichText(
          text: TextSpan(
            text: "Adoption Request",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 15.0,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: () { Navigator.pop(context); } ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.all(35),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.grey[200],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _image == null ? Container(
                                  child: InkResponse(
                                    onTap:  () {
                                      //Select image from gallery
                                      getImage('gallery', 0);
                                    },
                                    child: Icon(Icons.flip_camera_ios,
                                      size: 20,
                                      color: Colors.black,),
                                  ),
                                ) : Container(
                                  child: InkResponse(
                                    onTap: () {
                                      //Select image from gallery
                                      getImage('gallery', 0);
                                    },
                                    child: CircleAvatar(
                                        backgroundImage: FileImage(_image, scale: 1),
                                        radius: 50),
                                  ),
                                ),

                                _image1 == null ? InkResponse(
                                  onTap:  () {
                                    //Select image from gallery
                                    getImage('gallery', 1);
                                  },
                                  child: Icon(Icons.flip_camera_ios,
                                    size: 20,
                                    color: Colors.black,),
                                ) : InkResponse(
                                  onTap: () {
                                    //Select image from gallery
                                    getImage('gallery', 1);
                                  },
                                  child: CircleAvatar(
                                      backgroundImage: FileImage(_image1, scale: 1),
                                      radius: 50),
                                ),
                              ],
                            ),
                            SizedBox(height: 40,),
                            _image2 == null ? InkResponse(
                              onTap:  () {
                                //Select image from gallery
                                getImage('gallery', 2);
                              },
                              child: Icon(Icons.flip_camera_ios,
                                size: 20,
                                color: Colors.black,),
                            ) : InkResponse(
                              onTap: () {
                                //Select image from gallery
                                getImage('gallery', 2);
                              },
                              child: CircleAvatar(
                                  backgroundImage: FileImage(_image2, scale: 1),
                                  radius: 50),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Breed',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Mixed/Pure/Indie',
                          isDense: true,
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                            : (val.toLowerCase() == 'mixed')  ? null
                            : (val.toLowerCase() == 'indie')  ? null
                            : (val.toLowerCase() == 'pure')   ? null
                            : 'Breed should be Mixed, Pure or Indie',

                        onChanged: (val) {
                          setState(() => _breed = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Gender',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Male/Female'
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                            : (val.toLowerCase() == 'male')  ? null
                            : (val.toLowerCase() == 'female')  ? null
                            : 'Gender should be Male or Female' ,

                        onChanged: (val) {
                          setState(() => _gender = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Age',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          SizedBox(width: 50,),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Days',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black87),
                              decoration: richTextDecoration.copyWith(
                                  labelText: '1'
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) => (val.isEmpty) ? 'Enter approx age'
                                  : (val.length <= 2) ? null
                                  : 'Age cannot be greater than 2 digits',

                              onChanged: (val) {
                                setState(() => _age = val);
                              },
                            ),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            width: 180,
                            height: 50,
                            child: TextFormField(
                              style: TextStyle(color: Colors.black87),
                              decoration: richTextDecoration.copyWith(
                                  labelText: 'Week/Month/Year'
                              ),

                              validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                                  : (val.toLowerCase() == 'week')  ? null
                                  : (val.toLowerCase() == 'month') ? null
                                  : (val.toLowerCase() == 'year')  ? null
                                  : 'Age should be in week month or year' ,

                              onChanged: (val) {
                                setState(() => _days = val);
                              },
                            ),
                          ),
                        ],
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Neutered or Spayed',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Yes/No',
                          isDense: true,
                        ),
                        validator: (val) => (val.isEmpty) ? 'Field cannot be blank'
                            : (val.toLowerCase() == 'yes')  ? null
                            : (val.toLowerCase() == 'no')   ? null
                            : 'Value can be yes or no' ,

                        onChanged: (val) {
                          setState(() => _neutered = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Details',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        maxLines: 5,
                        maxLength: 250,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Pet Detail',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter details'
                            : null,
                        onChanged: (val) {
                          setState(() => _description = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Contact Person',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        maxLength: 15,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Name'
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter name'
                            : null,
                        onChanged: (val) {
                          setState(() => _name = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Phone',
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
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                            labelText: 'Phone number'
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val.isEmpty) ? 'Enter phone number'
                            : (val.length == 10) ? null : 'Phone number should be of 10 digits',
                        onChanged: (val) {
                          setState(() => _phone = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'City',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        maxLength: 30,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'City',
                          hintText: 'Mumbai',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Mention nearest city name'
                            : null,
                        onChanged: (val) {
                          setState(() => _location = val);
                        },
                      ),

                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Area',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      TextFormField(
                        maxLength: 45,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Area',
                          hintText: '90 Feet Road, Bhandup East',
                        ),
                        validator: (val) => (val.isEmpty) ? 'Enter area name'
                            : (val.length <= 45) ? null
                            : 'Cannot enter more than 45 characters',
                        onChanged: (val) {
                          setState(() => _area = val);
                        },
                      ),


                      SizedBox(height: 10,),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: 'Pin code',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),
                      TextFormField(
                        maxLength: 6,
                        style: TextStyle(color: Colors.black87),
                        decoration: richTextDecoration.copyWith(
                          labelText: 'Pin code',
                          hintText: '400042',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val.isEmpty) ? 'Enter pin code'
                            : (val.length == 6) ? null
                            : 'Pin code cannot be more than 6 digits',
                        onChanged: (val) {
                          setState(() => _pin = val);
                        },
                      ),

                      SizedBox(height: 20,),

                      TextButton(
                        child: Text('Upload',
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        style: textButtonStyle,
                        onPressed: () async {

                          FocusScope.of(context).requestFocus(new FocusNode());
                          if(_formKey.currentState.validate()) {

                            if( _image != null && _image1 != null
                                && _image2 != null) {

                              setState(() {
                                _isUploading = true;
                              });

                              await storage.ref(fileName).putFile(
                                  imageFile,
                                  SettableMetadata(customMetadata: {
                                    'uploaded_by': _name,
                                    'description': DateTime.now().toString()
                                  }
                                  )
                              );

                              url  = await FirebaseStorage.instance
                                  .ref(fileName).getDownloadURL();

                              await storage.ref(fileName1).putFile(
                                  imageFile1,
                                  SettableMetadata(customMetadata: {
                                    'uploaded_by': _name,
                                    'description': DateTime.now().toString()
                                  }
                                  )
                              );

                              url1 = await FirebaseStorage.instance
                                  .ref(fileName1).getDownloadURL();

                              await storage.ref(fileName2).putFile(
                                  imageFile2,
                                  SettableMetadata(customMetadata: {
                                    'uploaded_by': _name,
                                    'description': DateTime.now().toString()
                                  }
                                  )
                              );

                              url2  = await FirebaseStorage.instance
                                  .ref(fileName2).getDownloadURL();

                              if (url != null && url1 != null && url2 != null)
                              {
                                _neutered == 'yes' ?
                                _isNeutered = true
                                    : _isNeutered = false;

                                petData.doc().set( {
                                  'breed': _breed,
                                  'gender': _gender,
                                  'description': _description,
                                  'name' : _name,
                                  'phone': int.parse(_phone),
                                  'location': _location,
                                  'age': int.parse(_age),
                                  'days': _days,
                                  'area': _area,
                                  'pin': int.parse(_pin),
                                  'neutered': _isNeutered,
                                  'status': 'Not Adopted',
                                  'userId': user.uid,
                                  'imgUrl': url,
                                  'imgUrl1': url1,
                                  'imgUrl2': url2,
                                  'path': fileName,
                                  'path1': fileName1,
                                  'path2': fileName2,
                                  'dateTime' : formattedDate.toString(),
                                  'email': user.email,
                                  'username': user.displayName,
                                  'userimg': user.photoURL,
                                  'userverify': user.emailVerified

                                });

                                Navigator.pop(context);

                              }
                              else {
                                warningText(context,'Error while loading data');
                              }

                            }
                            else {
                              warningText(context,'Please select 3 images');
                            }

                          }
                          else {
                            warningText(context,'All fields are mandatory');
                          }
                        },
                      ),
                      SizedBox(height: 20,),
                      _isUploading ?
                      Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                child: Text(
                                  'uploading...',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 10,),
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                              )
                            ],
                          ))
                          : Container(),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: _containerWidth,
                height: _containerHeight,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
              ),
            ],
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

}
