import 'package:cloud_firestore/cloud_firestore.dart';

import '../User/user.dart';

import 'package:flutter/material.dart';

class FirebaseService with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Candidate>> getFilteredCandidates(
      String job, String qualification) async {
    Query<Map<String, dynamic>> baseQuery =
        _firestore.collection("greycollaruser");

    if (job != 'All') {
      baseQuery = baseQuery.where('jobClassification', isEqualTo: job);
    }

    if (qualification != 'All') {
      baseQuery = baseQuery.where('qualification', isEqualTo: qualification);
    }

    QuerySnapshot querySnapshot = await baseQuery.get();

    List<Candidate> candidates = querySnapshot.docs.map((doc) {
      return Candidate(
        reference: doc.reference,
        name: doc['name'].toString(),
        mobile: doc['mobile'].toString(),
        qualification: doc['qualification'].toString(),
        selectedSkills: (doc['selectedSkills'] as List<dynamic>).cast<String>(),
        selectedOption: doc['selectedOption'].toString(),
        // Add other fields as needed
      );
    }).toList();

    notifyListeners(); // Notify listeners after data changes
    return candidates;
  }
}
