// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rohan_erojgar/constants.dart';

enum AppBarStyle { outCircular, curved, largeCurved }

class CurvePainter extends CustomPainter {
  AppBarStyle appBarStyle = AppBarStyle.curved;

  @override
  void paint(Canvas canvas, Size size) {
    var fillPaint = Paint()..color = Colors.blue;

    var path = Path();

    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}

PreferredSize styledAppBar(BuildContext context, Widget child,
    {AppBarStyle appBarStyle = AppBarStyle.curved, Size? paintSize}) {
  Size paintingSize = paintSize ??
      Size(MediaQuery.of(context).size.width,
          appBarStyle == AppBarStyle.largeCurved ? 50 : 25);
  double preferredAppBarHeightWithoutPaint = 60.0;
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width,
        preferredAppBarHeightWithoutPaint + paintingSize.height),
    child: SafeArea(
      child: Column(
        children: [
          Container(
            height: preferredAppBarHeightWithoutPaint,
            width: double.infinity,
            child: child,
            color: primaryColorBG,
          ),
          SizedBox(
            height: paintingSize.height,
            width: paintingSize.width,
            child: CustomPaint(
              painter: CurvePainter()..appBarStyle = appBarStyle,
              size: paintingSize,
            ),
          ),
        ],
      ),
    ),
  );
}
