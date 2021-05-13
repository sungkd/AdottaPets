import 'package:adottapets/listwidgets/userdatalist.dart';
import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyUploads extends StatefulWidget {
  @override
  _MyUploadsState createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<DispData>>.value(
      initialData: [],
      value: DatabaseService().petUpload,
      child: Scaffold(
        backgroundColor: Color(0xff416d6d),
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: "My Uploads",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 15.0,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xffFF045C5C),
          elevation: 1.2,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
              onPressed: () { Navigator.pop(context); } ),
        ),
        body: SafeArea(child: UserDataList()),
      ),
    );
  }

}
