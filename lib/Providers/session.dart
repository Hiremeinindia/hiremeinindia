import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate.dart';
import 'package:hiremeinindiaapp/Models/candidated.dart';
import '../Models/results.dart';

class AppSession extends ChangeNotifier {
  List<Candidate> candidates = [];
  List<Corporate> console = [];
  Candidate? candidate;
  static final AppSession _instance = AppSession._internal();
  factory AppSession() {
    return _instance;
  }
  AppSession._internal() {
    firbaseAuth.authStateChanges().listen((event) async {
      if (event != null) {
        FirebaseFirestore.instance
            .collection('greycollaruser')
            .snapshots()
            .listen((value) {
          candidates =
              value.docs.map((e) => Candidate.fromSnapshot(e)).toList();
        });
        FirebaseFirestore.instance
            .collection('corporateuser')
            .snapshots()
            .listen((value) {
          console = value.docs.map((e) => Corporate.fromSnapshot(e)).toList();
        });
      }
      notifyListeners();
    });

    pageController.addListener(() {
      notifyListeners();
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<Candidate> _items;

  Future<void> loadItems(String category) async {
    QuerySnapshot snapshot = await _firestore
        .collection('your_collection')
        .where('category', isEqualTo: category)
        .get();

    _items = snapshot.docs
        .map((doc) => Candidate(
              name: doc['name'].toString(),
              selectedSkills: List<String>.from(doc["selectedSkills"] ?? []),
              selectedWorkins: List<String>.from(doc["selectedWorkins"] ?? []),
            ))
        .toList();
  }

  List<Candidate> get items => _items;

  Future<Result> signIn({required String email, required String password}) {
    return firbaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return Result(tilte: Result.success, message: "Logged in sucessfully");
    }).onError((error, stackTrace) =>
            Result(tilte: Result.failure, message: error.toString()));
  }

  final PageController pageController = PageController(initialPage: 1);

  final firbaseAuth = FirebaseAuth.instance;
  User? get currentUser => firbaseAuth.currentUser;
}
