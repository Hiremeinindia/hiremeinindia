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
  final Function(String)? onchanged;

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
    this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        child: TextFormField(
          style: TextStyle(height: 1),
          validator: validator,
          controller: controller,
          onChanged: handleForm,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5.0),
            hintText: text,
            errorText: text1,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(1))),
          ),
        ),
      ),
    );
  }
}
