import 'package:cloud_firestore/cloud_firestore.dart';

enum CandidateStatus { verified, notVerified }

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
  final List<String>? skills;
  final String? qualification;
  final List<String>? workins;
  final String? workin;
  final String? password;
  final String? otpm;
  final String? code;
  final String? selectedOption;
  final String? country;
  final String? city;
  final String? expectedwage;
  final String? currentwage;
  final String? confirmPassword;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? imageUrl4;
  final String? imageUrl5;
  final String? imageUrl;
  final DocumentReference? reference;

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
    this.qualification,
    this.skills,
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
    this.imageUrl1,
    this.imageUrl2,
    this.imageUrl3,
    this.imageUrl4,
    this.imageUrl5,
    this.imageUrl,
  });

  toJson() => {
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
        "qualification": qualification,
        "skills": skills,
        "workins": workins,
        "workin": workin,
        "password": password,
        "otpm": otpm,
        "code": code,
        "selectedOption": selectedOption,
        "country": country,
        "confirmPassword": confirmPassword,
        "city": city,
        "expectedwage": expectedwage,
        "currentwage": currentwage,
        "imageUrl1": imageUrl1,
        "imageUrl2": imageUrl2,
        "imageUrl3": imageUrl3,
        "imageUrl4": imageUrl4,
        "imageUrl5": imageUrl5,
        "imageUrl": imageUrl,
      };

  factory Candidate.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Candidate(
      name: data["name"],
      email: data["email"],
      mobile: data["mobile"],
      reference: snapshot.reference,
      workexp: data["workexp"],
      aadharno: data["aadharno"],
      gender: data["gender"],
      selectedOption: data["selectedOption"],
      worktitle: data["worktitle"],
      qualification: data["qualification"],
      state: data["state"],
      address: data["address"],
      skills: List<String>.from(data["skills"] ?? []),
      workins: List<String>.from(data["workins"] ?? []),
      workin: data["workin"],
      password: data["password"],
      otpm: data["otpm"],
      code: data["code"],
      country: data["country"],
      confirmPassword: data["confirmPassword"],
      city: data["city"],
      expectedwage: data["expectedwage"],
      currentwage: data["currentwage"],
      imageUrl1: data["imageUrl1"],
      imageUrl2: data["imageUrl2"],
      imageUrl3: data["imageUrl3"],
      imageUrl4: data["imageUrl4"],
      imageUrl5: data["imageUrl5"],
      imageUrl: data["imageUrl"],
    );
  }

  factory Candidate.fromJson(json, DocumentReference reference) {
    return Candidate(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        // reference: json["reference"],
        reference: reference,
        workexp: json["workexp"],
        aadharno: json["aadharno"],
        gender: json["gender"],
        selectedOption: json["selectedOption"],
        qualification: json["qualification"],
        worktitle: json["worktitle"],
        state: json["state"],
        address: json["address"],
        skills: List<String>.from(json["skills"] ?? []),
        workins: List<String>.from(json["workins"] ?? []),
        workin: json["workin"],
        password: json["password"],
        otpm: json["otpm"],
        code: json["code"],
        country: json["country"],
        city: json["city"],
        expectedwage: json["expectedwage"],
        currentwage: json["currentwage"],
        imageUrl1: json["imageUrl1"],
        imageUrl2: json["imageUrl2"],
        imageUrl3: json["imageUrl3"],
        imageUrl4: json["imageUrl4"],
        imageUrl5: json["imageUrl5"],
        imageUrl: json["imageUrl"],
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
}
