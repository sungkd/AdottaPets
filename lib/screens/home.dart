import 'package:adottapets/constants/navigate.dart';
import 'package:adottapets/screens/wrapper.dart';
import 'package:adottapets/services/auth.dart';
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

    print('UID- ${user.uid}');
    print('EMAIl - ${user.email}');
    print('PIC - ${user.photoURL}');
    print('DISP - ${user.displayName}');
    print('Vefify - ${user.emailVerified}');

    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(icon: FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () async {

               Provider.of<AuthService>(context,listen: false).signOut();
              // Navigator.pop(context);
              })
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Text(user.displayName),
            // Text(user.email),
            // Text(user.photoURL),
            // Text((user.emailVerified).toString()),
            // Text(user.uid),

          ],
        ),
      ),
    );
  }
}
