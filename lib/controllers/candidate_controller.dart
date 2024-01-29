import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hiremeinindiaapp/User/userFormState.dart';
import '../User/user.dart';

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
      List<String> imageUrls = await uploadImages(controller);
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
        'workins': controller.workins,
        "city": controller.city.text,
        "country": controller.country.text,
        'skills': controller.skills,
        "label": controller.selectedOption.text,
        "expectedwage": controller.expectedwage,
        "currentwage": controller.currentwage,
        "imageUrls": imageUrls,
      }, SetOptions(merge: true));

      print('Candidate added successfully');
    } catch (error) {
      print('Error adding candidate: $error');
      throw error;
    }
  }

  Future<List<String>> uploadImages(CandidateFormController controller) async {
    List<String> imageUrls = [];
    try {
      for (File image in controller.images) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('candidate_images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(image);
        final urlDownload = await ref.getDownloadURL();
        imageUrls.add(urlDownload);
      }
    } catch (error) {
      print('Error uploading images: $error');
      throw error;
    }
    return imageUrls;
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
