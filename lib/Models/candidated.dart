import 'package:cloud_firestore/cloud_firestore.dart';

class Candidate {
  final String? name;
  final String? email;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? workexp;
  final String? state;
  final String? address;
  final String? skills;
  final String? workin;
  final String? password;
  final String? otpm;
  final String? code;
  final String? country;
  final String? confirmPassword;
  final DocumentReference reference;

  Candidate({
    this.name,
    this.email,
    this.mobile,
    this.worktitle,
    this.aadharno,
    this.gender,
    this.workexp,
    this.state,
    this.address,
    this.skills,
    this.workin,
    this.password,
    this.otpm,
    this.code,
    this.confirmPassword,
    this.country,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "email": email,
        "mobile": mobile,
        "worktitle": worktitle,
        "aadharno": aadharno,
        "gender": gender,
        "workexp": workexp,
        "state": state,
        "address": address,
        "skills": skills,
        "workin": workin,
        "password": password,
        "otpm": otpm,
        "code": code,
        "country": country,
        "confirmPassword": confirmPassword,
      };

  static Candidate fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Candidate(
        name: data["name"],
        email: data["email"],
        mobile: data["mobile"],
        reference: snapshot.reference,
        workexp: data["workexp"],
        aadharno: data["aadharno"],
        gender: data["gender"],
        worktitle: data["worktitle"],
        state: data["state"],
        address: data["address"],
        skills: data["skills"],
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        code: data["code"],
        country: data["country"],
        confirmPassword: data["confirmPassword"]);
  }

  factory Candidate.fromJson(data) {
    return Candidate(
        name: data["name"],
        email: data["email"],
        mobile: data["mobile"],
        reference: data["reference"],
        workexp: data["workexp"],
        aadharno: data["aadharno"],
        gender: data["gender"],
        worktitle: data["worktitle"],
        state: data["state"],
        address: data["address"],
        skills: data["skills"],
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        code: data["code"],
        country: data["country"],
        confirmPassword: data["confirmPassword"]);
  }

  static Future<List<Candidate>> getCandidates() {
    return FirebaseFirestore.instance.collection('users').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }
}

class BlueCandidate {
  final String? name;
  final String? email;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? workexp;
  final String? state;
  final String? address;
  final String? skills;
  final String? workin;
  final String? password;
  final String? otpm;
  final String? code;
  final String? confirmPassword;
  final String? country;
  final DocumentReference reference;

  BlueCandidate({
    this.name,
    this.email,
    this.country,
    this.mobile,
    this.worktitle,
    this.aadharno,
    this.gender,
    this.workexp,
    this.state,
    this.address,
    this.skills,
    this.workin,
    this.password,
    this.otpm,
    this.code,
    this.confirmPassword,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "reference": reference,
        "email": email,
        "mobile": mobile,
        "worktitle": worktitle,
        "aadharno": aadharno,
        "gender": gender,
        "workexp": workexp,
        "state": state,
        "address": address,
        "skills": skills,
        "workin": workin,
        "password": password,
        "otpm": otpm,
        "country": country,
        "code": code,
        "confirmPassword": confirmPassword,
      };

  static BlueCandidate fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return BlueCandidate(
        name: data["name"],
        email: data["email"],
        mobile: data["mobile"],
        reference: snapshot.reference,
        workexp: data["workexp"],
        aadharno: data["aadharno"],
        gender: data["gender"],
        worktitle: data["worktitle"],
        state: data["state"],
        address: data["address"],
        skills: data["skills"],
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        code: data["code"],
        country: data["country"],
        confirmPassword: data["confirmPassword"]);
  }

  factory BlueCandidate.fromJson(data) {
    return BlueCandidate(
        name: data["name"],
        email: data["email"],
        mobile: data["mobile"],
        reference: data["reference"],
        workexp: data["workexp"],
        aadharno: data["aadharno"],
        gender: data["gender"],
        worktitle: data["worktitle"],
        state: data["state"],
        address: data["address"],
        skills: data["skills"],
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        country: data["country"],
        code: data["code"],
        confirmPassword: data["confirmPassword"]);
  }

  static Future<List<Candidate>> getCandidates() {
    return FirebaseFirestore.instance.collection('bluecollaruser').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }
}
