import 'dart:convert';
import 'dart:io';
import 'dart:ui_web';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/User/userRegistration.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/User/userPayment.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/hiremeinindia.dart';
import 'userFormState.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../Widgets/customtextstyle.dart';
import '../main.dart';
import '../widgets/custombutton.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class NewUserUpload extends StatefulWidget {
  final Function(String)? handleForm;
  final Candidate? candidate;
  final String? selectedOption;
  final String? name;
  final String? email;
  final String? password;
  final String? mobile;
  final String? worktitle;
  final String? aadharno;
  final String? gender;
  final String? workexp;
  final String? qualification;
  final String? address;
  final List<String>? skills;
  final List<String>? workins;
  const NewUserUpload({
    this.handleForm,
    this.candidate,
    this.selectedOption,
    this.password,
    this.name,
    this.email,
    this.address,
    this.aadharno,
    this.gender,
    this.worktitle,
    this.mobile,
    this.qualification,
    this.skills,
    this.workexp,
    this.workins,
  }) : assert(name != null && email != null && password != null);

  @override
  State<NewUserUpload> createState() => _NewUserUpload();
}

class _NewUserUpload extends State<NewUserUpload> {
  bool isChecked = false;
  String? uploadedMessage;

  UploadTask? uploadTask;
  final _formKey = GlobalKey<FormState>();
  List<File> images = [];
  List<String> cvImageUrls = [];
  List<String> expImageUrls = [];
  List<String> voteImageUrls = [];
  List<String> pictureImageUrls = [];
  List<String> aadharImageUrls = [];
  CandidateFormController controller = CandidateFormController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    controller.bluecoller.dispose();
    controller.state.dispose();
    super.dispose();
  }

// Function to upload file from bytes (for web platform)
  Future<String> uploadFileFromBytes(
      {required Uint8List fileBytes, required String originalFileName}) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('uploads/$originalFileName');
    final UploadTask uploadTask = storageReference.putData(fileBytes);
    await uploadTask;
    return await storageReference.getDownloadURL();
  }

  Future<String> uploadFileToStorage(String filePath) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('uploads/${path.basename(filePath)}');
    final UploadTask uploadTask = storageReference.putFile(File(filePath));
    await uploadTask;
    return await storageReference.getDownloadURL();
  }

  // Future<void> uploadImageUrl1ToFirestore(String imgpic) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('greyusercollar').doc();
  //     await documentReference.set({
  //       'imageUrl': imgpic,
  //       // Add additional fields if needed
  //     });
  //     print('Image URL uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading image URL to Firestore: $error');
  //     throw error;
  //   }
  // }

  // Future<void> uploadImageUrl2ToFirestore(String imgaadhar) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('greyusercollar').doc();
  //     await documentReference.set({
  //       'imageUrl': imgaadhar,
  //       // Add additional fields if needed
  //     });
  //     print('Image URL uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading image URL to Firestore: $error');
  //     throw error;
  //   }
  // }

  // Future<void> uploadImageUrl3ToFirestore(String imgvoter) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('greyusercollar').doc();
  //     await documentReference.set({
  //       'imageUrl': imgvoter,
  //       // Add additional fields if needed
  //     });
  //     print('Image URL uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading image URL to Firestore: $error');
  //     throw error;
  //   }
  // }

  // Future<void> uploadImageUrl4ToFirestore(String imgexp) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('greyusercollar').doc();
  //     await documentReference.set({
  //       'imageUrl': imgexp,
  //       // Add additional fields if needed
  //     });
  //     print('Image URL uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading image URL to Firestore: $error');
  //     throw error;
  //   }
  // }

  // Future<void> uploadImageUrl5ToFirestore(String imgcv) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('greyusercollar').doc();
  //     await documentReference.set({
  //       'imageUrl': imgcv,
  //       // Add additional fields if needed
  //     });
  //     print('Image URL uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading image URL to Firestore: $error');
  //     throw error;
  //   }
  // }

  void displayUploadedFilePicture(
      String downloadURL1, String originalFileName1) {
    setState(() {
      controller.imgpic.text = downloadURL1;
      uploadedMessage = 'File uploaded successfully: $originalFileName1';
    });
  }

  void displayUploadedFileAadhar(
      String downloadURL2, String originalFileName2) {
    setState(() {
      controller.imgaadhar.text = downloadURL2;
      uploadedMessage = 'File uploaded successfully: $originalFileName2';
    });
  }

  void displayUploadedFileVoterId(
      String downloadURL3, String originalFileName3) {
    setState(() {
      controller.imgvoter.text = downloadURL3;
      uploadedMessage = 'File uploaded successfully: $originalFileName3';
    });
  }

  void displayUploadedFileExpProof(
      String downloadURL4, String originalFileName4) {
    setState(() {
      controller.imgexp.text = downloadURL4;
      uploadedMessage = 'File uploaded successfully: $originalFileName4';
    });
  }

  void displayUploadedFileCv(String downloadURL5, String originalFileName5) {
    setState(() {
      controller.imgcv.text = downloadURL5;
      uploadedMessage = 'File uploaded successfully: $originalFileName5';
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: HireMeInIndia(),
          automaticallyImplyLeading: false,
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
                  SizedBox(width: 40),
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person_outline_outlined,
                            size: 35,
                            color: Colors.indigo.shade900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'New',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'User',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo.shade900,
                              height: 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Row(
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
                ),
                SizedBox(height: 37),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    translation(context).uploadEssentialDocument,
                    style: TextStyle(
                        color: Colors.indigo.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          if (controller.imgpic != null)
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.imgpic.text,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  print('Error loading image: $error');
                                  return Placeholder(); // You can replace this with any placeholder widget
                                },
                              ),
                            ),
                          CustomButton(
                            text: translation(context).picture,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf',
                                  'doc',
                                  'docx'
                                ],
                              );

                              if (result != null) {
                                try {
                                  for (PlatformFile file in result.files) {
                                    String imageUrl;
                                    if (kIsWeb) {
                                      // For web, use the bytes property instead of path
                                      final String fileName = file.name;
                                      final Uint8List fileBytes = file.bytes!;

                                      // Upload file to Firebase Storage
                                      imageUrl = await uploadFileFromBytes(
                                        fileBytes: fileBytes,
                                        originalFileName: fileName,
                                      );
                                    } else {
                                      // For other platforms, handle file uploads using path
                                      final String filePath = file.path!;

                                      // Upload file to Firebase Storage
                                      imageUrl =
                                          await uploadFileToStorage(filePath);
                                    }

                                    // // Store the image URL in Firestore
                                    // await uploadImageUrl1ToFirestore(imageUrl);
                                    pictureImageUrls.add(imageUrl);

                                    // Display the uploaded file (Aadhar) with its URL
                                    final urlDownload = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child('uploads/${file.name}')
                                        .getDownloadURL();
                                    displayUploadedFilePicture(
                                        urlDownload, file.name);
                                  }
                                } catch (e) {
                                  print('Error uploading CV: $e');
                                  // Handle error
                                }
                                // Process the selected files
                              } else {
                                // User canceled the file picker
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: [
                          if (controller.imgaadhar != null)
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.imgaadhar.text!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  print('Error loading image: $error');
                                  return Placeholder(); // You can replace this with any placeholder widget
                                },
                              ),
                            ),
                          CustomButton(
                            text: translation(context).aadhar,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf',
                                  'doc',
                                  'docx'
                                ],
                              );

                              if (result != null) {
                                try {
                                  for (PlatformFile file in result.files) {
                                    String imgaadhar;
                                    if (kIsWeb) {
                                      // For web, use the bytes property instead of path
                                      final String fileName = file.name;
                                      final Uint8List fileBytes = file.bytes!;

                                      // Upload file to Firebase Storage
                                      imgaadhar = await uploadFileFromBytes(
                                        fileBytes: fileBytes,
                                        originalFileName: fileName,
                                      );
                                    } else {
                                      // For other platforms, handle file uploads using path
                                      final String filePath = file.path!;

                                      // Upload file to Firebase Storage
                                      imgaadhar =
                                          await uploadFileToStorage(filePath);
                                    }

                                    // // Store the image URL in Firestore
                                    // await uploadImageUrl2ToFirestore(imgaadhar);
                                    aadharImageUrls.add(imgaadhar);

                                    // Display the uploaded file (Aadhar) with its URL
                                    final urlDownload = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child('uploads/${file.name}')
                                        .getDownloadURL();
                                    displayUploadedFileAadhar(
                                        urlDownload, file.name);
                                  }
                                } catch (e) {
                                  print('Error uploading CV: $e');
                                  // Handle error
                                }
                                // Process the selected files
                              } else {
                                // User canceled the file picker
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: [
                          if (controller.imgvoter != null)
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.imgvoter.text!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  print('Error loading image: $error');
                                  return Placeholder(); // You can replace this with any placeholder widget
                                },
                              ),
                            ),
                          CustomButton(
                            text: translation(context).voterId,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf',
                                  'doc',
                                  'docx'
                                ],
                              );

                              if (result != null) {
                                // Process the selected files
                                List<String> imageUrls = [];
                                for (PlatformFile file in result.files) {
                                  String imageUrl;
                                  if (kIsWeb) {
                                    // For web, use the bytes property instead of path
                                    final String fileName = file.name;
                                    final Uint8List fileBytes = file.bytes!;

                                    // Upload file to Firebase Storage
                                    imageUrl = await uploadFileFromBytes(
                                      fileBytes: fileBytes,
                                      originalFileName: fileName,
                                    );
                                  } else {
                                    // For other platforms, handle file uploads using path
                                    final String filePath = file.path!;

                                    // Upload file to Firebase Storage
                                    imageUrl =
                                        await uploadFileToStorage(filePath);
                                  }

                                  // // Store the image URL in Firestore
                                  // await uploadImageUrl3ToFirestore(imageUrl);
                                  voteImageUrls.add(imageUrl);

                                  // Display the uploaded file (Voter ID) with its URL
                                  final urlDownload = await FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('uploads/${file.name}')
                                      .getDownloadURL();
                                  displayUploadedFileVoterId(
                                      urlDownload, file.name);
                                }
                              } else {
                                // User canceled the file picker
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: [
                          if (controller.imgexp != null)
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.imgexp.text!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  print('Error loading image: $error');
                                  return Placeholder(); // You can replace this with any placeholder widget
                                },
                              ),
                            ),
                          CustomButton(
                            text: translation(context).experienceProof,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf',
                                  'doc',
                                  'docx'
                                ],
                              );

                              if (result != null) {
                                // Process the selected files
                                for (PlatformFile file in result.files) {
                                  String imageUrl;
                                  if (kIsWeb) {
                                    // For web, use the bytes property instead of path
                                    final String fileName = file.name;
                                    final Uint8List fileBytes = file.bytes!;

                                    // Upload file to Firebase Storage
                                    imageUrl = await uploadFileFromBytes(
                                      fileBytes: fileBytes,
                                      originalFileName: fileName,
                                    );
                                  } else {
                                    // For other platforms, handle file uploads using path
                                    final String filePath = file.path!;

                                    // Upload file to Firebase Storage
                                    imageUrl =
                                        await uploadFileToStorage(filePath);
                                  }

                                  // // Store the image URL in Firestore
                                  // await uploadImageUrl4ToFirestore(imageUrl);
                                  expImageUrls.add(imageUrl);

                                  // Display the uploaded file (Experience Proof) with its URL
                                  final urlDownload = await FirebaseStorage
                                      .instance
                                      .ref()
                                      .child('uploads/${file.name}')
                                      .getDownloadURL();
                                  displayUploadedFileExpProof(
                                      urlDownload, file.name);
                                }
                              } else {
                                // User canceled the file picker
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 40),
                    Expanded(
                      child: Column(
                        children: [
                          if (controller.imgcv != null)
                            Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: controller.imgcv.text!,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  print('Error loading image: $error');
                                  return Placeholder(); // You can replace this with any placeholder widget
                                },
                              ),
                            ),
                          CustomButton(
                            text: translation(context).cv,
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'jpeg',
                                  'png',
                                  'pdf',
                                  'doc',
                                  'docx'
                                ],
                              );

                              if (result != null) {
                                try {
                                  // Process the selected files
                                  for (PlatformFile file in result.files) {
                                    String imageUrl;
                                    if (kIsWeb) {
                                      // For web, use the bytes property instead of path
                                      final String fileName = file.name;
                                      final Uint8List fileBytes = file.bytes!;

                                      // Upload file to Firebase Storage
                                      imageUrl = await uploadFileFromBytes(
                                        fileBytes: fileBytes,
                                        originalFileName: fileName,
                                      );
                                    } else {
                                      // For other platforms, handle file uploads using path
                                      final String filePath = file.path!;

                                      // Upload file to Firebase Storage
                                      imageUrl =
                                          await uploadFileToStorage(filePath);
                                    }

                                    // // Store the image URL in Firestore
                                    // await uploadImageUrl5ToFirestore(imageUrl);
                                    cvImageUrls.add(
                                        imageUrl); // Add the image URL to cvImageUrls

                                    // Display the uploaded file (CV) with its URL
                                    final urlDownload = await FirebaseStorage
                                        .instance
                                        .ref()
                                        .child('uploads/${file.name}')
                                        .getDownloadURL();
                                    displayUploadedFileCv(
                                        urlDownload, file.name);
                                  }
                                } catch (e) {
                                  print('Error uploading CV: $e');
                                  // Handle error
                                }
                              } else {
                                // User canceled the file picker
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).currentCountry,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 60),
                        Text(
                          translation(context).currentState,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          translation(context).currentCity,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 200,
                      child: CountryStateCityPicker(
                          country: controller.country,
                          state: controller.state,
                          city: controller.city,
                          textFieldDecoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: const Icon(
                                Icons.arrow_downward_rounded,
                                size: 20,
                              ),
                              border: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black)))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).expectedWage,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 60),
                        Text(
                          translation(context).currentWage,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextField(
                            controller:
                                controller.expectedwage, // Set controller
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: TextField(
                            controller: controller.currentwage,
                            // Set controller
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 250,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: translation(context).back,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registration()),
                        );
                      },
                    ),
                    SizedBox(width: 50),
                    CustomButton(
                      text: translation(context).next,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String state = controller.state.text;
                          String city = controller.city.text;
                          String country = controller.country.text;
                          String expectedwage = controller.expectedwage.text;

                          String currentwage = controller.currentwage.text;
                          String imgaadhar = controller.imgaadhar.text;
                          String imgpic = controller.imgpic.text;
                          String imgcv = controller.imgcv.text;
                          String imgvoter = controller.imgvoter.text;
                          String imgexp = controller.imgexp.text;
                          List<String> imageUrls = [
                            imgpic,
                            imgaadhar,
                            imgcv,
                            imgexp,
                            imgvoter
                          ];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewUserPayment(
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                mobile: widget.mobile,
                                workexp: widget.workexp,
                                workins: widget.workins,
                                worktitle: widget.worktitle,
                                skills: widget.skills,
                                address: widget.address,
                                aadharno: widget.aadharno,
                                qualification: widget.qualification,
                                selectedOption: widget.selectedOption,
                                gender: widget.gender,
                                state: state,
                                city: city,
                                country: country,
                                currentwage: currentwage,
                                expectedwage: expectedwage,
                                imageUrls: imageUrls,
                              ),
                            ),
                          );
                          print(
                              '.....................................................           ${widget.selectedOption}              ...................................................');
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  // Future<void> uploadImageUrlsToFirestore(List<String> imageUrls, String imgpic,
  //     String impaadhar, String imgexp, String imgcv, String imgvoter) async {
  //   try {
  //     final DocumentReference documentReference =
  //         FirebaseFirestore.instance.collection('registeruser').doc();

  //     await documentReference.set({
  //       'imgVoter': imgvoter,
  //       'imgAadhar': impaadhar,
  //       'imageCV': imgcv,
  //       'imagePicture': imgpic,
  //       'imgExperience': imgexp,
  //       'imageUrls': imageUrls,
  //       // Add additional fields if needed
  //     });

  //     print('Data including image URLs uploaded to Firestore successfully.');
  //   } catch (error) {
  //     print('Error uploading data to Firestore: $error');
  //     throw error;
  //   }
  // }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream:
          uploadTask?.snapshotEvents, // Use uploadTask instead of UploadTask
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(
            height: 50,
          );
        }
      });
}
