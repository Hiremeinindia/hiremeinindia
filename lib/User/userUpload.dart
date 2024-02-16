import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/User/userRegistration.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/User/userPayment.dart';
import '../widgets/customtextfield.dart';
import '../widgets/hiremeinindia.dart';
import 'userFormState.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../Widgets/customtextstyle.dart';
import '../main.dart';
import '../widgets/custombutton.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';

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
  final String? workexpcount;
  final String? qualification;
  final String? address;
  final String? course;
  final String? qualiDescription;
  final String? age;
  final String? aboutYou;
  final String? project;
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
    this.course,
    this.project,
    this.worktitle,
    this.aboutYou,
    this.age,
    this.qualiDescription,
    this.mobile,
    this.qualification,
    this.skills,
    this.workexpcount,
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
  CandidateFormController controller = CandidateFormController();

  UploadTask? uploadTasks;
  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    controller.bluecoller.dispose();
    controller.state.dispose();
    super.dispose();
  }

  Future<void> selectFile(
      CandidateFormController controller, String identifier) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      if (identifier == 'imgpic') {
        controller.imagePic = result;
      } else if (identifier == 'imgaadhar') {
        controller.imageAadhar = result;
      } else if (identifier == 'imgcv') {
        controller.imageCv = result;
      } else if (identifier == 'imgvoter') {
        controller.imageVoter = result;
      } else if (identifier == 'imgexp') {
        controller.imageExp = result;
      }
    });
  }

  Future<String?> uploadFile(
      CandidateFormController controller, String identifier) async {
    FilePickerResult? selectedFile;
    if (identifier == 'imgpic') {
      selectedFile = controller.imagePic;
    } else if (identifier == 'imgaadhar') {
      selectedFile = controller.imageAadhar;
    } else if (identifier == 'imgcv') {
      selectedFile = controller.imageCv;
    } else if (identifier == 'imgexp') {
      selectedFile = controller.imageExp;
    } else if (identifier == 'imgvoter') {
      selectedFile = controller.imageVoter;
    }

    if (selectedFile == null) return null; // Check if a file is picked

    final fileName = selectedFile.files.first.name;
    final path = 'files/$fileName';
    final Uint8List? fileBytes = selectedFile.files.first.bytes;

    if (fileBytes == null) {
      // Handle the case where bytes are null
      return null;
    }

    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putData(fileBytes);

    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload; // Return download URL
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 150.0, right: 150, top: 50, bottom: 50),
                child: Column(
                  children: [
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
                                translation(context).blueColler,
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
                                  translation(context).greyColler,
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
                                  translation(context).blueColler,
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
                                translation(context).greyColler,
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                      ],
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
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              if (controller.imagePic != null)
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius:
                                            2, // changes position of shadow
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 180, 197, 226),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(controller
                                        .imagePic!
                                        .files
                                        .first
                                        .bytes!), // Accessing bytes property
                                  ),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: translation(context).picture,
                                onPressed: () =>
                                    selectFile(controller, 'imgpic'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: [
                              if (controller.imageAadhar != null)
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius:
                                            2, // changes position of shadow
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 180, 197, 226),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(controller
                                        .imageAadhar!
                                        .files
                                        .first
                                        .bytes!), // Accessing bytes property
                                  ),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: translation(context).aadhar,
                                onPressed: () =>
                                    selectFile(controller, 'imgaadhar'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: [
                              if (controller.imageVoter != null)
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius:
                                            2, // changes position of shadow
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 180, 197, 226),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(controller
                                        .imageVoter!
                                        .files
                                        .first
                                        .bytes!), // Accessing bytes property
                                  ),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: translation(context).voterId,
                                onPressed: () =>
                                    selectFile(controller, 'imgvoter'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: [
                              if (controller.imageCv != null)
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius:
                                            2, // changes position of shadow
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 180, 197, 226),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(controller
                                        .imageCv!
                                        .files
                                        .first
                                        .bytes!), // Accessing bytes property
                                  ),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: translation(context).cv,
                                onPressed: () =>
                                    selectFile(controller, 'imgcv'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            children: [
                              if (controller.imageExp != null)
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1,
                                        blurRadius:
                                            2, // changes position of shadow
                                      ),
                                    ],
                                    color: Color.fromARGB(255, 180, 197, 226),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.memory(
                                    Uint8List.fromList(controller
                                        .imageExp!
                                        .files
                                        .first
                                        .bytes!), // Accessing bytes property
                                  ),
                                ),
                              SizedBox(
                                height: 25,
                              ),
                              CustomButton(
                                text: translation(context).experienceProof,
                                onPressed: () =>
                                    selectFile(controller, 'imgexp'),
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
                            SizedBox(
                              width: 200,
                              child: Text(
                                translation(context).currentCountry,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              child: Text(
                                translation(context).currentState,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                translation(context).currentCity,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
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
                          width: 70,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                translation(context).expectedWage,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              child: Text(
                                translation(context).currentWage,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 60),
                            SizedBox(
                              width: 200,
                              child: Text(
                                'CTC',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              CustomTextfield(
                                controller:
                                    controller.expectedwage, // Set controller
                              ),
                              SizedBox(height: 40),
                              CustomTextfield(
                                controller: controller.currentwage,
                                // Set controller
                              ),
                              SizedBox(height: 40),
                              CustomTextfield(
                                controller: controller.ctc,
                                // Set controller
                              ),
                            ],
                          ),
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
                              String ctc = controller.ctc.text;
                              String expectedwage =
                                  controller.expectedwage.text;
                              String? imgpic =
                                  await uploadFile(controller, 'imgpic');
                              String? imgaadhar =
                                  await uploadFile(controller, 'imgaadhar');
                              String? imgcv =
                                  await uploadFile(controller, 'imgcv');
                              String? imgexp =
                                  await uploadFile(controller, 'imgexp');
                              String? imgvoter =
                                  await uploadFile(controller, 'imgvoter');
                              String currentwage = controller.currentwage.text;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewUserPayment(
                                    name: widget.name,
                                    email: widget.email,
                                    password: widget.password,
                                    mobile: widget.mobile,
                                    workexp: widget.workexp,
                                    workexpcount: widget.workexpcount,
                                    workins: widget.workins,
                                    worktitle: widget.worktitle,
                                    skills: widget.skills,
                                    address: widget.address,
                                    age: widget.age,
                                    aboutYou: widget.aboutYou,
                                    qualiDescription: widget.qualiDescription,
                                    course: widget.course,
                                    project: widget.project,
                                    aadharno: widget.aadharno,
                                    qualification: widget.qualification,
                                    selectedOption: widget.selectedOption,
                                    imgpic: imgpic,
                                    imgaadhar: imgaadhar,
                                    imgcv: imgcv,
                                    imgexp: imgexp,
                                    imgvoter: imgvoter,
                                    gender: widget.gender,
                                    state: state,
                                    city: city,
                                    ctc: ctc,
                                    country: country,
                                    currentwage: currentwage,
                                    expectedwage: expectedwage,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
