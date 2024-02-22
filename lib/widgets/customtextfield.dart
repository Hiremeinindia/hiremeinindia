// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

@immutable
final class CustomTextfield extends StatelessWidget {
  Function(String)? onsaved;
  final String? text;
  final String? text1;
  final TextEditingController? controller;
  final List<Color>? colors;
  final double? dynamicHeight;
  String? Function(String?)? validator;
  final Function(String)? handleForm;

  CustomTextfield({
    this.controller,
    super.key,
    this.text1,
    this.text,
    this.colors,
    this.dynamicHeight,
    this.onsaved,
    this.validator,
    this.handleForm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dynamicHeight ?? 45.0,
      child: TextFormField(
        style: TextStyle(height: 1),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12),
          hintStyle: TextStyle(fontSize: 12, fontFamily: 'SegoeItalic'),
          hintText: text,
          errorText: text1,
          errorStyle: TextStyle(height: 0, fontSize: 8.5),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
