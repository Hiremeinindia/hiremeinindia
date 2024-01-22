import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiremeinindiaapp/User/candidate_form_state.dart';

import '../Models/candidated.dart';
import '../Models/results.dart';

class CandidateController {
  CandidateController({
    this.formController,
  });
  final CandidateFormController? formController;

  static final candidateRef =
      FirebaseFirestore.instance.collection('greycollaruser');

  Candidate get candidate => formController!.candidate;

  Future<void> addCandidate(CandidateFormController controller) async {
    try {
      await controller.reference.set({
        'name': controller.name.text,
        'email': controller.email.text,
        'mobile': controller.mobile.text,
        'worktitle': controller.worktitle.text,
        "aadharno": controller.aadharno.text,
        "gender": controller.gender.text,
        "workexp": controller.workexp.text,
        "qualification": controller.qualification.text,
        "state": controller.state.text,
        "address": controller.address.text,
        'selectedWorkins': controller.selectedWorkins ?? [],
        "city": controller.city.text,
        "country": controller.country.text,
        'selectedSkills': controller.selectedSkills ?? [],
        "label": controller.selectedOption.text,
      }, SetOptions(merge: true));

      print('Candidate added successfully');
    } catch (error) {
      print('Error adding candidate: $error');
      throw error;
    }
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

class BlueCandidateController {
  BlueCandidateController({required this.blueformController});

  final BlueCandidateFormController blueformController;

  static final bluecandidateRef =
      FirebaseFirestore.instance.collection('bluecollaruser').doc();
  BlueCandidate get bluecandidate => blueformController.bluecandidate;

  Future<void> addCandidate(BlueCandidateFormController bluecontroller) async {
    try {
      await bluecontroller.reference.set({
        'name': bluecontroller.name.text,
        'email': bluecontroller.email.text,
        'mobile': bluecontroller.mobile.text,
        'worktitle': bluecontroller.worktitle.text,
        "aadharno": bluecontroller.aadharno.text,
        "gender": bluecontroller.gender.text,
        "workexp": bluecontroller.workexp.text,
        "qualification": bluecontroller.qualification.text,
        "state": bluecontroller.state.text,
        "address": bluecontroller.address.text,
        'selectedWorkins': bluecontroller.selectedWorkins ?? [],
        "city": bluecontroller.city.text,
        "country": bluecontroller.country.text,
        'selectedSkills': bluecontroller.selectedSkills ?? [],
      }, SetOptions(merge: true));

      print('Candidate added successfully');
    } catch (error) {
      print('Error adding candidate: $error');
      throw error;
    }
  }

  Future<Result> updateCandidate() {
    return bluecandidate.reference
        .set(bluecandidate.toJson())
        .then((value) => Result(
            tilte: Result.success,
            message: "Staff record updated successfully"))
        .onError((error, stackTrace) => Result(
            tilte: Result.failure, message: "Staff record update failed"));
  }

  Future<Result> deleteStaff() {
    return bluecandidate.reference
        .delete()
        .then((value) => Result(
            tilte: Result.success,
            message: "Staff record updated successfully"))
        .onError((error, stackTrace) => Result(
            tilte: Result.failure, message: "Staff record update failed"));
  }
}
