import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/User/userFormState.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import '../Widgets/customtextstyle.dart';
import '../classes/language_constants.dart';
import '../widgets/custombutton.dart';
import '../widgets/hiremeinindia.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../classes/language.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class NewUserPayment extends StatefulWidget {
  final Function(String)? handleForm;
  const NewUserPayment({
    this.selectedOption,
    this.name,
    this.email,
    this.mobile,
    this.worktitle,
    this.password,
    this.aadharno,
    this.gender,
    this.workexp,
    this.workexpcount,
    this.qualification,
    this.course,
    this.project,
    this.address,
    this.workins,
    this.imgpic,
    this.imgaadhar,
    this.imgcv,
    this.imgvoter,
    this.imgexp,
    this.skills,
    this.expectedwage,
    this.currentwage,
    this.city,
    this.aboutYou,
    this.age,
    this.qualiDescription,
    this.ctc,
    this.state,
    this.country,
    this.candidate,
    this.handleForm,
  });
  final String? selectedOption;
  final String? name;
  final String? email;
  final String? password;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? qualification;
  final String? state;
  final String? address;
  final String? city;
  final String? course;
  final String? project;
  final String? country;
  final String? workexp;
  final String? workexpcount;
  final String? expectedwage;
  final String? currentwage;
  final String? ctc;
  final String? qualiDescription;
  final String? age;
  final String? aboutYou;
  final String? imgpic;
  final String? imgaadhar;
  final String? imgexp;
  final String? imgvoter;
  final String? imgcv;
  final List<String>? skills;
  final List<String>? workins;

  final Candidate? candidate;

  @override
  State<NewUserPayment> createState() => _NewUserPayment();
}

class _NewUserPayment extends State<NewUserPayment> {
  Map<String, dynamic> dataMap = {};
  bool isChecked = false;
  bool isProcessing = false;
  PlatformFile? _cashReceipt;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  CandidateFormController controller = CandidateFormController();

  Future<void> showFileUploadSuccessDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Upload Successful'),
          content: Text('The cash receipt has been uploaded successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadImageToFirebase(
      List<int> fileBytes, String fileName) async {
    try {
      Reference reference = FirebaseStorage.instance.ref().child(fileName);
      await reference.putData(Uint8List.fromList(fileBytes));
      print('Image uploaded to Firebase Storage with filename: $fileName');
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> uploadImageUrlToFirestore(String imageUrl) async {
    try {
      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection('greyusercollar').doc();

      // Save only the imageUrl to Firestore
      await documentReference.set({
        'imageUrl': imageUrl,
        // You can add more fields if needed
      });
      controller.cashrecipt.text = imageUrl;
      print('Image URL uploaded to Firestore successfully.');
    } catch (error) {
      print('Error uploading image URL to Firestore: $error');
      throw error;
    }
  }

  Future<void> getCashReceipt() async {
    final String serverUrl = 'http://localhost:3019';
    final String endpoint = '/getCashReceipt';

    try {
      final response = await http.get(Uri.parse('$serverUrl$endpoint'));

      if (response.statusCode == 200) {
        String cashReceiptData = response.body;
        // Display or process the received cash receipt data as needed
        print('Received Cash Receipt: $cashReceiptData');
      } else {
        print(
          'Failed to retrieve cash receipt. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      print('Error retrieving cash receipt: $error');
    }
  }

  Future<String> uploadImageToFirestore(List<int> fileBytes) async {
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('cash_receipt.jpg');
      await reference.putData(Uint8List.fromList(fileBytes));
      String imageUrl = await reference.getDownloadURL();

      // Upload the image URL to Firestore
      // await uploadImageUrlToFirestore(
      //     imageUrl); // Pass the imageUrl to this method

      await imageUrl; // Pass the imageUrl to this method

      controller.cashrecipt.text = imageUrl;
      // Return the image URL
      return imageUrl;
    } catch (error) {
      print('Error uploading image: $error');
      throw error;
    }
  }

  Future<void> uploadCashReceipt() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _cashReceipt = result.files.first;
        });

        List<int> fileBytes = kIsWeb
            ? _cashReceipt!.bytes!
            : await _readFileAsBytes(_cashReceipt!.path!);

        // Upload the cash receipt image URL to Firestore
        String imageUrl = await uploadImageToFirestore(fileBytes);
        print('Image URL: $imageUrl');

        // Show success dialog or handle success scenario as needed
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
      // Handle error scenario
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

  // Future<void> addCandidate(CandidateFormController controller) async {
  //   try {
  //     List<String> imageUrls = await uploadImages(controller);
  //     await controller.reference.set({
  //       'name': controller.name.text,
  //       'email': controller.email.text,
  //       'mobile': controller.mobile.text,
  //       'worktitle': controller.worktitle.text,
  //       "aadharno": controller.aadharno.text,
  //       "gender": controller.gender.text,
  //       "workexp": controller.workexp.text,
  //       "qualification": controller.qualification.text,
  //       "state": controller.state.text,
  //       "address": controller.address.text,
  //       'workins': controller.workins,
  //       "city": controller.city.text,
  //       "country": controller.country.text,
  //       'skills': controller.skills,
  //       "label": controller.selectedOption.text,
  //       "expectedwage": controller.expectedwage,
  //       "currentwage": controller.currentwage,
  //     }, SetOptions(merge: true));

  //     print('Candidate added successfully');
  //   } catch (error) {
  //     print('Error adding candidate: $error');
  //     throw error;
  //   }
  // }

  // Future<void> uploadUserData() async {
  //   try {
  //     List<String> imageUrls = await uploadImages(controller);
  //     // Prepare user registration data
  //     Map<String, dynamic> registrationData = {
  //       'name': controller.name.text,
  //       'email': controller.email.text,
  //       'mobile': controller.mobile.text,
  //       'worktitle': controller.worktitle.text,
  //       "aadharno": controller.aadharno.text,
  //       "gender": controller.gender.text,
  //       "workexp": controller.workexp.text,
  //       "qualification": controller.qualification.text,
  //       "state": controller.state.text,
  //       "address": controller.address.text,
  //       'workins': controller.workins,
  //       "city": controller.city.text,
  //       "country": controller.country.text,
  //       'skills': controller.skills,
  //       "label": controller.selectedOption.text,
  //       "expectedwage": controller.expectedwage,
  //       "currentwage": controller.currentwage,
  //       "imageUrls": imageUrls,
  //       // Add other registration data fields as needed
  //     };

  //     // Prepare documentation upload data
  //     // Example:
  //     Map<String, dynamic> documentationData = {
  //       'document1Url': 'url_to_document1.pdf',
  //       'document2Url': 'url_to_document2.pdf',
  //       // Add other documentation data fields as needed
  //     };

  //     // Prepare payment receipt data
  //     // Example:
  //     Map<String, dynamic> paymentReceiptData = {
  //       'receiptUrl': 'url_to_receipt.pdf',
  //       'amountPaid': 100,
  //       // Add other payment receipt data fields as needed
  //     };

  //     // Upload all data to Firestore
  //     await FirebaseFirestore.instance.collection('greyusercollar').add({
  //       'registrationData': registrationData,
  //       'documentationData': documentationData,
  //       'paymentReceiptData': paymentReceiptData,
  //     });

  //     print('User data uploaded successfully');
  //   } catch (e) {
  //     print('Error uploading user data: $e');
  //     // Handle error scenario
  //   }
  // }

  Future<List<int>> _readFileAsBytes(String path) async {
    // Read the content of the file as bytes
    final file = File(path);
    List<int> fileBytes = await file.readAsBytes();
    return fileBytes;
  }

  Widget _buildSendingCashDialog(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: AlertDialog(
            title: Text('Sending Cash Notification'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Please wait...'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> sendCashNotification(String imageUrl) async {
    print("cash2");
    setState(() {
      isProcessing = true; // Set the flag to indicate processing
    });
    final String serverUrl = 'http://localhost:3019';
    final String endpoint = '/cashNotification';

    try {
      print('Sending cash notification...');
      final response = await http.post(
        Uri.parse('$serverUrl$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'imageUrl': imageUrl, // Pass imageUrl as a parameter
        }),
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print("cash3");
        print('Waiting for 1 minutes before showing verification result...');
        // Wait for 3 minutes before showing verification result
        await Future.delayed(Duration(minutes: 1));

        // Dismiss the "Sending Cash Notification" dialog
        Navigator.of(context).pop();

        setState(() {
          isProcessing = false;
        });

        // Display a popup message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Cash Received and Verified'),
              content: Text('The cash payment has been received and verified.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print(
          'Failed to send notification. Status code: ${response.statusCode}',
        );
        setState(() {
          isProcessing = false; // Set the flag to indicate processing is done
        });
      }
    } catch (error) {
      print('Error sending notification: $error');
      setState(() {
        isProcessing = false; // Set the flag to indicate processing is done
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          toolbarHeight: 80,
          surfaceTintColor: Colors.transparent,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(top: 40, left: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HireMeInIndia(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<Language>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  translation(context).english,
                                  style: CustomTextStyle.dropdowntext,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          onChanged: (Language? language) async {
                            if (language != null) {
                              Locale _locale =
                                  await setLocale(language.languageCode);
                              HireApp.setLocale(context, _locale);
                            } else {
                              language;
                            }
                          },
                          items: Language.languageList()
                              .map<DropdownMenuItem<Language>>(
                                (e) => DropdownMenuItem<Language>(
                                  value: e,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        e.flag,
                                        style: CustomTextStyle.dropdowntext,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        e.langname,
                                        style: CustomTextStyle.dropdowntext,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          buttonStyleData: ButtonStyleData(
                            height: 30,
                            width: 150,
                            elevation: 1,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                            ),
                            iconSize: 25,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: null,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 210,
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                              color: Colors.indigo.shade900,
                            ),
                            scrollPadding: EdgeInsets.all(5),
                            scrollbarTheme: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 25,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade900,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          items: [
                            DropdownMenuItem<String>(
                              value: 'Option 1',
                              child: Text('Option 1'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Option 2',
                              child: Text('Option 1'),
                            ),
                            // Add more options as needed
                          ],
                          onChanged: (value) {
                            // Handle option selection
                          },
                          hint: Text(
                            AppLocalizations.of(context)!.findaJob,
                            style: TextStyle(color: Colors.white),
                          ),
                          buttonStyleData: ButtonStyleData(
                            height: 30,
                            width: 150,
                            elevation: 1,
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.indigo.shade900,
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                            ),
                            iconSize: 25,
                            iconEnabledColor: Colors.white,
                            iconDisabledColor: null,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 210,
                            elevation: 0,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black),
                              color: Colors.indigo.shade900,
                            ),
                            scrollPadding: EdgeInsets.all(5),
                            scrollbarTheme: ScrollbarThemeData(
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility:
                                  MaterialStateProperty.all<bool>(true),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 25,
                            padding: EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40, top: 35),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: 35,
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translation(context).newuser,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        translation(context).user,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo.shade900,
                            height: 0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 150.0, right: 150, top: 50, bottom: 50),
                child: Column(children: [
                  Row(
                    children: [
                      if (widget.selectedOption == 'Blue')
                        Row(
                          children: [
                            Radio(
                              value: widget.selectedOption,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                // Handle radio button state change if needed
                                setState(() {
                                  controller.selectedOption.text =
                                      value.toString();
                                });
                              },
                            ),
                            Text(
                              'Blue Collar',
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                            IgnorePointer(
                              child: Radio(
                                  value: widget.selectedOption,
                                  groupValue: controller.selectedOption.text,
                                  onChanged: null),
                            ),
                            IgnorePointer(
                              child: Text(
                                'Grey Collar',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      else if (widget.selectedOption == 'Grey')
                        Row(
                          children: [
                            IgnorePointer(
                              child: Radio(
                                  value: widget.selectedOption,
                                  groupValue: controller.selectedOption.text,
                                  onChanged: null),
                            ),
                            IgnorePointer(
                              child: Text(
                                'Blue Collar',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Radio(
                              value: widget.selectedOption,
                              groupValue: widget.selectedOption,
                              onChanged: (value) {
                                // Handle radio button state change if needed
                                setState(() {
                                  controller.selectedOption.text =
                                      value.toString();
                                });
                              },
                            ),
                            Text(
                              'Grey Collar',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                          child: CustomButton(
                        text: translation(context).gpay,
                        onPressed: () {},
                      )),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                          child: CustomButton(
                        text: translation(context).neft,
                        onPressed: () {},
                      )),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: CustomButton(
                          text: translation(context).cash,
                          onPressed: () async {
                            print("cash1");

                            // Call the method to upload cash receipt
                            await uploadCashReceipt();

                            // Display the pop-up dialog only if the receipt is uploaded successfully
                            if (_cashReceipt != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return _buildSendingCashDialog(context);
                                },
                              );

                              try {
                                String? imageUrl = '';
                                // Call the method to send cash notification
                                await sendCashNotification(imageUrl);

                                // Call the method to retrieve cash receipt after the notification is sent
                                await getCashReceipt();

                                // The pop-up dialog will be dismissed automatically when the process is complete
                                // Instead of navigating back immediately, you can handle the response here
                                // For example, you can show a message or navigate to another page based on the response
                              } catch (error) {
                                print(
                                    'Error handling cash notification: $error');
                                // Handle the error scenario, e.g., show an error message to the user
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                          child: CustomButton(
                        text: translation(context).paymentGateway,
                        onPressed: () {},
                      )),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          text: translation(context).register,
                          onPressed: _register),
                      SizedBox(height: 20),
                    ],
                  )
                ])),
          ),
        ));
  }

  void _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: widget.email!,
        password: widget.password!,
      );
      // User creation successful
      print("User created: ${userCredential.user!.email}");
      print(
          'ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss          ${widget.imgpic}               sssssssssssssssssssssssssssssssssssssssssss');
      await assignUserRole(userCredential.user!.uid, 'Blue');
    } catch (e) {
      print("Error creating user: $e");
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future<void> assignUserRole(String uid, String role) async {
    try {
      String userCollection = 'greycollaruser';
      await FirebaseFirestore.instance.collection(userCollection).doc(uid).set({
        'name': widget.name,
        'email': widget.email,
        'mobile': widget.mobile,
        'worktitle': widget.worktitle,
        "aadharno": widget.aadharno,
        "gender": widget.gender,
        "workexp": widget.workexp,
        "workexpcount": widget.workexpcount,
        "qualification": widget.qualification,
        "state": widget.state,
        "address": widget.address,
        'workins': widget.workins ?? [],
        "city": widget.city,
        "project": widget.project,
        "course": widget.course,
        "imgpic": widget.imgpic,
        "imgaadhar": widget.imgaadhar,
        "imgcv": widget.imgcv,
        "imgvoter": widget.imgvoter,
        "imgexp": widget.imgexp,
        "country": widget.country,
        'skills': widget.skills ?? [],
        "ctc": widget.ctc,
        "aboutYou": widget.aboutYou,
        "age": widget.age,
        "qualiDescription": widget.qualiDescription,
        "expectedwage": widget.expectedwage,
        "currentwage": widget.currentwage,
        'label': widget.selectedOption,
        "cashrecipt": controller.cashrecipt.text
        // Add additional user-related fields as needed
      });
    } catch (e) {
      print('Error assigning user role: $e');
    }
  }
}

Widget _buildSendingCashDialog() {
  return Stack(
    children: [
      Positioned.fill(
        child: Container(
          color: Colors.transparent,
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: AlertDialog(
          title: Text('Sending Cash Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text('Please wait...'),
            ],
          ),
        ),
      ),
    ],
  );
}
