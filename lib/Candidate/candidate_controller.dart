import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiremeinindiaapp/Candidate/candidate_form_state.dart';
import 'package:hiremeinindiaapp/controllers/signupcontroller.dart';

import '../Models/candidated.dart';
import '../Models/results.dart';

class CandidateController {
  CandidateController({required this.formController});
  final CandidateFormController formController;

  static final candidateRef = FirebaseFirestore.instance.collection('users');
  Candidate get candidate => formController.candidate;

  Future<Result> addCandidate() {
    return candidate.reference
        .set(candidate.toJson())
        .then((value) =>
            Result(tilte: Result.success, message: "Staff added Successfully"))
        .onError((error, stackTrace) =>
            Result(tilte: "Staff addition Failed", message: error.toString()));
  }

  Future<Result> updateCandidate() {
    return candidate.reference
        .set(candidate.toJson())
        .then((value) => Result(
            tilte: Result.success,
            message: "Staff record updated successfully"))
        .onError((error, stackTrace) => Result(
            tilte: Result.failure, message: "Staff record update failed"));
  }

  Future<Result> deleteStaff() {
    return candidate.reference
        .delete()
        .then((value) => Result(
            tilte: Result.success,
            message: "Staff record updated successfully"))
        .onError((error, stackTrace) => Result(
            tilte: Result.failure, message: "Staff record update failed"));
  }

  static Future<List<Candidate>> loadStaffs(String search) {
    return candidateRef
        .where('search', arrayContains: search)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((e) => Candidate.fromSnapshot(e)).toList();
    });
  }
}
