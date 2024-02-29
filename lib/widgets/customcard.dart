import 'package:flutter/material.dart';

final class CustomCard extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color? shadowColor;
  final String title1;
  final String title2;

  const CustomCard({
    super.key,
    this.onTap,
    required this.color,
    this.shadowColor,
    required this.title1,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 140, 138, 138),
              spreadRadius: 0.5, //spread radius
              blurRadius: 4, // blu
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                title2,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
