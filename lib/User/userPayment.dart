import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  const NewUserPayment({
    Key? key,
    this.selectedOption,
    this.name,
    this.email,
    this.mobile,
    this.worktitle,
    this.aadharno,
    this.gender,
    this.workexp,
    this.qualification,
    this.address,
    this.workins,
    this.skills,
    this.label,
    this.expectedwage,
    this.currentwage,
    this.imageUrl1,
    this.imageUrl2,
    this.imageUrl3,
    this.imageUrl4,
    this.imageUrl5,
    this.city,
    this.state,
    this.country,
  }) : super(key: key);
  final String? selectedOption;
  final String? email;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? workexp;
  final String? qualification;
  final String? address;
  final String? workins;
  final String? skills;
  final String? label;
  final String? name;
  final String? expectedwage;
  final String? currentwage;
  final String? city;
  final String? country;
  final String? state;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? imageUrl4;
  final String? imageUrl5;

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
  String? _uploadedImageURL; // New variable to store uploaded image URL
  Future<void> assignUserRole(String uid, String role) async {
    try {
      String userCollection = 'greycollaruser';

      // Assign the user role to the user
      await FirebaseFirestore.instance.collection(userCollection).doc(uid).set({
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
        'workins': controller.workins ?? [],
        "city": controller.city.text,
        "country": controller.country.text,
        'skills': controller.skills ?? [],
        'label': controller.selectedOption.text,
        // Add additional user-related fields as needed
      });
    } catch (e) {
      print('Error assigning user role: $e');
    }
  }

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

  Future<void> getCashReceipt() async {
    final String serverUrl = 'http://localhost:3014';
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

  Future<void> uploadCashReceipt() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _cashReceipt = result.files.first;
        });

        // For non-web platforms, use the path property
        // For web, use the bytes property
        List<int> fileBytes = kIsWeb
            ? _cashReceipt!.bytes!
            : await _readFileAsBytes(_cashReceipt!.path!);

        // Upload the cash receipt image to Firebase Storage
        await uploadImageToFirebase(fileBytes, 'cash_receipt.jpg');

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

  Future<void> uploadUserData() async {
    try {
      List<String> imageUrls = await uploadImages(controller);
      // Prepare user registration data
      Map<String, dynamic> registrationData = {
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
        // Add other registration data fields as needed
      };

      // Prepare documentation upload data
      // Example:
      Map<String, dynamic> documentationData = {
        'document1Url': 'url_to_document1.pdf',
        'document2Url': 'url_to_document2.pdf',
        // Add other documentation data fields as needed
      };

      // Prepare payment receipt data
      // Example:
      Map<String, dynamic> paymentReceiptData = {
        'receiptUrl': 'url_to_receipt.pdf',
        'amountPaid': 100,
        // Add other payment receipt data fields as needed
      };

      // Upload all data to Firestore
      await FirebaseFirestore.instance.collection('greyusercollar').add({
        'registrationData': registrationData,
        'documentationData': documentationData,
        'paymentReceiptData': paymentReceiptData,
      });

      print('User data uploaded successfully');
    } catch (e) {
      print('Error uploading user data: $e');
      // Handle error scenario
    }
  }

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

  Future<void> sendCashNotification() async {
    print("cash2");
    setState(() {
      isProcessing = true; // Set the flag to indicate processing
    });
    final String serverUrl = 'http://localhost:3014';
    final String endpoint = '/cashNotification';

    try {
      print('Sending cash notification...');
      final response = await http.post(
        Uri.parse('$serverUrl$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print("cash3");
        print('Waiting for 3 minutes before showing verification result...');
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
    final Object? data = ModalRoute.of(context)?.settings.arguments;
    final Map<String, dynamic> dataMap = {
      'data': data,
    };

// Now you can store this map in Firestore
    FirebaseFirestore.instance.collection('greyusercollar').add(dataMap);
    return Scaffold(
        appBar: AppBar(
          title: HireMeInIndia(),
          centerTitle: false,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 50.0, top: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
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
                              width: 200,
                              elevation: 1,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                              width: 156,
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
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    height: 30,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade900,
                        ),
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
                            width: 200,
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
                            width: 156,
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
                  ),
                  SizedBox(width: 40),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  SizedBox(
                    width: 50,
                    child: Text(
                      'Guest User',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.indigo.shade900;
                        }
                        return Colors.transparent;
                      },
                    ),
                    checkColor: Colors.black,
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  Text(translation(context).greyColler),
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.grey;
                        }
                        return Colors.transparent;
                      },
                    ),
                    checkColor: Colors.black,
                    side: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  Text(
                    translation(context).greyColler,
                  ),
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
                            // Call the method to send cash notification
                            await sendCashNotification();

                            // Call the method to retrieve cash receipt after the notification is sent
                            await getCashReceipt();

                            // The pop-up dialog will be dismissed automatically when the process is complete
                            // Instead of navigating back immediately, you can handle the response here
                            // For example, you can show a message or navigate to another page based on the response
                          } catch (error) {
                            print('Error handling cash notification: $error');
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
                    text: translation(context).next,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Sign up with email and password
                        List<String> imageUrls = await uploadImages(controller);
                        Navigator.pushNamed(
                          context,
                          '/document',
                          arguments: {
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
                          }, // Pass only keys to the next page
                        );
                        await uploadUserData();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Complete Payment',
                    onPressed: () async {
                      // Call the method to upload all user data to Firestore
                    },
                  ),
                ],
              )
            ])));
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