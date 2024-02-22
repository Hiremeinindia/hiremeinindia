import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporateFormState.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:sizer/sizer.dart';

import '../classes/language_constants.dart';
import '../widgets/custombutton.dart';
import '../widgets/customtextfield.dart';
import '../widgets/hiremeinindia.dart';

class CorporateRegistration extends StatefulWidget {
  const CorporateRegistration({Key? key, this.corporate}) : super(key: key);

  final Corporate? corporate;

  @override
  State<CorporateRegistration> createState() => _CorporateRegistrationState();
}

class _CorporateRegistrationState extends State<CorporateRegistration> {
  var isLoading = false;

  CorporateFormController controller = CorporateFormController();
  var label = 'Admin';
  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  dispose() {
    controller.name.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validatePassword(String? value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidName(value)) {
      return 'Invalid format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
        child: Dialog(
          // The Dialog widget provides a full-page overlay
          child: Material(
            elevation: 4,
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              if (constraints.maxWidth >= 633) {
                return SingleChildScrollView(
                  child: Container(
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
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            translation(context)
                                                .registerAsANewUser,
                                            textScaleFactor:
                                                ScaleSize.textScaleFactor(
                                                    context),
                                            style: TextStyle(
                                                fontFamily: 'Colfax',
                                                fontWeight: FontWeight.bold,
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
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                translation(context).name,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context)
                                                    .companyName,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context).email,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomTextfield(
                                                  text: 'First Name',
                                                  validator: nameValidator,
                                                  controller: controller.name,
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                CustomTextfield(
                                                  validator: nameValidator,
                                                  text: 'Company Name',
                                                  controller:
                                                      controller.companyName,
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                CustomTextfield(
                                                  text: 'Email ID',
                                                  validator: MultiValidator([
                                                    RequiredValidator(
                                                        errorText:
                                                            "* Required"),
                                                    EmailValidator(
                                                        errorText:
                                                            "Enter valid email id"),
                                                  ]),
                                                  controller: controller.email,
                                                ),
                                              ],
                                            ),
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
                                                    .designation,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context).password,
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 44.8,
                                              ),
                                              Text(
                                                translation(context)
                                                    .confirmPassword,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                CustomTextfield(
                                                  text: 'Designation',
                                                  validator: nameValidator,
                                                  controller:
                                                      controller.designation,
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                CustomTextfield(
                                                  text: 'Password',
                                                  validator: validatePassword,
                                                  controller:
                                                      controller.password,
                                                ),
                                                SizedBox(
                                                  height: 17,
                                                ),
                                                CustomTextfield(
                                                  text: 'Re-enter Password',
                                                  validator: (value) {
                                                    if (controller
                                                            .password.text !=
                                                        controller
                                                            .confirmPassword
                                                            .text) {
                                                      return "Password did not match";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  controller: controller
                                                      .confirmPassword,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.8.h,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 50),
                                CustomButton(
                                  text: translation(context).next,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Sign up with email and password
                                      UserCredential userCredential =
                                          await _auth
                                              .createUserWithEmailAndPassword(
                                        email: controller.email.text,
                                        password: controller.password.text,
                                      );

                                      // Assign the admin role to the user
                                      await assignUserRole(
                                          userCredential.user!.uid, 'Admin');

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
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
                );
              } else {
                return Container(
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
                                  EdgeInsets.fromLTRB(3.w, 0.6.h, 3.w, 0.5.h),
                              child: Column(
                                children: [
                                  Divider(color: Colors.black),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        translation(context).registerAsANewUser,
                                        textScaleFactor:
                                            ScaleSize.textScaleFactor(context),
                                        style: TextStyle(
                                            fontFamily: 'Colfax',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                        child: Text(
                                          translation(context).name,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'First Name',
                                          validator: nameValidator,
                                          controller: controller.name,
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
                                          translation(context).companyName,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'Company Name',
                                          validator: nameValidator,
                                          controller: controller.companyName,
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
                                          translation(context).email,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'Email ID',
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                            EmailValidator(
                                                errorText:
                                                    "Enter valid email id"),
                                          ]),
                                          controller: controller.email,
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
                                          translation(context).designation,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'Designation',
                                          validator: nameValidator,
                                          controller: controller.designation,
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
                                          translation(context).password,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'Password',
                                          validator: validatePassword,
                                          controller: controller.password,
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
                                            translation(context)
                                                .confirmPassword,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12),
                                          )),
                                      Expanded(
                                        child: CustomTextfield(
                                          text: 'Re-enter Password',
                                          validator: (value) {
                                            if (controller.password.text !=
                                                controller
                                                    .confirmPassword.text) {
                                              return "Password did not match";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller:
                                              controller.confirmPassword,
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
                                      SizedBox(width: 50),
                                      CustomButton(
                                        text: translation(context).next,
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            // Sign up with email and password
                                            UserCredential userCredential =
                                                await _auth
                                                    .createUserWithEmailAndPassword(
                                              email: controller.email.text,
                                              password:
                                                  controller.password.text,
                                            );

                                            // Assign the admin role to the user
                                            await assignUserRole(
                                                userCredential.user!.uid,
                                                'Admin');

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
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

  Future<void> assignUserRole(String uid, String role) async {
    try {
      String adminCollection = 'corporateuser';

      // Assign the admin role to the user
      await FirebaseFirestore.instance
          .collection(adminCollection)
          .doc(uid)
          .set({
        'label': 'Admin',
        'name': controller.name.text,
        'email': controller.email.text,
        'designation': controller.designation.text,
        'companyname': controller.companyName.text
        // Add additional admin-related fields as needed
      });
    } catch (e) {
      print('Error assigning admin role: $e');
    }
  }
}
