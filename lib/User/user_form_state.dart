import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import 'user.dart';

class CandidateFormController {
  CandidateFormController();
  final name = TextEditingController();
  final mobile = TextEditingController();
  final email = TextEditingController();
  final age = TextEditingController();
  final worktitle = TextEditingController();
  final aadharno = TextEditingController();
  final gender = TextEditingController();
  final workexp = TextEditingController();
  final workexpcount = TextEditingController();
  final state = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final otpm = TextEditingController();
  final code = TextEditingController();
  final otp = TextEditingController();
  final course = TextEditingController();
  final project = TextEditingController();
  final qualification = TextEditingController();
  final qualiDescription = TextEditingController();
  final aboutYou = TextEditingController();
  final city = TextEditingController();
  final expectedwage = TextEditingController();
  final currentwage = TextEditingController();
  final ctc = TextEditingController();
  final bluecoller = TextEditingController();
  final country = TextEditingController();
  final confirmPassword = TextEditingController();
  final imgpic = TextEditingController();
  final imgcv = TextEditingController();
  final imgexp = TextEditingController();
  final imgaadhar = TextEditingController();
  final imgvoter = TextEditingController();
  final cashreceipt = TextEditingController();
  final selectedOption = TextEditingController();
  List<File> images = [];
  List<String> skills = [];
  List<String> workins = [];
  FilePickerResult? imagePic;
  FilePickerResult? imageExp;
  FilePickerResult? imageCv;
  FilePickerResult? imageVoter;
  FilePickerResult? imageAadhar;
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
      course: course.text,
      age: age.text,
      project: project.text,
      skills: skills,
      qualification: qualification.text,
      aboutYou: aboutYou.text,
      qualiDescription: qualiDescription.text,
      ctc: ctc.text,
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
      imgAadhar: imgaadhar.text,
      imgCv: imgcv.text,
      imgExp: imgexp.text,
      imgPic: imgpic.text,
      imgVoter: imgvoter.text);
}
