import 'package:adottapets/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:adottapets/constants/welcomebackground.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Welcome extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    String _line1 = 'Get information of all the little furry pets'
        ' in India who are looking for a home.';


    double _height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter(),),
          buildSignUp(_line1, _height,context),
        ],
      ),
    );

  }

  Widget buildSignUp(String _line1, double _height,context) => Column(
    children: [
      Spacer(),
      Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 40, right: 40, top: _height * 0.15 ),
            width: 175,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(fontSize: 20.0, color: Colors.white,
                      letterSpacing: 1.0,),),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Adotta Pets',
                    style: TextStyle(fontSize: 38.0, color: Colors.white,
                      letterSpacing: 1.0,),),
                ),
              ],
            ),
          ),
        ),
      ),
      Spacer(),
      Padding(
        padding: const EdgeInsets.only(right: 25,left: 25),
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: _line1,
                style: TextStyle(fontSize: 20.0, color: Colors.black87,
                  letterSpacing: 1.0,),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 30,),
      tapToContinue(context),
      Spacer(),
    ],
  );

  Widget tapToContinue(context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.red[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: OutlinedButton.icon(
        label: RichText(
          text: TextSpan(
            text: 'Tap to Continue',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        icon: FaIcon(FontAwesomeIcons.cat,
        color: Colors.white,),
        onPressed:  () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Wrapper(),
          )
          );
        },
      ),
    );
  }
}
