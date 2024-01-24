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

  static Future<List<Candidate>> loadStaffs(String search) {
    return candidateRef
        .where('search', arrayContains: search)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((e) => Candidate.fromSnapshot(e)).toList();
    });
  }
}
