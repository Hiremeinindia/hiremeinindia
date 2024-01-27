import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hiremeinindiaapp/Models/candidated.dart';
import 'package:hiremeinindiaapp/User/GreyUser/greyRegistration.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/userpayment.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../candidate_form_state.dart';
import '../../classes/language.dart';
import '../../classes/language_constants.dart';
import '../../Widgets/customtextstyle.dart';
import '../../main.dart';
import '../../widgets/custombutton.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart' show rootBundle;

class GreyUserUpload extends StatefulWidget {
  const GreyUserUpload();
  @override
  State<GreyUserUpload> createState() => _GreyUserUpload();
}

class _GreyUserUpload extends State<GreyUserUpload> {
  bool isChecked = false;
  String? uploadedMessage;
  String? uploadedImageUrlAadhar;
  String? uploadedImageUrlForPicture;
  String? uploadedImageUrlForCV;
  String? uploadedImageUrlForVoterId;
  String? uploadedImageUrlForExperienceProof;
  String? downloadURL1;
  String? downloadURL2;
  String? downloadURL3;
  String? downloadURL4;
  String? downloadURL5;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final _formKey = GlobalKey<FormState>();
  final List<String> items = ['Tamil', 'English', 'French', 'Malayalam'];
  String? selectedValue;
  String email = '';
  String password = '';
  bool login = false;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _title = '';
  CandidateFormController controller = CandidateFormController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    controller.bluecoller.dispose();
    controller.state.dispose();
    super.dispose();
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
        'selectedWorkins': controller.selectedWorkins ?? [],
        "city": controller.city.text,
        "country": controller.country.text,
        'selectedSkills': controller.selectedSkills ?? [],
        'label': controller.selectedOption.text,
        // Add additional user-related fields as needed
      });
    } catch (e) {
      print('Error assigning user role: $e');
    }
  }

  Future<void> uploadFileToFirestore(String filePath) async {
    try {
      final file = File(filePath);
      final fileName = _extractFileName(filePath);

      // Reference to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Upload file to Firebase Storage
      await ref.putFile(file);

      // Get download URL
      final urlDownload = await ref.getDownloadURL();

      // Store file URL in Firestore
      await FirebaseFirestore.instance
          .collection('greycollaruser')
          .doc(fileName)
          .set({
        'fileName': fileName,
        'downloadURL': urlDownload,
        // Add additional fields as needed
      });

      print('File uploaded successfully to Firebase Storage and Firestore');
    } catch (e) {
      print('Error uploading file to Firebase Storage and Firestore: $e');
      // Handle the error, e.g., show a message to the user
    }
  }

  String _extractFileName(String filePath) {
    // Split the file path by the platform-specific separator
    List<String> parts = filePath.split(Platform.pathSeparator);
    // Get the last part, which represents the file name
    String fileName = parts.last;
    return fileName;
  }

// Function to upload file from bytes (for web platform)
  Future<void> uploadFileFromBytes({
    required Uint8List fileBytes,
    required String originalFileName,
  }) async {
    print("file3");

    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$originalFileName');
      UploadTask uploadTask = storageReference.putData(fileBytes);

      // Wait for the upload to complete
      await uploadTask;

      print('File uploaded successfully');

      // Get the download URL after a successful upload
      String downloadURL = await storageReference.getDownloadURL();

      // Call the function to display the uploaded file
      if (originalFileName.contains('picture')) {
        displayUploadedFilePicture(downloadURL, originalFileName);
      } else if (originalFileName.contains('aadhar')) {
        displayUploadedFileAadhar(downloadURL, originalFileName);
      } else if (originalFileName.contains('voterId')) {
        displayUploadedFileVoterId(downloadURL, originalFileName);
      } else if (originalFileName.contains('expProof')) {
        displayUploadedFileExpProof(downloadURL, originalFileName);
      } else if (originalFileName.contains('cv')) {
        displayUploadedFileCv(downloadURL, originalFileName);
      }
    } catch (e) {
      print('Error uploading file: $e');
      // Handle the error, e.g., show a message to the user
    }
  }

// Then, you can use the downloadURL to display the image:

// Assuming this is within a StatelessWidget or StatefulWidget
// and downloadURL is a property of that class.

// Use Image.network to display the image from the URL

// Function to display the uploaded file
  void displayUploadedFilePicture(
      String downloadURL1, String originalFileName1) {
    setState(() {
      uploadedImageUrlForPicture = downloadURL1;
      uploadedMessage = 'File uploaded successfully: $originalFileName1';
    });
  }

  void displayUploadedFileAadhar(
      String downloadURL2, String originalFileName2) {
    setState(() {
      uploadedImageUrlAadhar = downloadURL2;
      uploadedMessage = 'File uploaded successfully: $originalFileName2';
    });
  }

  void displayUploadedFileVoterId(
      String downloadURL3, String originalFileName3) {
    setState(() {
      uploadedImageUrlForVoterId = downloadURL3;
      uploadedMessage = 'File uploaded successfully: $originalFileName3';
    });
  }

  void displayUploadedFileExpProof(
      String downloadURL4, String originalFileName4) {
    setState(() {
      uploadedImageUrlForExperienceProof = downloadURL4;
      uploadedMessage = 'File uploaded successfully: $originalFileName4';
    });
  }

  void displayUploadedFileCv(String downloadURL5, String originalFileName5) {
    setState(() {
      uploadedImageUrlForCV = downloadURL5;
      uploadedMessage = 'File uploaded successfully: $originalFileName5';
    });
  }

  Widget build(BuildContext context) {
    final Object? keys = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
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
                      child: DropdownButton<String>(
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
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        underline: Container(),
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
        padding: EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
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
                Text(translation(context).blueColler),
                Checkbox(
                  value: false,
                  onChanged: null,
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
                Text(translation(context).greyColler),
              ],
            ),
            SizedBox(
              height: 40,
            ),
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
                      if (uploadedImageUrlForPicture != null)
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: uploadedImageUrlForPicture!,
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
                            // Process the selected picture files
                            for (PlatformFile file in result.files) {
                              if (kIsWeb) {
                                await uploadFileFromBytes(
                                  fileBytes: file.bytes!,
                                  originalFileName: file.name,
                                );
                              } else {
                                await uploadFileToFirestore(file.path!);
                              }

                              // Retrieve the download URL and display the file
                              final urlDownload = await FirebaseStorage.instance
                                  .ref()
                                  .child('uploads/${file.name}')
                                  .getDownloadURL();
                              displayUploadedFilePicture(
                                  urlDownload, file.name);
                            }
                          } else {
                            // User canceled the file picker
                          }
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(width: 40),
                Expanded(
                  child: Column(
                    children: [
                      if (uploadedImageUrlAadhar != null)
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: uploadedImageUrlAadhar!,
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
                          await DefaultCacheManager().emptyCache();
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
                            for (PlatformFile file in result.files) {
                              if (kIsWeb) {
                                await uploadFileFromBytes(
                                    fileBytes: file.bytes!,
                                    originalFileName: file.name);
                              } else {
                                await uploadFileToFirestore(file.path!);
                              }

                              // Retrieve the download URL and display the file
                              final urlDownload = await FirebaseStorage.instance
                                  .ref()
                                  .child('uploads/${file.name}')
                                  .getDownloadURL();
                              displayUploadedFileAadhar(urlDownload, file.name);
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
                      if (uploadedImageUrlForVoterId != null)
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: uploadedImageUrlForVoterId!,
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
                          await DefaultCacheManager().emptyCache();
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
                            for (PlatformFile file in result.files) {
                              if (kIsWeb) {
                                await uploadFileFromBytes(
                                    fileBytes: file.bytes!,
                                    originalFileName: file.name);
                              } else {
                                await uploadFileToFirestore(file.path!);
                              }

                              // Retrieve the download URL and display the file
                              final urlDownload = await FirebaseStorage.instance
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
                      if (uploadedImageUrlForExperienceProof != null)
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: uploadedImageUrlForExperienceProof!,
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
                          await DefaultCacheManager().emptyCache();
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
                            for (PlatformFile file in result.files) {
                              if (kIsWeb) {
                                await uploadFileFromBytes(
                                    fileBytes: file.bytes!,
                                    originalFileName: file.name);
                              } else {
                                await uploadFileToFirestore(file.path!);
                              }

                              // Retrieve the download URL and display the file
                              final urlDownload = await FirebaseStorage.instance
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
                      if (uploadedImageUrlForCV != null)
                        Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: uploadedImageUrlForCV!,
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
                          await DefaultCacheManager().emptyCache();
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
                            for (PlatformFile file in result.files) {
                              if (kIsWeb) {
                                await uploadFileFromBytes(
                                    fileBytes: file.bytes!,
                                    originalFileName: file.name);
                              } else {
                                await uploadFileToFirestore(file.path!);
                              }

                              // Retrieve the download URL and display the file
                              final urlDownload = await FirebaseStorage.instance
                                  .ref()
                                  .child('uploads/${file.name}')
                                  .getDownloadURL();
                              displayUploadedFileCv(urlDownload, file.name);
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
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 60),
                    Text(
                      translation(context).currentState,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      translation(context).currentCity,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
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
                              borderSide: BorderSide(color: Colors.black)))),
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
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 60),
                    Text(
                      translation(context).currentWage,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.bold),
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
                        controller: controller.expectedwage, // Set controller
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
                        controller: controller.currentwage, // Set controller
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
                    try {
                      // Upload images
                      List<String> imageUrls = await uploadImages(controller);

                      // Prepare data to store in Firestore
                      Map<String, dynamic> userData = {
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
                        'selectedWorkins': controller.selectedWorkins,
                        "city": controller.city.text,
                        "country": controller.country.text,
                        'selectedSkills': controller.selectedSkills,
                        "label": controller.selectedOption.text,
                        "expectedwage": controller.expectedwage.text,
                        "currentwage": controller.currentwage.text,
                        "imageUrls": imageUrls,
                        // Add other fields as needed
                      };

                      // Store data in Firestore
                      await FirebaseFirestore.instance
                          .collection('greyusercollar')
                          .add(userData);

                      // Navigate to the payment page or any other destination
                      Navigator.pushNamed(
                        context,
                        '/payment',
                        arguments: userData,
                      );
                    } catch (e) {
                      print('Error uploading user data: $e');
                      // Handle error
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

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
        'selectedWorkins': controller.selectedWorkins,
        "city": controller.city.text,
        "country": controller.country.text,
        'selectedSkills': controller.selectedSkills,
        "label": controller.selectedOption.text,
        "expectedwage": controller.expectedwage.text,
        "currentwage": controller.currentwage.text,
        "imageUrls": imageUrls,
      }, SetOptions(merge: true));

      print('Candidate added successfully');
    } catch (error) {
      print('Error adding candidate: $error');
      throw error;
    }
  }
}
