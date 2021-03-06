import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow[500],
      child: Center(
        child: SpinKitSquareCircle(
          color: Colors.blue[500],
          size: 50.0,
        ),
      ),
    );
  }
}
