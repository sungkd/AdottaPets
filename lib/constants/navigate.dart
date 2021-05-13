import 'package:adottapets/screens/howtouse.dart';
import 'package:adottapets/screens/myuploads.dart';
import 'package:adottapets/services/auth.dart';
import 'package:android_intent/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationDrawer extends StatelessWidget {

  final _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 30);

  _sendEmail() async {
    const url = 'mailto:petadoptfeedback@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Drawer(
        child: Material(
          color: Colors.teal[700],
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: _padding,
              children: [
                buildHeader(
                  name: (user.displayName == null) ? 'loading' : user.displayName,
                  img: (user.photoURL == null) ? 'loading' : user.photoURL,
                ),
                const SizedBox(height: 20,),
                // buildMenuItems(
                //   text: 'My Uploads',
                //   icon: FontAwesomeIcons.home,
                //   onClicked: () => selectedItem(context,0),
                // ),

                buildMenuItems(
                  text: 'My Uploads',
                  icon:  FontAwesomeIcons.cloudUploadAlt,
                  onClicked: () => selectedItem(context,1),
                ),

                buildMenuItems(
                  text: 'How to use',
                  icon: FontAwesomeIcons.questionCircle,
                  onClicked: () => selectedItem(context,2),
                ),

                buildMenuItems(
                    text: 'Feedback',
                    icon: FontAwesomeIcons.envelope,
                    onClicked: () {
                      _sendEmail();
                    }
                ),

                buildMenuItems(
                    text: 'Logout',
                    icon: FontAwesomeIcons.signOutAlt,
                    onClicked: () async {
                      Provider.of<AuthService>(context,listen: false).signOut();
                    }),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextButton(
                      child: RichText(
                        text: TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.white)),
                      ),
                      onPressed: () async {
                        AndroidIntent intent = AndroidIntent(
                            action: "action_view",
                            data:
                            'https://sungkd.blogspot.com/2021/05/privacy-policy.html');
                        await intent.launch();
                      },
                    ),
                    Spacer(),
                    TextButton(
                      child: RichText(
                        text: TextSpan(
                            text: 'T&C', style: TextStyle(color: Colors.white)),
                      ),
                      onPressed: () async {
                        AndroidIntent intent = AndroidIntent(
                            action: "action_view",
                            data:
                            'https://sungkd.blogspot.com/2021/05/terms-conditions-for-adottapets.html');
                        await intent.launch();
                      },
                    ),
                  ],
                ),

                Divider(
                  color: Colors.teal[500],
                  height: 10.0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      LineIcons.copyrightAlt,
                      color: Colors.white,
                      size: 18,),
                    SizedBox(width: 10,),
                    RichText(
                      text: TextSpan(
                        text: '2021 All Rights Reserved!',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems({String text, IconData icon, VoidCallback onClicked}) {
    final _color = Colors.white;

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,0,0),
        child: Icon(icon, color: _color, ),
      ),
      title: Text(text, style: TextStyle(color: _color),),
      onTap: onClicked,
    );

  }

  Widget buildHeader({name, img}) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Center(
            child: (img == 'loading') ? Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200] ),
            ) : CircleAvatar(
              backgroundImage: NetworkImage(img),
              radius: 50.0,
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: 'Welcome!',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 10,),
          RichText(
            text: TextSpan(
              text: (name == 'loading') ? 'loading..' : name,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          SizedBox(height: 40,),
          Divider(
            color: Colors.teal[500],
            height: 10.0,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyUploads(),
        )
        );
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyUploads(),
        )
        );
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HowToUse(),
        )
        );
        break;

    }
  }

}
