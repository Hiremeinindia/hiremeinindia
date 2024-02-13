import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum CandidateStatus { verified, notVerified }

enum ActiveStatus { selected, curated, rejected }

class Candidate {
  final String? name;
  final String? email;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? workexp;
  final String? workexpcount;
  final String? state;
  final String? status;
  final String? address;
  final String? qualification;
  final String? aboutYou;
  final String? qualiDescription;
  final String? workin;
  final String? password;
  final String? otpm;
  final String? code;
  final String? course;
  final String? age;
  final String? project;
  final String? selectedOption;
  final String? country;
  final String? city;
  final String? expectedwage;
  final String? ctc;
  final String? currentwage;
  final String? confirmPassword;
  final String? verify;
  final String? imgPic;
  final String? imgVoter;
  final String? imgCv;
  final String? imgAadhar;
  final String? imgExp;
  String? get docId => reference!.id;
  final List<String>? skills;
  final List<String>? workins;
  final DocumentReference? reference;
  ActiveStatus activeStatus;

  Candidate(
      {this.name,
      this.email,
      this.mobile,
      this.worktitle,
      this.aadharno,
      this.gender,
      this.workexp,
      this.workexpcount,
      this.state,
      this.address,
      this.qualiDescription,
      this.qualification,
      this.aboutYou,
      this.ctc,
      this.age,
      this.skills,
      this.status,
      this.course,
      this.project,
      this.workins,
      this.workin,
      this.password,
      this.otpm,
      this.code,
      this.confirmPassword,
      this.country,
      this.reference,
      this.selectedOption,
      this.expectedwage,
      this.city,
      this.currentwage,
      this.verify,
      this.imgAadhar,
      this.imgCv,
      this.imgExp,
      this.activeStatus = ActiveStatus.curated,
      this.imgPic,
      this.imgVoter});

  toJson() => {
        "name": name,
        "reference": reference,
        "email": email,
        "mobile": mobile,
        "worktitle": worktitle,
        "aadharno": aadharno,
        "gender": gender,
        "workexpcount": workexpcount,
        "workexp": workexp,
        "state": state,
        "address": address,
        "qualification": qualification,
        "qualiDescription": qualiDescription,
        "skills": skills,
        "workins": workins,
        "workin": workin,
        "password": password,
        "imgpic": imgPic,
        "imgcv": imgCv,
        "docId": docId,
        "imgvoter": imgVoter,
        "imgaadhar": imgAadhar,
        "imgexp": imgExp,
        "age": age,
        "aboutYou": aboutYou,
        "otpm": otpm,
        "code": code,
        "course": course,
        "project": project,
        "ctc": ctc,
        "label": selectedOption,
        "labelText": status,
        "country": country,
        "confirmPassword": confirmPassword,
        "city": city,
        "expectedwage": expectedwage,
        "currentwage": currentwage,
      };

  factory Candidate.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Candidate(
        name: data["name"],
        email: data["email"],
        mobile: data["mobile"],
        reference: snapshot.reference,
        workexpcount: data["workexpcount"],
        workexp: data["workexp"],
        aadharno: data["aadharno"],
        gender: data["gender"],
        selectedOption: data["label"],
        status: data["labelText"],
        worktitle: data["worktitle"],
        qualification: data["qualification"],
        qualiDescription: data["qualiDescription"],
        state: data["state"],
        project: data["project"],
        aboutYou: data["aboutYou"],
        course: data["course"],
        address: data["address"],
        skills: List<String>.from(data["skills"] ?? []),
        workins: List<String>.from(data["workins"] ?? []),
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        age: data["age"],
        code: data["code"],
        country: data["country"],
        confirmPassword: data["confirmPassword"],
        city: data["city"],
        ctc: data["ctc"],
        expectedwage: data["expectedwage"],
        currentwage: data["currentwage"],
        imgAadhar: data["imgaadhar"],
        imgCv: data["imgcv"],
        imgExp: data["imgexp"],
        imgPic: data["imgpic"],
        imgVoter: data["imgvoter"]);
  }

  factory Candidate.fromJson(json, DocumentReference reference) {
    return Candidate(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        // reference: json["reference"],
        reference: reference,
        workexp: json["workexp"],
        workexpcount: json["workexpcount"],
        aadharno: json["aadharno"],
        gender: json["gender"],
        selectedOption: json["label"],
        status: json["labelText"],
        qualification: json["qualification"],
        qualiDescription: json["qualiDescription"],
        aboutYou: json["aboutYou"],
        worktitle: json["worktitle"],
        state: json["state"],
        age: json["age"],
        address: json["address"],
        skills: List<String>.from(json["skills"] ?? []),
        workins: List<String>.from(json["workins"] ?? []),
        workin: json["workin"],
        password: json["password"],
        otpm: json["otpm"],
        project: json["project"],
        course: json["course"],
        code: json["code"],
        country: json["country"],
        city: json["city"],
        ctc: json["ctc"],
        expectedwage: json["expectedwage"],
        currentwage: json["currentwage"],
        imgAadhar: json["imgaadhar"],
        imgCv: json["imgcv"],
        imgExp: json["imgexp"],
        imgPic: json["imgpic"],
        imgVoter: json["imgvoter"],
        confirmPassword: json["confirmPassword"]);
  }

  static Future<List<Candidate>> getCandidates(
      {Candidate? selectedSkills, Candidate? selectedQualification}) {
    return FirebaseFirestore.instance.collection('users').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }

  static Stream<List<Candidate>> getFilteredList({
    Candidate? selectedQualification,
    Candidate? selectedSkills,
  }) {
    // You can keep this method for additional filters if needed
    // Make sure not to apply the skills filter here since it's done in the query

    return FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Candidate.fromSnapshot(doc)).toList();
    });
  }

  Future<void> curated() {
    return FirebaseFirestore.instance
        .collection('greycollaruser')
        .doc(docId)
        .update({
      "labelText": 'Curated',
    });
  }

  Future<void> selected() {
    return FirebaseFirestore.instance
        .collection('greycollaruser')
        .doc(docId)
        .update({
      "labelText": 'Selected',
    });
  }

  Future<void> rejected() {
    return FirebaseFirestore.instance
        .collection('greycollaruser')
        .doc(docId)
        .update({
      "labelText": 'Rejected',
    });
  }

  Future<void> updateLabel(String labelText, Color labelColor) {
    return FirebaseFirestore.instance
        .collection('greycollaruser')
        .doc(docId)
        .update({
      'labelText': labelText,
      'labelColor': labelColor.value.toString(),
    });
  }
}
