import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/Models/register_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(RegisterModal user) async {
    await _db
        .collection("greycollarusers")
        .add(user.tojson())
        .whenComplete(
          () => Get.snackbar(("success"), "Your account has been created",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<Candidate> getUserDetails(String email) async {
    final snapshot = await _db
        .collection("greycollaruser")
        .where("name", isEqualTo: email)
        .get();
    final userData = snapshot.docs.map((e) => Candidate.fromSnapshot(e)).single;
    return userData;
  }

  Future<List<Candidate>> allUser() async {
    final snapshot = await _db.collection("greycollaruser").get();
    final userData =
        snapshot.docs.map((e) => Candidate.fromSnapshot(e)).toList();
    return userData;
  }
}
