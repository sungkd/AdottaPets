import 'package:flutter/material.dart';

class Point {
  final double _xAxis;
  final double _yAxis;

  Point(this._xAxis, this._yAxis);
}

class BackgroundPainter extends CustomPainter {

  final Paint _bluePaint;
  final Paint _greyPaint;
  final Paint _orangePaint;

  BackgroundPainter()
      : _bluePaint = Paint()
    ..color = Colors.lightBlue.shade300
    ..style = PaintingStyle.fill,
        _greyPaint = Paint()
          ..color = Colors.blueGrey[900]
          ..style = PaintingStyle.fill,
        _orangePaint = Paint()
          ..color = Colors.orange.shade400
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(size,canvas);
    paintDark(size,canvas);
    paintOrange(size,canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void paintBlue(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);

    _addPointsToPath(path,
        [
          Point(size.width * 0.35, size.height * 0.35),
          Point(size.width, size.height * 0.6),
          Point(size.width, size.height * 0.55),
        ]

    );


    canvas.drawPath(path,_bluePaint);
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need 3+ points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xDiff = (points[i]._xAxis + points[i + 1]._xAxis) / 2;
      final yDiff = (points[i]._yAxis + points[i + 1]._yAxis) / 2;
      path.quadraticBezierTo(points[i]._xAxis, points[i]._yAxis, xDiff, yDiff);
    }

    final secondLastPoint = points[points.length - 2];
    final lastPoint = points[points.length - 1];
    path.quadraticBezierTo(
        secondLastPoint._xAxis, secondLastPoint._yAxis, lastPoint._xAxis, lastPoint._yAxis);
  }

  void paintDark(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.48);

    _addPointsToPath(path,
        [
          Point(size.width * 0.5, size.height * 0.65),
          Point(size.width * 0.7, size.height * 0.2),
          Point(size.width, size.height * 0.15),
        ]

    );


    canvas.drawPath(path,_greyPaint);
  }

  void paintOrange(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width * 0.75, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.2);

    _addPointsToPath(path,
        [
          Point(size.width * 0.2,  size.height * 0.25),
          Point(size.width * 0.35, size.height * 0.1),
          Point(size.width * 0.65, size.height * 0.06),
          Point(size.width * 0.75, 0),

        ]

    );


    canvas.drawPath(path,_orangePaint);

  }

}