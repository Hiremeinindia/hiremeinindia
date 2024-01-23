import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/candidated.dart';

class CandidateFormController {
  CandidateFormController({String? initialSelectedOption}) {
    selectedOption = TextEditingController(text: initialSelectedOption);
  }
  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final otpm = TextEditingController();
  final code = TextEditingController();
  final otp = TextEditingController();
  final contry = TextEditingController();
  final qualification = TextEditingController();
  final city = TextEditingController();
  final expectedWage = TextEditingController();
  final currentWage = TextEditingController();
  final bluecoller = TextEditingController();
  final country = TextEditingController();
  final confirmPassword = TextEditingController();
  List<String> selectedSkills = [];
  List<String> selectedWorkins = [];
  late TextEditingController selectedOption;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??=
        FirebaseFirestore.instance.collection('greycollaruser').doc();
    return _reference!;
  }

  Candidate get candidate => Candidate(
        reference: reference,
        name: name.text,
        email: email.text,
        mobile: mobile.text,
        worktitle: worktitle.text,
        aadharno: aadharno.text,
        gender: gender.text,
        workexp: workexp.text,
        state: state.text,
        address: address.text,
        selectedSkills: selectedSkills,
        qualification: qualification.text,
        selectedWorkins: selectedWorkins,
        password: password.text,
        otpm: otpm.text,
        code: code.text,
        selectedOption: selectedOption.text,
        confirmPassword: confirmPassword.text,
        country: country.text,
      );
}
