import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hiremeinindiaapp/widgets/customcard.dart';

import '../Widgets/customtextstyle.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';
import '../widgets/custombutton.dart';
import '../widgets/hiremeinindia.dart';

class UserDashboard extends StatefulWidget {
  final User user;

  UserDashboard({Key? key, required this.user});

  @override
  State<UserDashboard> createState() => _UserDashboard();
}

class _UserDashboard extends State<UserDashboard> {
  bool isChecked = false;
  bool dropdownValue = false;
  bool isArrowClick = false;
  late Stream<Map<String, dynamic>?> userStream;
  List<String> _image = [];
  String _userName = '';
  List<String> _skills = [];

  @override
  void initState() {
    super.initState();
    userStream = fetchData().map((data) => data);
  }

  Stream<Map<String, dynamic>?> fetchData() {
    try {
      return FirebaseFirestore.instance
          .collection('greycollaruser')
          .doc(widget.user!.uid)
          .snapshots()
          .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()!;
          String name = data['name'];
          List<String> skills = List<String>.from(data['skills']);
          List<String> imageUrls = List<String>.from(data['imageUrl']);
          _userName = name;
          _skills = skills;
          _image = imageUrls;
          return data;
        } else {
          print('Document does not exist');
          return null;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
      return Stream.value(null);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: HireMeInIndia(),
          centerTitle: false,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
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
                  StreamBuilder<Map<String, dynamic>?>(
                    stream: userStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        // Display the user's name
                        return Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_userName',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${_skills[0]}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.indigo.shade900,
                                    height: 0),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Loading or error state
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
            padding:
                EdgeInsets.only(left: 125, right: 125, top: 20, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                backgroundColor: Colors.indigo.shade900,
                maxRadius: 68,
                minRadius: 67.5,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 66,
                  minRadius: 60,
                  child: StreamBuilder<Map<String, dynamic>?>(
                      stream: userStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage('${_image[0]}'),
                                maxRadius: 59,
                                minRadius: 56,
                              ),
                            ],
                          );
                        } else {
                          // Loading or error state
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: StreamBuilder<Map<String, dynamic>?>(
                            stream: userStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                // Display the user's name
                                return Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Hello $_userName',
                                        style: CustomTextStyle.nameOfUser,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      IconButton(
                                        hoverColor: Colors.transparent,
                                        icon: Icon(Icons.arrow_drop_down_sharp),
                                        iconSize: 30,
                                        color: Colors.indigo.shade900,
                                        onPressed: () {
                                          setState(() {
                                            isArrowClick = !isArrowClick;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Loading or error state
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                        StreamBuilder<Map<String, dynamic>?>(
                          stream: userStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              // Display the user's name
                              return Visibility(
                                visible: isArrowClick,
                                child: Text(
                                  '$_skills',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.indigo.shade900,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            } else {
                              // Loading or error state
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  CustomCard(
                    color: Color.fromARGB(255, 153, 51, 49),
                    title1: translation(context).noOfOffers,
                    title2: '1',
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  CustomCard(
                    color: Color.fromARGB(224, 92, 181, 95),
                    title1: translation(context).noOfProfileVisits,
                    title2: '100',
                  )
                ],
              ),
              SizedBox(
                height: 75,
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.all(2.0),
              ))
            ])));
  }
}
