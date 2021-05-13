import 'package:adottapets/modals/fetchdata.dart';
import 'package:flutter/material.dart';

class UploaderDetails extends StatelessWidget {

  final DispData dbData;
  UploaderDetails({this.dbData});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        elevation: 1.5,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
              text: 'Uploader Details',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1.2
              )
          ),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: () { Navigator.pop(context); } ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 60, 20, 0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(dbData.userimg),
                radius: 100,
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text:TextSpan(
                    text: dbData.userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  )),
                  dbData.userverify == true ? Icon(Icons.verified_sharp,
                    color: Colors.blue[500],) : Container(),
                ],
              ),
              SizedBox(height: 15,),
              RichText(text:TextSpan(
                text: dbData.email,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 1.2,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
