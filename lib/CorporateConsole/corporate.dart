import 'package:cloud_firestore/cloud_firestore.dart';

class Corporate {
  String name;
  String? companyName;
  String? designation;
  String? email;
  String? password;
  String? confirmPassword;
  DocumentReference? reference;
  String? selectedOption;

  Corporate({
    required this.name,
    this.companyName,
    this.designation,
    this.email,
    this.password,
    this.confirmPassword,
    this.selectedOption,
    this.reference,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "companyname": companyName,
        "designation": designation,
        "reference": reference,
        "email": email,
        "password": password,
        "label": selectedOption,
      };

  static Corporate fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Corporate(
        name: data["name"],
        companyName: data["companyName"],
        designation: data["designation"],
        email: data["email"],
        reference: snapshot.reference,
        password: data["password"],
        selectedOption: data["selectedOption"],
        confirmPassword: data["confirmPassword"]);
  }

  factory Corporate.fromJson(data) {
    return Corporate(
        name: data["name"],
        companyName: data["companyName"],
        designation: data["designation"],
        email: data["email"],
        reference: data["reference"],
        password: data["password"],
        selectedOption: data["selectedOption"],
        confirmPassword: data["confirmPassword"]);
  }

  static Future<List<Corporate>> getCorporates() {
    return FirebaseFirestore.instance.collection('corporateuser').get().then(
        (value) => value.docs.map((e) => Corporate.fromSnapshot(e)).toList());
  }
}
