import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HowToUse extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            text: 'How to use?',
            style: TextStyle(
                fontSize: 15.0
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(LineIcons.angleLeft,
            color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 2.0,
        centerTitle: true,
        backgroundColor: Colors.teal[700],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Point 1
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: '1. Login with Google',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(width: 40,
                    child: Icon(LineIcons.googlePlus,
                      color: Colors.red[800],
                      size: 25,),),

                  RichText(
                    text: TextSpan(
                      text: ' or Email',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  SizedBox(width: 40,
                    child: Icon(LineIcons.envelopeAlt,
                      color: Colors.yellow[800],
                      size: 25,),)
                ],
              ),

              //Point 2
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '2. Home Screen',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      letterSpacing: 1.2
                  ),
                ),
              ),
              SizedBox(height: 15,),

              //Home Screen Image
              Image.asset('assets/home.jpg', width: 300, height: 300,),

              //Icon and Text
              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(Icons.menu,
                    size: 25,),
                  RichText(
                    text: TextSpan(
                      text: '  Tap this icon to open navigation bar',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          letterSpacing: 1.2
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),
              Row(
                children: [
                  Icon(LineIcons.alternateCloudUpload,
                    size: 25,),
                  RichText(
                    text: TextSpan(
                      text: '  Tap this icon to upload an adoption post',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          letterSpacing: 1.2
                      ),
                    ),
                  ),
                ],
              ),

              //Search Bar
              Image.asset('assets/searchbar.jpg',
                width: 300,
                height: 100,),

              //Point 3
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '3. Filter the list by entering city or Pin Code in the search bar',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              //Point 4
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '4. Tap on the tile to see the post details',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              //Point 5
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '5. You will see update button under your posts',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),


              //Point 6
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '6. Once user changes status to Adopted the post will be disabled',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              //Point 7
              SizedBox(height: 15,),
              RichText(
                text: TextSpan(
                  text: '7. Detail Screen',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              //Pet Detail
              Image.asset('assets/detail1.jpg',
                width: 250,
                height: 250,),


              //Icons and Text
              Row(
                children: [
                  Icon(Icons.image,
                    size: 25,),
                  RichText(
                    text: TextSpan(
                      text: '  Tap on the image to view in full screen',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          letterSpacing: 1.2
                      ),
                    ),
                  ),
                ],
              ),


              //Icon and Text
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.supervised_user_circle_rounded,
                    size: 25,),
                  RichText(
                    text: TextSpan(
                      text: '  Tap this icon to view uploader details',
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.0,
                          letterSpacing: 1.2
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
          //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        ),
      ),

    );
  }
}
