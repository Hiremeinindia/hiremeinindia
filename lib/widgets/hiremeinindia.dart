import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../classes/language_constants.dart';

class HireMeInIndia extends StatelessWidget {
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;

  HireMeInIndia({
    this.size,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            translation(context).hire,
            textScaleFactor: ScaleSize.textScaleFactor(context),
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 15),
          ),
          Text(
            translation(context).meIn,
            textScaleFactor: ScaleSize.textScaleFactor(context),
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Color.fromARGB(255, 27, 105, 178),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 15),
          ),
          Text(
            translation(context).india,
            textScaleFactor: ScaleSize.textScaleFactor(context),
            style: TextStyle(
                decoration: TextDecoration.none,
                color: const Color.fromARGB(255, 117, 115, 115),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1000) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
