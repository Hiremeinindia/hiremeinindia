import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'user.dart';

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
  final expectedwage = TextEditingController();
  final currentwage = TextEditingController();
  final bluecoller = TextEditingController();
  final country = TextEditingController();
  final confirmPassword = TextEditingController();
  List<File> images = [];
  List<String> skills = [];
  List<String> workins = [];
  late TextEditingController selectedOption;
  File? image;
  File? imageUrl;
  File? imageUrl1;
  File? imageUrl2;
  File? imageUrl3;
  File? imageUrl4;
  File? imageUrl5;
  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('users').doc();
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
        skills: skills,
        qualification: qualification.text,
        workins: workins,
        password: password.text,
        otpm: otpm.text,
        code: code.text,
        selectedOption: selectedOption.text,
        confirmPassword: confirmPassword.text,
        country: country.text,
        city: city.text,
        expectedwage: expectedwage.text,
        currentwage: currentwage.text,
        imageUrl: '',
        imageUrl1: '',
        imageUrl2: '',
        imageUrl3: '',
        imageUrl4: '',
        imageUrl5: '',
      );

  Future<void> setImage(File imageFile) async {
    image = imageFile;
  }
}
