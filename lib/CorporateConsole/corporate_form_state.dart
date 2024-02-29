import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'corporate.dart';

class CorporateFormController {
  CorporateFormController();
  final companyName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final designation = TextEditingController();
  final name = TextEditingController();
  late final selectedOption = TextEditingController();

  // String get newDocId => FirebaseFirestore.instance.collection('Corporates').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('corporateuser').doc();
    return _reference!;
  }

  Corporate get corporate => Corporate(
        reference: reference,
        name: name.text,
        companyName: companyName.text,
        email: email.text,
        password: password.text,
        designation: designation.text,
        confirmPassword: confirmPassword.text,
        selectedOption: selectedOption.text,
      );
}
