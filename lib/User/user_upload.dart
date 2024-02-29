import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/User/user_payment.dart';
import 'package:sizer/sizer.dart';
import '../loginpage.dart';
import '../widgets/customtextfield.dart';
import '../widgets/hiremeinindia.dart';
import 'user_form_state.dart';
import '../classes/language_constants.dart';
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
  final int? index;
  final PageController? pageController;
  const NewUserUpload(
      {this.handleForm,
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
      this.index,
      this.pageController})
      : assert(name != null && email != null && password != null);

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
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
        child: Dialog(
          child: Material(
            elevation: 4,
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              if (constraints.maxWidth >= 633) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: 91.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding:
                            EdgeInsets.fromLTRB(2.5.w, 2.5.h, 2.5.w, 2.5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).popUntil(
                                            ModalRoute.withName('/hired'));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ImageIcon(
                                          NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/cancel.png?alt=media&token=951094e2-a6f9-46a3-96bc-ddbb3362f08c',
                                          ),
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 15),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.indigo.shade900,
                                            fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.8.h,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(3.w, 0, 3.w, 0.5.h),
                                  child: Row(
                                    children: [
                                      if (widget.selectedOption == 'Blue')
                                        Row(
                                          children: [
                                            Radio(
                                              value: widget.selectedOption,
                                              groupValue: widget.selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  controller.selectedOption
                                                      .text = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              translation(context).blueColler,
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            IgnorePointer(
                                              child: Radio(
                                                  value: widget.selectedOption,
                                                  groupValue: controller
                                                      .selectedOption.text,
                                                  onChanged: null),
                                            ),
                                            IgnorePointer(
                                              child: Text(
                                                translation(context).greyColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                  groupValue: controller
                                                      .selectedOption.text,
                                                  onChanged: null),
                                            ),
                                            IgnorePointer(
                                              child: Text(
                                                translation(context).blueColler,
                                                style: TextStyle(
                                                    color: Colors.grey.shade500,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Radio(
                                              value: widget.selectedOption,
                                              groupValue: widget.selectedOption,
                                              onChanged: (value) {
                                                // Handle radio button state change if needed
                                                setState(() {
                                                  controller.selectedOption
                                                      .text = value.toString();
                                                });
                                              },
                                            ),
                                            Text(
                                              translation(context).greyColler,
                                              style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      3.w, 0.6.h, 3.w, 0.5.h),
                                  child: Column(
                                    children: [
                                      Divider(color: Colors.black),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            translation(context)
                                                .uploadEssentialDocument,
                                            textScaleFactor:
                                                ScaleSize.textScaleFactor(
                                                    context),
                                            style: TextStyle(
                                                fontFamily: 'Colfax',
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 3.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                      color: Color.fromARGB(
                                                          255, 180, 197, 226),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: translation(context)
                                                        .picture,
                                                    onPressed: () => selectFile(
                                                        controller, 'imgpic'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                if (controller.imageAadhar !=
                                                    null)
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
                                                      color: Color.fromARGB(
                                                          255, 180, 197, 226),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: translation(context)
                                                        .aadhar,
                                                    onPressed: () => selectFile(
                                                        controller,
                                                        'imgaadhar'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                if (controller.imageVoter !=
                                                    null)
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
                                                      color: Color.fromARGB(
                                                          255, 180, 197, 226),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: translation(context)
                                                        .voterId,
                                                    onPressed: () => selectFile(
                                                        controller, 'imgvoter'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
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
                                                      color: Color.fromARGB(
                                                          255, 180, 197, 226),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text:
                                                        translation(context).cv,
                                                    onPressed: () => selectFile(
                                                        controller, 'imgcv'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
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
                                                      color: Color.fromARGB(
                                                          255, 180, 197, 226),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
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
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: CustomButton(
                                                    text: translation(context)
                                                        .experienceProof,
                                                    onPressed: () => selectFile(
                                                        controller, 'imgexp'),
                                                  ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                translation(context)
                                                    .currentCountry,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context)
                                                    .currentState,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context)
                                                    .currentCity,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 2.5.w,
                                          ),
                                          Expanded(
                                            child: CountryStateCityPicker(
                                                country: controller.country,
                                                state: controller.state,
                                                city: controller.city,
                                                textFieldDecoration:
                                                    InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        suffixIcon: const Icon(
                                                          Icons
                                                              .arrow_downward_rounded,
                                                          size: 20,
                                                        ),
                                                        border: const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black)))),
                                          ),
                                          SizedBox(
                                            width: 2.5.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                translation(context)
                                                    .expectedWage,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context)
                                                    .currentWage,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                'CTC',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 2.5.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                CustomTextfield(
                                                  controller: controller
                                                      .expectedwage, // Set controller
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                CustomTextfield(
                                                  controller:
                                                      controller.currentwage,
                                                  // Set controller
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
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
                                        height: 3.5.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  text: translation(context).back,
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                                      String? imgpic = await uploadFile(
                                          controller, 'imgpic');
                                      String? imgaadhar = await uploadFile(
                                          controller, 'imgaadhar');
                                      String? imgcv =
                                          await uploadFile(controller, 'imgcv');
                                      String? imgexp = await uploadFile(
                                          controller, 'imgexp');
                                      String? imgvoter = await uploadFile(
                                          controller, 'imgvoter');
                                      String currentwage =
                                          controller.currentwage.text;
                                      showDialog(
                                        barrierColor: Color(0x00ffffff),
                                        context: context,
                                        builder: (context) {
                                          return NewUserPayment(
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
                                            qualiDescription:
                                                widget.qualiDescription,
                                            course: widget.course,
                                            project: widget.project,
                                            aadharno: widget.aadharno,
                                            qualification: widget.qualification,
                                            selectedOption:
                                                widget.selectedOption,
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
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: 91.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.fromLTRB(2.5.w, 2.5.h, 2.5.w, 2.5.h),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: Navigator.of(context).pop,
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: ImageIcon(
                                        NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/cancel.png?alt=media&token=951094e2-a6f9-46a3-96bc-ddbb3362f08c',
                                        ),
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 15),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.indigo.shade900,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.8.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(3.w, 0, 3.w, 0.5.h),
                                child: Row(
                                  children: [
                                    if (widget.selectedOption == 'Blue')
                                      Row(
                                        children: [
                                          Radio(
                                            value: widget.selectedOption,
                                            groupValue: widget.selectedOption,
                                            onChanged: (value) {
                                              setState(() {
                                                controller.selectedOption.text =
                                                    value.toString();
                                              });
                                            },
                                          ),
                                          Text(
                                            translation(context).blueColler,
                                            style: TextStyle(
                                                color: Colors.grey.shade800,
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IgnorePointer(
                                            child: Radio(
                                                value: widget.selectedOption,
                                                groupValue: controller
                                                    .selectedOption.text,
                                                onChanged: null),
                                          ),
                                          IgnorePointer(
                                            child: Text(
                                              translation(context).greyColler,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
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
                                                groupValue: controller
                                                    .selectedOption.text,
                                                onChanged: null),
                                          ),
                                          IgnorePointer(
                                            child: Text(
                                              translation(context).blueColler,
                                              style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
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
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(3.w, 0.6.h, 3.w, 0.5.h),
                                child: Column(
                                  children: [
                                    Divider(color: Colors.black),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          translation(context)
                                              .uploadEssentialDocument,
                                          textScaleFactor:
                                              ScaleSize.textScaleFactor(
                                                  context),
                                          style: TextStyle(
                                              fontFamily: 'Colfax',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
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
                                          color: Color.fromARGB(
                                              255, 180, 197, 226),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: translation(context).picture,
                                        onPressed: () =>
                                            selectFile(controller, 'imgpic'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
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
                                          color: Color.fromARGB(
                                              255, 180, 197, 226),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: translation(context).aadhar,
                                        onPressed: () =>
                                            selectFile(controller, 'imgaadhar'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
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
                                          color: Color.fromARGB(
                                              255, 180, 197, 226),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: translation(context).voterId,
                                        onPressed: () =>
                                            selectFile(controller, 'imgvoter'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
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
                                          color: Color.fromARGB(
                                              255, 180, 197, 226),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: translation(context).cv,
                                        onPressed: () =>
                                            selectFile(controller, 'imgcv'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
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
                                          color: Color.fromARGB(
                                              255, 180, 197, 226),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        text: translation(context)
                                            .experienceProof,
                                        onPressed: () =>
                                            selectFile(controller, 'imgexp'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context)
                                                    .currentCountry,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 44,
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context)
                                                    .currentState,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                            ),
                                            SizedBox(
                                              width: 20.w,
                                              child: Text(
                                                translation(context)
                                                    .currentCity,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        CountryStateCityPicker(
                                            country: controller.country,
                                            state: controller.state,
                                            city: controller.city,
                                            textFieldDecoration:
                                                InputDecoration(
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    suffixIcon: const Icon(
                                                      Icons
                                                          .arrow_downward_rounded,
                                                      size: 20,
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .black)))),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            translation(context).expectedWage,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTextfield(
                                            controller: controller
                                                .expectedwage, // Set controller
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            translation(context).currentWage,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTextfield(
                                            controller: controller.currentwage,
                                            // Set controller
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20.w,
                                          child: Text(
                                            'CTC',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12),
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTextfield(
                                            controller: controller.ctc,
                                            // Set controller
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    5), // Adjust border radius as needed
                                              ),
                                            ),
                                            child: Text(
                                              'Back',
                                              style: TextStyle(
                                                fontFamily: 'Colfax',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        SizedBox(
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                String state =
                                                    controller.state.text;
                                                String city =
                                                    controller.city.text;
                                                String country =
                                                    controller.country.text;
                                                String ctc =
                                                    controller.ctc.text;
                                                String expectedwage = controller
                                                    .expectedwage.text;
                                                String? imgpic =
                                                    await uploadFile(
                                                        controller, 'imgpic');
                                                String? imgaadhar =
                                                    await uploadFile(controller,
                                                        'imgaadhar');
                                                String? imgcv =
                                                    await uploadFile(
                                                        controller, 'imgcv');
                                                String? imgexp =
                                                    await uploadFile(
                                                        controller, 'imgexp');
                                                String? imgvoter =
                                                    await uploadFile(
                                                        controller, 'imgvoter');
                                                String currentwage =
                                                    controller.currentwage.text;
                                                showDialog(
                                                  barrierColor:
                                                      Color(0x00ffffff),
                                                  context: context,
                                                  builder: (context) {
                                                    return NewUserPayment(
                                                      name: widget.name,
                                                      email: widget.email,
                                                      password: widget.password,
                                                      mobile: widget.mobile,
                                                      workexp: widget.workexp,
                                                      workexpcount:
                                                          widget.workexpcount,
                                                      workins: widget.workins,
                                                      worktitle:
                                                          widget.worktitle,
                                                      skills: widget.skills,
                                                      address: widget.address,
                                                      age: widget.age,
                                                      aboutYou: widget.aboutYou,
                                                      qualiDescription: widget
                                                          .qualiDescription,
                                                      course: widget.course,
                                                      project: widget.project,
                                                      aadharno: widget.aadharno,
                                                      qualification:
                                                          widget.qualification,
                                                      selectedOption:
                                                          widget.selectedOption,
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
                                                      expectedwage:
                                                          expectedwage,
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor:
                                                  Colors.indigo.shade900,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    5), // Adjust border radius as needed
                                              ),
                                            ),
                                            child: Text(
                                              'Next',
                                              style: TextStyle(
                                                fontFamily: 'Colfax',
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ),
      );
    });
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

 
