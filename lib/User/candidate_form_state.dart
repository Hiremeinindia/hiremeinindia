import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Models/candidated.dart';

class CandidateFormController {
  CandidateFormController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  List<String>? selectedSkill = [];
  final workin = TextEditingController();
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

  TextEditingController confirmPassword = TextEditingController();

  bool isAdmin = false;
  double commissionAmount = 0;

  // String get newDocId => FirebaseFirestore.instance.collection('Candidates').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??=
        FirebaseFirestore.instance.collection('greycollaruser').doc();
    return _reference!;
  }

  int leadCount = 0;
  int successfullLeadCount = 0;

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
        selectedSkill: selectedSkill,
        workin: workin.text,
        password: password.text,
        otpm: otpm.text,
        code: code.text,
        confirmPassword: confirmPassword.text,
        country: country.text,
      );

  factory CandidateFormController.fromCandidate(Candidate candidate) {
    var controller = CandidateFormController();
    controller.name.text = candidate.name!;
    controller.mobile.text = candidate.mobile!;
    controller.email.text = candidate.email!;
    controller.worktitle.text = candidate.worktitle!;
    controller._reference = candidate.reference;
    controller.aadharno.text = candidate.aadharno!;
    controller.gender.text = candidate.gender!;
    controller.workexp.text = candidate.workexp!;
    controller.state.text = candidate.state!;
    controller.address.text = candidate.address!;
    controller.selectedSkill = candidate.selectedSkill ?? [];
    controller.workin.text = candidate.workin!;
    controller.password.text = candidate.password!;
    controller.otpm.text = candidate.otpm!;
    controller.code.text = candidate.code!;
    controller.confirmPassword.text = candidate.confirmPassword!;
    controller.country.text = candidate.country!;
    return controller;
  }
}

class BlueCandidateFormController {
  BlueCandidateFormController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final workin = TextEditingController();
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

  TextEditingController confirmPassword = TextEditingController();
  List<String> selectedSkills = [];

  bool isAdmin = false;
  double commissionAmount = 0;

  // String get newDocId => FirebaseFirestore.instance.collection('Candidates').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??=
        FirebaseFirestore.instance.collection('bluecollaruser').doc();
    return _reference!;
  }

  int leadCount = 0;
  int successfullLeadCount = 0;

  BlueCandidate get bluecandidate => BlueCandidate(
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
        workin: workin.text,
        password: password.text,
        otpm: otpm.text,
        code: code.text,
        confirmPassword: confirmPassword.text,
        country: country.text,
      );
  factory BlueCandidateFormController.fromCandidate(
      BlueCandidate bluecandidate) {
    var controller = BlueCandidateFormController();
    controller.name.text = bluecandidate.name!;
    controller.mobile.text = bluecandidate.mobile!;
    controller.email.text = bluecandidate.email!;
    controller.worktitle.text = bluecandidate.worktitle!;
    controller.aadharno.text = bluecandidate.aadharno!;
    controller.gender.text = bluecandidate.gender!;
    controller.workexp.text = bluecandidate.workexp!;
    controller.state.text = bluecandidate.state!;
    controller.address.text = bluecandidate.address!;

    controller.selectedSkills = bluecandidate.selectedSkills ?? [];
    controller.workin.text = bluecandidate.workin!;
    controller.password.text = bluecandidate.password!;
    controller.otpm.text = bluecandidate.otpm!;
    controller.code.text = bluecandidate.code!;
    controller.confirmPassword.text = bluecandidate.confirmPassword!;
    return controller;
  }
}
