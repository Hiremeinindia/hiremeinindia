import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporateDashboard.dart';
import 'package:hiremeinindiaapp/authservice.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'package:hiremeinindiaapp/User/userDashboard.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:sizer/sizer.dart';
import 'User/userFormState.dart';
import 'Widgets/customtextstyle.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CandidateFormController controller = CandidateFormController();
  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedValue;
  String email = '';
  String password = '';
  String name = '';
  bool login = false;
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

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(75),
              child: Material(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
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
                                              style:
                                                  CustomTextStyle.dropdowntext,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              e.langname,
                                              style:
                                                  CustomTextStyle.dropdowntext,
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
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
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
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
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
                          SizedBox(
                            width: 0.5.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation(context).guest,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
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
                    ],
                  ),
                ),
              ),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                height: 400,
                width: 500,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          translation(context).login,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Text(
                        translation(context).email,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 750,
                        child: CustomTextfield(
                          text: translation(context).email,
                          controller: controller.email,
                          onsaved: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        translation(context).password,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 750,
                        child: CustomTextfield(
                          text: translation(context).password,
                          validator: validatePassword,
                          controller: controller.password,
                          onsaved: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        text: translation(context).login,
                        onPressed: () async {
                          try {
                            // Sign in with email and password
                            UserCredential userCredential =
                                await _auth.signInWithEmailAndPassword(
                              email: controller.email.text,
                              password: controller.password.text,
                            );

                            // Check the user's role after successful sign-in
                            String userRole =
                                await getUserRole(userCredential.user!.uid);

                            // Navigate to the appropriate dashboard based on the user's role
                            if (userRole == 'Admin') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CorporateDashboard(
                                      user: userCredential.user!),
                                ),
                              );
                            } else if (userRole == 'Blue' ||
                                userRole == 'Grey') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDashboard(
                                        user: userCredential.user!),
                                  ));
                            } else {
                              print('Unknown user role');
                            }
                          } on FirebaseAuthException catch (e) {
                            // Handle authentication exceptions
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided.');
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            )),
          );
        } else {
          return Scaffold(
            endDrawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.only(
                    top: 3.h,
                  ),
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 41,
                      minRadius: 41,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        maxRadius: 40,
                        minRadius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 60,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text(
                        translation(context).guest,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        translation(context).user,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo.shade900,
                            height: 0),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.indigo.shade900,
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      title: Text(
                        AppLocalizations.of(context)!.english,
                      ),
                      children: Language.languageList().map((language) {
                        return ListTile(
                          hoverColor: Colors.indigo.shade100,
                          title: Text(
                            language.langname,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () async {
                            // Handle language selection
                            Locale _locale =
                                await setLocale(language.languageCode);
                            HireApp.setLocale(context, _locale);
                          },
                        );
                      }).toList(),
                    ),
                    ExpansionTile(
                        collapsedBackgroundColor: Colors.indigo.shade900,
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        title: Text(
                          AppLocalizations.of(context)!.findaJob,
                        ),
                        children: [
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option1',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option2',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          )
                        ]),
                  ]),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                height: 80,
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HireMeInIndia(),
                        Builder(
                            builder: (context) => IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color: Colors.indigo.shade900,
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 55.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            translation(context).login,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          translation(context).email,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 750,
                          child: CustomTextfield(
                            text: translation(context).email,
                            controller: controller.email,
                            onsaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          translation(context).password,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 750,
                          child: CustomTextfield(
                            text: translation(context).password,
                            validator: validatePassword,
                            controller: controller.password,
                            onsaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomButton(
                            text: translation(context).login,
                            onPressed: () async {
                              try {
                                // Sign in with email and password
                                UserCredential userCredential =
                                    await _auth.signInWithEmailAndPassword(
                                  email: controller.email.text,
                                  password: controller.password.text,
                                );

                                // Check the user's role after successful sign-in
                                String userRole =
                                    await getUserRole(userCredential.user!.uid);

                                // Navigate to the appropriate dashboard based on the user's role
                                if (userRole == 'Admin') {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CorporateDashboard(
                                          user: userCredential.user!),
                                    ),
                                  );
                                } else if (userRole == 'Blue' ||
                                    userRole == 'Grey') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDashboard(
                                            user: userCredential.user!),
                                      ));
                                } else {
                                  print('Unknown user role');
                                }
                              } on FirebaseAuthException catch (e) {
                                // Handle authentication exceptions
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided.');
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }

  Future<String> getUserRole(String uid) async {
    try {
      String adminCollection = 'corporateuser';
      String userCollection = 'greycollaruser';

      // Check if the user is an admin
      DocumentSnapshot<Map<String, dynamic>> adminSnapshot =
          await FirebaseFirestore.instance
              .collection(adminCollection)
              .doc(uid)
              .get();

      if (adminSnapshot.exists) {
        print('Login as admin');
        return 'Admin';
      } else {
        // Check if the user is a regular user
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection(userCollection)
                .doc(uid)
                .get();

        if (userSnapshot.exists) {
          print('Login as user');
          return 'Blue';
        }
      }
    } catch (e) {
      print('Error determining user role: $e');
    }

    return 'Unknown';
  }
}
