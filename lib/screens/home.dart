import 'package:adottapets/constants/navigate.dart';
import 'package:adottapets/listwidgets/datalist.dart';
import 'package:adottapets/modals/fetchdata.dart';
import 'package:adottapets/screens/uploadform.dart';
import 'package:adottapets/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    user.reload();

    return StreamProvider<List<DispData>>.value(
      initialData: [],
      value: DatabaseService().petUpload,
      child: Scaffold(
        backgroundColor: Color(0xff416d6d),
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: "Adotta Pets",
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
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.cloudUploadAlt, size: 18,),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UploadForm(),
                )
                );
              },
            ),
          ],
        ),

        body: SafeArea(
           child: DataList(),
        ),
      ),
    );
  }
}
