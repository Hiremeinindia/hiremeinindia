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

  factory Candidate.fromJson(json, DocumentReference reference) {
    return Candidate(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        reference: json["reference"],
        workexp: json["workexp"],
        aadharno: json["aadharno"],
        gender: json["gender"],
        selectedOption: json["selectedOption"],
        qualification: json["qualification"],
        worktitle: json["worktitle"],
        state: json["state"],
        address: json["address"],
        selectedSkills: List<String>.from(json["selectedSkills"] ?? []),
        selectedWorkins: List<String>.from(json["selectedWorkins"] ?? []),
        workin: json["workin"],
        password: json["password"],
        otpm: json["otpm"],
        code: json["code"],
        country: json["country"],
        confirmPassword: json["confirmPassword"]);
  }

  static Future<List<Candidate>> getCandidates({Candidate? candidate}) {
    return FirebaseFirestore.instance.collection('greycollaruser').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }

  static Stream<List<Candidate>> getQualifications({Candidate? candidate}) {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('greycollaruser');

    if (candidate?.qualification != null) {
      print('Qualification: ${candidate!.qualification}');
      query = query.where("qualification", isEqualTo: candidate.qualification);
    } else {
      print('Qualification or its reference is null');
      // Handle the case where qualification or its reference is null.
    }

    return query.snapshots().map((event) {
      var list = event.docs.map((e) => Candidate.fromSnapshot(e)).toList();

      if (candidate != null) {
        print(
            'Filtering list for candidate with reference: ${candidate.reference}');
        // Filter the list to include only the specified candidate
        list = list
            .where((element) => element.reference == candidate.reference)
            .toList();
      }

      print('Final List: $list');

      return list;
    });
  }
}
