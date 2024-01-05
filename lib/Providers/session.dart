import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/Models/candidated.dart';
import '../Models/results.dart';

class AppSession extends ChangeNotifier {
  static final AppSession _instance = AppSession._internal();

  List<Candidate> candidates = [];

  Candidate? candidate;

  AppSession._internal() {
    firbaseAuth.authStateChanges().listen((event) async {
      if (event != null) {
        FirebaseFirestore.instance
            .collection('users')
            .snapshots()
            .listen((value) {
          candidates =
              value.docs.map((e) => Candidate.fromSnapshot(e)).toList();
        });
        candidate = candidates
            .firstWhereOrNull((element) => element.reference.id == event.uid);
      }
      notifyListeners();
    });

    pageController.addListener(() {
      notifyListeners();
    });
  }

  factory AppSession() {
    return _instance;
  }

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
