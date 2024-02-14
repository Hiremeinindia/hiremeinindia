import 'package:flutter/material.dart';

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
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: translation(context).hire,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.indigo.shade900,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 25),
          ),
          TextSpan(
            text: translation(context).meIn,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: Color.fromARGB(255, 27, 105, 178),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 25),
          ),
          TextSpan(
            text: translation(context).india,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: const Color.fromARGB(255, 117, 115, 115),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 25),
          ),
        ],
      ),
    );
  }
}
