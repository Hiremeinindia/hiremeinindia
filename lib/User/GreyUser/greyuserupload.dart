import 'dart:convert';
import 'dart:io';

import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/userpayment.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../candidate_form_state.dart';
import '../../classes/language.dart';
import '../../classes/language_constants.dart';
import '../../Widgets/customtextstyle.dart';
import '../../main.dart';
import '../../widgets/custombutton.dart';
import '../../widgets/hiremeinindia.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/services.dart' show rootBundle;

class GreyUserUpload extends StatefulWidget {
  const GreyUserUpload();
  @override
  State<GreyUserUpload> createState() => _GreyUserUpload();
}

class _GreyUserUpload extends State<GreyUserUpload> {
  @override
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
  final List<String> items = ['Tamil', 'English', 'French', 'Malayalam'];
  String? selectedValue;
  String email = '';
  String password = '';
  bool login = false;
  String? countryValue;
  String? stateValue;
  String? cityValue;
  List<CountryModel> _countryList = [];
  final List<StateModel> _stateList = [];
  final List<CityModel> _cityList = [];

  List<CountryModel> _countrySubList = [];
  List<StateModel> _stateSubList = [];
  List<CityModel> _citySubList = [];
  String _title = '';
  CandidateFormController controller = CandidateFormController();
  void initState() {
    _getCountry();
    super.initState();
  }

  Future<void> _getCountry() async {
    _countryList.clear();
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/country.json');
    List<dynamic> body = json.decode(jsonString);
    setState(() {
      _countryList =
          body.map((dynamic item) => CountryModel.fromJson(item)).toList();
      _countrySubList = _countryList;
    });
  }

  Future<void> _getState(String countryId) async {
    _stateList.clear();
    _cityList.clear();
    List<StateModel> subStateList = [];
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/state.json');
    List<dynamic> body = json.decode(jsonString);

    subStateList =
        body.map((dynamic item) => StateModel.fromJson(item)).toList();
    for (var element in subStateList) {
      if (element.countryId == countryId) {
        setState(() {
          _stateList.add(element);
        });
      }
    }
    _stateSubList = _stateList;
  }

  Future<void> _getCity(String stateId) async {
    _cityList.clear();
    List<CityModel> subCityList = [];
    var jsonString = await rootBundle
        .loadString('packages/country_state_city_pro/assets/city.json');
    List<dynamic> body = json.decode(jsonString);

    subCityList = body.map((dynamic item) => CityModel.fromJson(item)).toList();
    for (var element in subCityList) {
      if (element.stateId == stateId) {
        setState(() {
          _cityList.add(element);
        });
      }
    }
    _citySubList = _cityList;
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    controller.bluecoller.dispose();
    controller.state.dispose();
    super.dispose();
  }

  Future<void> uploadFile(String filePath) async {
    print("file4");
    final path = 'uploads/${pickedFile!.name}';
    final file = File(filePath);
    final ref = FirebaseStorage.instance.ref().child(path);

    // Use putFile to upload the file and get the UploadTask
    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await ref.getDownloadURL();
    print('Download Link: $urlDownload');
    setState(() {
      uploadTask = null;
    });

    // Wait for the upload to complete
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
                                await uploadFile(file.path!);
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
                                await uploadFile(file.path!);
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
                                await uploadFile(file.path!);
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
                                await uploadFile(file.path!);
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
                                await uploadFile(file.path!);
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
                Column(
                  children: [
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: TextField(
                        controller: controller.country,
                        onTap: () {
                          setState(() => _title = 'Country');
                          _showDialog(context);
                        }, // Set controller
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
                        controller: controller.state,
                        onTap: () {
                          setState(() => _title = 'State');
                          if (controller.country.text.isNotEmpty) {
                            _showDialog(context);
                          } else {
                            _showSnackBar('Select Country');
                          }
                        }, // Set controller
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
                        controller: controller.city,
                        onTap: () {
                          setState(() => _title = 'City');
                          if (controller.state.text.isNotEmpty) {
                            _showDialog(context);
                          } else {
                            _showSnackBar('Select State');
                          }
                        }, // Set controller
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
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
                        controller: controller.expectedWage, // Set controller
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
                        controller: controller.currentWage, // Set controller
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
                  onPressed: () {},
                ),
                SizedBox(width: 50),
                CustomButton(
                  text: translation(context).next,
                  onPressed: () {
                    final Set<String> data = {
                      'name',
                      'email',
                      'mobile',
                      'worktitle',
                      "aadharno",
                      "gender",
                      "workexp",
                      "qualification",
                      "state",
                      "address",
                      'selectedWorkins',
                      "city",
                      "country",
                      'selectedSkills',
                      'label'
                    };
                    Navigator.pushNamed(
                      context,
                      '/payment',
                      arguments: data, // Pass data to the payment page
                    );
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

  void _showDialog(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();

    CandidateFormController controller = CandidateFormController();

    showGeneralDialog(
      barrierLabel: _title,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 350),
      context: context,
      pageBuilder: (context, __, ___) {
        return Material(
          color: Colors.transparent,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  margin: const EdgeInsets.only(top: 60, left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(_title,
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),

                      ///Text Field
                      TextField(
                        controller: _title == 'Country'
                            ? controller1
                            : _title == 'State'
                                ? controller2
                                : controller3,
                        onChanged: (val) {
                          setState(() {
                            if (_title == 'Country') {
                              _countrySubList = _countryList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller1.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'State') {
                              _stateSubList = _stateList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller2.text.toLowerCase()))
                                  .toList();
                            } else if (_title == 'City') {
                              _citySubList = _cityList
                                  .where((element) => element.name
                                      .toLowerCase()
                                      .contains(controller3.text.toLowerCase()))
                                  .toList();
                            }
                          });
                        },
                        style: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16.0),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: "Search here...",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            isDense: true,
                            prefixIcon: Icon(Icons.search)),
                      ),

                      ///Dropdown Items
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          itemCount: _title == 'Country'
                              ? _countrySubList.length
                              : _title == 'State'
                                  ? _stateSubList.length
                                  : _citySubList.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                setState(() {
                                  if (_title == "Country") {
                                    controller.country.text =
                                        _countrySubList[index].name;
                                    _getState(_countrySubList[index].id);
                                    _countrySubList = _countryList;
                                    controller.state.clear();
                                    controller.city.clear();
                                  } else if (_title == 'State') {
                                    controller.state.text =
                                        _stateSubList[index].name;
                                    _getCity(_stateSubList[index].id);
                                    _stateSubList = _stateList;
                                    controller.city.clear();
                                  } else if (_title == 'City') {
                                    controller.city.text =
                                        _citySubList[index].name;
                                    _citySubList = _cityList;
                                  }
                                });
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20.0, left: 10.0, right: 10.0),
                                child: Text(
                                    _title == 'Country'
                                        ? _countrySubList[index].name
                                        : _title == 'State'
                                            ? _stateSubList[index].name
                                            : _citySubList[index].name,
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 16.0)),
                              ),
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        onPressed: () {
                          if (_title == 'City' && _citySubList.isEmpty) {
                            controller.city.text = controller3.text;
                          }
                          _countrySubList = _countryList;
                          _stateSubList = _stateList;
                          _citySubList = _cityList;

                          controller1.clear();
                          controller2.clear();
                          controller3.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Close'),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16.0))));
  }

  InputDecoration defaultDecoration = const InputDecoration(
      isDense: true,
      hintText: 'Select',
      suffixIcon: Icon(Icons.arrow_drop_down),
      border: OutlineInputBorder());
}

class CountryModel {
  final String id;
  final String sortName;
  final String name;
  final String phoneCode;

  CountryModel(
      {required this.id,
      required this.sortName,
      required this.name,
      required this.phoneCode});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        id: json['id'] as String,
        sortName: json['sortname'] as String,
        name: json['name'] as String,
        phoneCode: json['phonecode'] as String);
  }
}

class StateModel {
  final String id;
  final String name;
  final String countryId;

  StateModel({required this.id, required this.name, required this.countryId});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
        id: json['id'] as String,
        name: json['name'] as String,
        countryId: json['country_id'] as String);
  }
}

class CityModel {
  final String id;
  final String name;
  final String stateId;

  CityModel({required this.id, required this.name, required this.stateId});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      stateId: json['state_id'] as String,
    );
  }
}
