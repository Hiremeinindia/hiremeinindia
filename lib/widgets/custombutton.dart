// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

@immutable
final class CustomButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.infinity),
          primary: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(5), // Adjust border radius as needed
          ),
        ),
        child: Text(
          text!,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

@immutable
final class CustomRectButton extends StatelessWidget {
  Widget? child;
  late final Function()? onPressed;
  final Radius? topleft;
  final Radius? bottomright;
  final Radius? bottomleft;
  final Radius? topright;
  final Color? colors;
  final ImageIcon? image;

  CustomRectButton({
    Key? key,
    this.onPressed,
    this.colors,
    this.image,
    this.child,
    this.topleft,
    this.bottomright,
    this.bottomleft,
    this.topright,
  }) : super(key: key);

  Color _getColor(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return colors ?? Colors.transparent; // Change to your hover color
    }
    return Colors.white; // Default color
  }

  Radius _getRadius(Radius? radius) {
    return radius ?? Radius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
            (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: _getRadius(bottomleft),
                  topLeft: _getRadius(topleft),
                  bottomRight: _getRadius(bottomright),
                  topRight: _getRadius(topright),
                ),
                side: BorderSide(width: 1, color: Colors.black),
              );
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) => _getColor(states),
          ),
        ),
        child: image,
      ),
    );
  }
}
