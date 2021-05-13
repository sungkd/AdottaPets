import 'package:adottapets/constants/decorate.dart';
import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/screens/detailscreen.dart';
import 'package:adottapets/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class UserDataTile extends StatelessWidget {


  final DispData dbData;
  UserDataTile({this.dbData});

  @override
  Widget build(BuildContext context) {

    final double _radius = 16;

    final user = FirebaseAuth.instance.currentUser;

    final _formKey = GlobalKey<FormState>();

    String _description = '';
    String _name = '';
    String _area = '';
    String _phone = '';
    String _pin = '';
    String _location = '';

    dynamic _path = '';
    dynamic _path1 = '';
    dynamic _path2 = '';

    if(user.uid == dbData.userId) {

      _path = dbData.path;
      _path1 = dbData.path1;
      _path2 = dbData.path2;

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: GestureDetector(
            onTap: () {
              dbData.status == 'Not Adopted' ?
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailScreen(dbData: dbData),
              )
              ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar
                (content: Text('Pet Adopted')));
            },
            child: Card(
              color: dbData.status == 'Adopted' ? Colors.grey : Colors.white,
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.circular(18.0),),
              elevation: 10.0,
              margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: buildText(dbData.breed,dbData.location, dbData.description)),
                      buildImage(_radius, dbData.imgUrl),
                    ],
                  ),
                  dbData.userId == user.uid ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      //Update Details
                      IconButton(onPressed: () async {
                        dbData.status == 'Not Adopted' ?
                        showModalBottomSheet(
                            enableDrag: true,
                            isScrollControlled: true,
                            context: context, builder: (context) {

                          //Modify Data
                          return SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Text('Modify Details',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //Details
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
                                          maxLength: 250,
                                          initialValue: dbData.description,
                                          maxLines: 5,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                            labelText: 'Pet Detail',
                                          ),
                                          validator: (val) => (val.isEmpty) ? 'Enter details'
                                              : null,
                                          onChanged: (val) {
                                            _description = val;
                                          },
                                        ),

                                        //Contact Person
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
                                          initialValue: dbData.name,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                            labelText: 'Name',
                                            isDense: true,
                                          ),
                                          validator: (val) => (val.isEmpty) ? 'Enter name'
                                              : null,
                                          onChanged: (val) {
                                            _name = val;
                                          },
                                        ),

                                        //Phone
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
                                          initialValue: dbData.phone.toString(),
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                              labelText: 'Phone number',
                                              isDense: true
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (val) => (val.isEmpty) ? 'Enter phone number'
                                              : (val.length == 10) ? null : 'Phone number should be of 10 digits',
                                          onChanged: (val) {
                                            _phone = val;
                                          },
                                        ),

                                        //City
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
                                          initialValue: dbData.location,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                              labelText: 'City',
                                              hintText: 'Mumbai',
                                              isDense: true
                                          ),
                                          validator: (val) => (val.isEmpty)
                                              ? 'Mention nearest city name'
                                              : null,
                                          onChanged: (val) {
                                            _location = val;
                                          },
                                        ),

                                        //Area
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
                                          initialValue: dbData.area,
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                              labelText: 'Area',
                                              hintText: '90 Feet Road, Bhandup East',
                                              isDense: true
                                          ),
                                          validator: (val) => (val.isEmpty) ? 'Enter area name'
                                              : (val.length <= 45) ? null
                                              : 'Cannot enter more than 45 characters',
                                          onChanged: (val) {
                                            _area = val;
                                          },
                                        ),

                                        //Pin Code
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
                                          initialValue: dbData.pin.toString(),
                                          style: TextStyle(color: Colors.black87),
                                          decoration: richTextDecoration.copyWith(
                                              labelText: 'Pin code',
                                              hintText: '400042',
                                              isDense: true
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (val) => (val.isEmpty) ? 'Enter pin code'
                                              : (val.length == 6) ? null
                                              : 'Pin code cannot be more than 6 digits',
                                          onChanged: (val) {
                                            _pin = val;
                                          },
                                        ),

                                        SizedBox(height: 10,),
                                        Center(
                                          child: TextButton(
                                            child: Text('Update',
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                            style: textButtonStyle,
                                            onPressed: () {
                                              if(_formKey.currentState.validate()) {

                                                if (_description.isEmpty) {
                                                  _description = dbData.description;
                                                }

                                                if (_name.isEmpty) {
                                                  _name = dbData.name;
                                                }

                                                if (_phone.isEmpty) {
                                                  _phone = dbData.phone.toString();
                                                }

                                                if (_location.isEmpty) {
                                                  _location = dbData.location;
                                                }

                                                if (_area.isEmpty) {
                                                  _area = dbData.area;
                                                }

                                                if (_pin.isEmpty) {
                                                  _pin = dbData.pin.toString();
                                                }

                                                DatabaseService(uid: dbData.uid).
                                                updateUserData(dbData.breed, dbData.gender,
                                                    _description, _name, int.parse(_phone),
                                                    _location, dbData.age,dbData.days,
                                                    _area, int.parse(_pin),dbData.neutered,
                                                    dbData.status, dbData.userId,dbData.imgUrl,
                                                    dbData.imgUrl1, dbData.imgUrl2,
                                                    dbData.path,dbData.path1,dbData.path2,
                                                    dbData.dateTime,user.email,
                                                    user.displayName, user.photoURL,
                                                    user.emailVerified
                                                );


                                                Navigator.pop(context);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                    SnackBar(
                                                        backgroundColor: Colors.blue[700],
                                                        content: Row(
                                                          children: [
                                                            Icon(LineIcons.thumbsUpAlt,
                                                              color: Colors.white,
                                                              size: 20.0,),
                                                            SizedBox(width: 20,),
                                                            RichText(
                                                              text: TextSpan(
                                                                text: 'Data updated successfully',
                                                                style: TextStyle(
                                                                  color: Colors.white,
                                                                  letterSpacing: 1.2,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )));
                                              }

                                            },
                                          ),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        ) : ScaffoldMessenger.of(context).showSnackBar(SnackBar
                          (content: Text('Pet Adopted')));
                      },
                        icon: FaIcon(FontAwesomeIcons.edit,
                        color: Colors.blue[800],) ,),

                      // Change Status to adopted
                      IconButton(onPressed: () async {
                        dbData.status == 'Not Adopted' ? showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: RichText(
                                    text: TextSpan(
                                      text: "Change status to adopted?"
                                    )),
                                content: RichText(
                                     text: TextSpan(
                                       text: 'Pet will shown and adopted  '
                                           'no further changes will be allowed',
                                       style: TextStyle(
                                           color: Colors.white
                                       ),),),
                                actions: [
                                  TextButton(
                                    onPressed: () async {

                                      DatabaseService(uid: dbData.uid).
                                      updateUserData(dbData.breed, dbData.gender,
                                      dbData.description, dbData.name, dbData.phone,
                                      dbData.location, dbData.age,dbData.days,
                                      dbData.area, dbData.pin,dbData.neutered,
                                      'Adopted', dbData.userId,dbData.imgUrl,
                                      dbData.imgUrl1, dbData.imgUrl2,
                                      dbData.path,dbData.path1,dbData.path2,
                                      dbData.dateTime,user.email,
                                      user.displayName, user.photoURL,
                                      user.emailVerified);

                                      Navigator.pop(context);
                                    },
                                    child: RichText(text: TextSpan(
                                      text: 'Yes',
                                      style: TextStyle(color: Colors.black)
                                    ),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                      child: RichText(text: TextSpan(
                                          text: 'No',
                                          style: TextStyle(color: Colors.black)
                                      ),),
                                  )
                                ],
                                backgroundColor: Colors.teal[800],

                              );
                            }) : ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                              backgroundColor: Colors.blue[800],
                              duration: Duration(seconds: 3),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(FontAwesomeIcons.dog,color: Colors.white,),
                                  SizedBox(width: 20,),
                                  RichText(text: TextSpan(
                                    text: 'Pet Adopted',
                                    style: TextStyle(
                                      color: Colors.white
                                    )
                                  ))
                                ],
                              )));
                      },
                        icon: FaIcon(FontAwesomeIcons.checkCircle,
                        color: Colors.green[800],),),

                      //Delete Record
                      IconButton(onPressed: () {
                        dbData.status == 'Not Adopted' ?
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Center(
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Delete the record?",
                                        style: TextStyle(
                                          fontSize: 25
                                        ),
                                      )),
                                ),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.exclamationTriangle,
                                    color: Colors.red[800],),
                                    SizedBox(width: 10,),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Please confirm delete',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18
                                        ),),),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {

                                      DatabaseService().deleteData(dbData.uid);

                                      print('path $_path $_path1');
                                      print('apth2 $_path2');
                                      Navigator.pop(context);

                                      await FirebaseStorage.instance
                                          .ref(_path).delete();
                                      await FirebaseStorage.instance
                                          .ref(_path1).delete();
                                      await FirebaseStorage.instance
                                          .ref(_path2).delete();
                                    },

                                    child: RichText(text: TextSpan(
                                        text: 'Yes',
                                        style: TextStyle(color: Colors.black)
                                    ),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: RichText(text: TextSpan(
                                        text: 'No',
                                        style: TextStyle(color: Colors.black)
                                    ),),
                                  )
                                ],
                                backgroundColor: Colors.teal[800],

                              );
                            }) : ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            backgroundColor: Colors.blue[800],
                            duration: Duration(seconds: 3),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.dog,color: Colors.white,),
                                SizedBox(width: 20,),
                                RichText(text: TextSpan(
                                    text: 'Pet Adopted',
                                    style: TextStyle(
                                        color: Colors.white
                                    )
                                ))
                              ],
                            )));


                      },
                        icon: FaIcon(FontAwesomeIcons.trash,
                        color: Colors.red[800],) ,),


                    ],
                  ) : Container(),
                ],
              ),
            ),
          ),
        ),
      );
    }
    else
    {
      return Container();
    }

  }
}

Widget buildText(String breed, String location, String description) => Container(
  padding: EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          RichText(text: TextSpan(text: breed,
              style: TextStyle(color: Colors.black87, fontSize: 20))),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              RichText(text: TextSpan(text: location,
                  style: TextStyle(color: Colors.grey, fontSize: 15))),
            ],
          ),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: [
              RichText(text: TextSpan(text: description.length >=35 ?
              description.substring(0,28)
                  : description,
                  style: TextStyle(color: Colors.grey, fontSize: 15))),
            ],
          ),
        ],
      ),
    ],
  ),
);

Widget buildImage(double radius, imgUrl) => ClipRRect(
  borderRadius: BorderRadius.horizontal(
    right: Radius.circular(radius),),
  child: CachedNetworkImage(
    placeholder: (context, url) => CircularProgressIndicator(
      backgroundColor: Colors.grey[600],
      strokeWidth: 2,
    ),
    imageUrl: imgUrl,
    fit: BoxFit.cover,
    width: 120,
    height: 120,
  ),
);

buildImgText(String status, String description, double radius, imgUrl,
    double width, double height ) =>
    Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(text: TextSpan(text: status,
                  style: TextStyle(color: Colors.black87, fontSize: 20))),
              Spacer(),
            ],
          ),
          Column(
            children: [
              RichText(text: TextSpan(text: description.length >= 20 ? description.substring(0,15) : description,
                  style: TextStyle(color: Colors.grey, fontSize: 15))),
            ],
          ),
        ],
      ),

    );



