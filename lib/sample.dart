import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporateDashboard.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporateFormState.dart';
import 'package:hiremeinindiaapp/authservice.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'package:hiremeinindiaapp/userdashboard.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'Widgets/customtextstyle.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'widgets/custombutton.dart';

class SamplePage extends StatefulWidget {
  const SamplePage();
  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  CorporateFormController controller = CorporateFormController();
  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  String name = '';

  String? skill = "Electrician";
  List<String> jobClassification = [
    'Electrician',
    'Mechanic',
    'Construction Helper ',
    'Meson ',
  ];
  bool login = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 30,
          width: 200,
          child: DropdownButton<String>(
            value: skill,
            isExpanded: true,
            items: jobClassification
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                .toList(),
            onChanged: (item) {
              setState(() {
                skill = item!;
              });
            },
            icon: Icon(
              Icons.arrow_drop_down_sharp,
              size: 25,
              color: Colors.black,
            ),
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.black,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
