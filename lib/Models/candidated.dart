import 'package:cloud_firestore/cloud_firestore.dart';

class Candidate {
  final String? name;
  final String? email;
  final String? mobile;
  final DocumentReference reference;

  Candidate({
    this.name,
    this.email,
    this.mobile,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        "firstName": name,
        "reference": reference,
        "email": email,
        "mobile": mobile
      };

  static Candidate fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Candidate(
      name: data["name"],
      email: data["email"],
      mobile: data["mobile"],
      reference: snapshot.reference,
    );
  }

  factory Candidate.fromJson(data) {
    return Candidate(
      name: data["name"],
      email: data["email"],
      mobile: data["mobile"],
      reference: data['reference'],
    );
  }

  static Future<List<Candidate>> getCandidates() {
    return FirebaseFirestore.instance.collection('users').get().then(
        (value) => value.docs.map((e) => Candidate.fromSnapshot(e)).toList());
  }
}
