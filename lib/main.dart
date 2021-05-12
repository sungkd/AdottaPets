import 'package:adottapets/screens/welcome.dart';
import 'package:adottapets/services/auth.dart';
import 'package:adottapets/services/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adottapets/screens/wrapper.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => LoadScreen(),
    },
  ));
}


class LoadScreen extends StatelessWidget {
  const LoadScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   initialRoute:  'home',
    //   routes: {
    //     // 'onboard' : (context) => OnBoardingPage(),
    //     'home' : (context) => Wrapper(),
    //   },
    // );
    return MultiProvider(
      child: MaterialApp(
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        initialRoute:  'home',
        routes: {
          'onboard' : (context) => OnBoardingPage(),
          'home' : (context) => Welcome(),
        },
      ),
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => DatabaseService()),
      ],

    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Wrapper()),
    );
  }

  Widget _buildFullscrenImage() {
    return Image.asset(
      'assets/kitty.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {

    String _line1 = 'Get information of all the little furry pets'
        ' in India who are looking for a home.';
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "AdottaPets",
          body:
          "Pet Adoption App.\n\n $_line1",
          image: _buildFullscrenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Our Idea",
          body:
          "Provide a dedicated platform where people all over India can "
              "put animals for adoption",
          image: _buildImage('sleepy.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "How it works?",
          body:
          "Sign in with your Google Account.\n Check for pets nearby\n"
              "Connect with the uploader with a single tap\n",
          image: _buildImage('dog1.jpg'),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding:  const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      // ? const EdgeInsets.all(12.0)
      // : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}



