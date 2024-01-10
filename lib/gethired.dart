import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/User/GreyUser/greyRegistration.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';

import 'User/BlueUser/blueregistration.dart';
import 'widgets/custombutton.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'Widgets/customtextstyle.dart';

class Hired extends StatefulWidget {
  const Hired();
  @override
  State<Hired> createState() => _HiredState();
}

class _HiredState extends State<Hired> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> greycountDocuments() async {
    QuerySnapshot<Map<String, dynamic>> myDoc =
        await firestore.collection('bluecollaruser').get();
    List<DocumentSnapshot<Map<String, dynamic>>> myDocCount = myDoc.docs;
    return myDocCount.length; // Return the count of documents in the collection
  }

  Future<int> bluecountDocuments() async {
    QuerySnapshot<Map<String, dynamic>> myDoc =
        await firestore.collection('greycollaruser').get();
    List<DocumentSnapshot<Map<String, dynamic>>> myDocCount = myDoc.docs;
    return myDocCount.length; // Return the count of documents in the collection
  }

  @override
  Widget build(BuildContext context) {
    var query;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              translation(context).getHiredFromTheBest,
              style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 60),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('imgman.jpg'))),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: CustomButton(
                          text: translation(context).blueCollerJobs,
                          onPressed: () {
                            _showblueDialog();
                          },
                        )),
                    SizedBox(
                      height: 7,
                    ),
                    FutureBuilder<int>(
                      future: bluecountDocuments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          int docCount = snapshot.data ?? 0;
                          return Text(
                            ' $docCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.indigo.shade900,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('imggirl.jpg'))),
                    SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: CustomButton(
                          text: translation(context).greyCollerJobs,
                          onPressed: () {
                            _showgreyDialog(context);
                          },
                        )),
                    SizedBox(
                      height: 7,
                    ),
                    FutureBuilder<int>(
                      future: greycountDocuments(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          int docCount = snapshot.data ?? 0;
                          return Text(
                            ' $docCount',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.indigo.shade900,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showblueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            translation(context).blueCollerJobs,
          ),
          content: Text('Login or Please Register'),
          actions: <Widget>[
            CustomButton(
              text: 'LogIn',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            CustomButton(
              text: 'SignUp',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlueRegistration()),
                );
              },
            )
          ],
        );
      },
    );
  }
}

void _showgreyDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          translation(context).greyCollerJobs,
        ),
        content: Text('Login or Please Register'),
        actions: <Widget>[
          CustomButton(
            text: 'LogIn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          CustomButton(
            text: 'SignUp',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Registration()),
              );
            },
          )
        ],
      );
    },
  );
}
