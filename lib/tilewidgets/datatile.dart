import 'package:adottapets/constants/decorate.dart';
import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/screens/detailscreen.dart';
import 'package:adottapets/services/database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class DataTile extends StatelessWidget {

  final DispData dbData;
  DataTile({this.dbData});


  @override
  Widget build(BuildContext context) {

    final double _radius = 16;
    final double _width = MediaQuery.of(context).size.width;

    final user = FirebaseAuth.instance.currentUser;

    final _formKey = GlobalKey<FormState>();

    String _description = '';
    String _name = '';
    String _area = '';
    String _phone = '';
    String _pin = '';
    String _status = '' ;
    String _location = '';

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
                dbData.userId == user.uid ? TextButton(
                  onPressed: () {
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

                                    //Adoption Status
                                    SizedBox(height: 10,),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text: 'Adoption Status',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10,),
                                    TextFormField(
                                      initialValue: dbData.status,
                                      style: TextStyle(color: Colors.black87),
                                      decoration: richTextDecoration.copyWith(
                                          labelText: 'Status',
                                          hintText: 'Adopted/ Not Adopted',
                                          isDense: true
                                      ),
                                      validator: (val) => (val.isEmpty)
                                          ? 'Enter adoption status'
                                          : (val.toLowerCase() == 'not adopted')
                                          ? null
                                          : (val.toLowerCase() == 'adopted')
                                          ? null
                                          : 'Value can be adopted or not adopted',
                                      onChanged: (val) {
                                        _status = val;
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

                                            if (_status.isEmpty) {
                                              _status = dbData.status;
                                            }

                                            print('$_status - $_description');

                                            DatabaseService(uid: dbData.uid).
                                            updateUserData(dbData.breed, dbData.gender,
                                                _description, _name, int.parse(_phone),
                                                _location, dbData.age,dbData.days,
                                                _area, int.parse(_pin),dbData.neutered,
                                                _status, dbData.userId,dbData.imgUrl,
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
                  } ,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    minimumSize: Size(_width,60),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: dbData.status == 'Not Adopted' ? 'Update'
                          : 'Adopted',
                      style: TextStyle(
                          color: Colors.teal[900],
                          letterSpacing: 1.0,
                          fontSize: 16
                      ),
                    ),
                  ),
                ) : Container(),
              ],
            ),
          ),
        ),
      ),
    );
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
    // child: Image.network(imgUrl, fit: BoxFit.cover, width: 120, height: 120,),

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

}
