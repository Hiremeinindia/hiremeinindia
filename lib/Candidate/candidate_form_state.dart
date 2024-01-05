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
  final skills = TextEditingController();
  final workin = TextEditingController();
  final password = TextEditingController();
  final otpm = TextEditingController();
  final code = TextEditingController();

  TextEditingController confirmPassword = TextEditingController();

  bool isAdmin = false;
  double commissionAmount = 0;

  // String get newDocId => FirebaseFirestore.instance.collection('Candidates').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('users').doc();
    return _reference!;
  }

  int leadCount = 0;
  int successfullLeadCount = 0;

  Candidate get candidate => Candidate(
        reference: reference,
        name: name.text,
        email: email.text,
        mobile: mobile.text,
      );

  factory CandidateFormController.fromCandidate(Candidate candidate) {
    var controller = CandidateFormController();
    controller.name.text = candidate.name!;
    controller.mobile.text = candidate.mobile!;
    controller.email.text = candidate.email!;
    controller._reference = candidate.reference;
    return controller;
  }
}
