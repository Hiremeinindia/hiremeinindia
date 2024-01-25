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
  final List<String>? selectedSkills;
  final String? qualification;
  final List<String>? selectedWorkins;
  final String? workin;
  final String? password;
  final String? otpm;
  final String? code;
  final String? selectedOption;
  final String? country;
  final String? confirmPassword;
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
    this.selectedSkills,
    this.selectedWorkins,
    this.workin,
    this.password,
    this.otpm,
    this.code,
    this.confirmPassword,
    this.country,
    this.reference,
    this.selectedOption,
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
        "qualification": qualification,
        "selectedSkill": selectedSkills,
        "selectedWorkin": selectedWorkins,
        "workin": workin,
        "password": password,
        "otpm": otpm,
        "code": code,
        "selectedOption": selectedOption,
        "country": country,
        "confirmPassword": confirmPassword,
      };

  factory Candidate.fromSnapshot(DocumentSnapshot snapshot) {
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
        selectedSkills: List<String>.from(data["selectedSkills"] ?? []),
        selectedWorkins: List<String>.from(data["selectedWorkins"] ?? []),
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
        selectedOption: data["selectedOption"],
        qualification: data["qualification"],
        worktitle: data["worktitle"],
        state: data["state"],
        address: data["address"],
        selectedSkills: List<String>.from(data["selectedSkills"] ?? []),
        selectedWorkins: List<String>.from(data["selectedWorkins"] ?? []),
        workin: data["workin"],
        password: data["password"],
        otpm: data["otpm"],
        code: data["code"],
        country: data["country"],
        confirmPassword: data["confirmPassword"]);
  }

  static Future<List<Candidate>> getCandidates({Candidate? candidate}) {
    return FirebaseFirestore.instance.collection('greycollaruser').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }

  static Stream<List<Candidate>> getSkills(
      {Candidate? selectedSkills, Candidate? qualification}) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('greycollaruser');
    if (selectedSkills != null) {
      query =
          query.where("selectedSkills"[0], isEqualTo: selectedSkills.reference);
    }
    if (qualification != null) {
      query = query.where("qualification", isEqualTo: qualification.reference);
    }

    return query.snapshots().map((event) {
      return event.docs.map((e) => Candidate.fromSnapshot(e)).toList();
    });
  }
}
