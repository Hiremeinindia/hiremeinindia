import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporateFormState.dart';
import '../Models/results.dart';

class CorporateController {
  CorporateController({
    required this.formController,
  });
  final CorporateFormController formController;

  static final CorporateRef =
      FirebaseFirestore.instance.collection('greycollaruser');

  Corporate get corporate => formController.corporate;

  Future<void> addCorporate(CorporateFormController controller) async {
    try {
      await controller.reference.set({
        'name': controller.name.text,
        'email': controller.email.text,
        'designation': controller.designation.text,
        "label": controller.selectedOption.text,
      }, SetOptions(merge: true));

      print('Corporate added successfully');
    } catch (error) {
      print('Error adding Corporate: $error');
      throw error;
    }
  }

  static Future<List<Corporate>> loadStaffs(String search) {
    return CorporateRef.where('search', arrayContains: search)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((e) => Corporate.fromSnapshot(e)).toList();
    });
  }
}
