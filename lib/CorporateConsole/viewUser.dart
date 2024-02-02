import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate.dart';
import 'package:hiremeinindiaapp/CorporateConsole/multipleFilter.dart';
import 'package:hiremeinindiaapp/Providers/session.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/widgets/custombutton.dart';
import '../Classes/language.dart';
import '../Classes/language_constants.dart';
import '../Widgets/hiremeinindia.dart';
import '../widgets/customdropdown.dart';
import 'columnView.dart';
import '../Widgets/customTextstyle.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';

class CompanyViewUser extends StatefulWidget {
  CompanyViewUser();
  @override
  State<CompanyViewUser> createState() => _CompanyViewUser();
}

class _CompanyViewUser extends State<CompanyViewUser> {
  String? selectedValue;

  bool dropdownValue = false;
  bool isArrowClick = false;
  bool val1 = false;
  Candidate? verified;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
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
                  Text(
                    'Corporate Console',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.indigo.shade900,
                        fontFamily: 'Poppins'),
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
                          'Name',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Designation',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo.shade900,
                              height: 0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_new_outlined),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            'Status',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            width: 125,
                            child: CustomDropDown<Candidate?>(
                              value: verified,
                              onChanged: (Candidate? item) {
                                setState(() {
                                  verified = item;
                                });
                              },
                              items: [
                                DropdownMenuItem<Candidate?>(
                                  value: Candidate(
                                      /* your verified candidate instance */),
                                  child: Text('Verified'),
                                ),
                                DropdownMenuItem<Candidate?>(
                                  value:
                                      null, // You can set this to represent "Not Verified"
                                  child: Text('Not Verified'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          CustomRectButton(
                            onPressed: () {},
                            child: ImageIcon(AssetImage("table.png"),
                                size: 40, color: Colors.indigo.shade900),
                            colors: Colors.green.shade200,
                            bottomleft: Radius.circular(5),
                            topleft: Radius.circular(5),
                            bottomright: Radius.zero,
                            topright: Radius.zero,
                          ),
                          CustomRectButton(
                            onPressed: () {},
                            child: ImageIcon(AssetImage("table.png"),
                                size: 30, color: Colors.indigo.shade900),
                            colors: Colors.grey.shade200,
                            bottomleft: Radius.zero,
                            topleft: Radius.zero,
                            bottomright: Radius.zero,
                            topright: Radius.zero,
                          ),
                          CustomRectButton(
                            onPressed: () {},
                            child: ImageIcon(AssetImage("table.png"),
                                size: 50, color: Colors.indigo.shade900),
                            colors: Colors.red.shade200,
                            bottomleft: Radius.zero,
                            topleft: Radius.zero,
                            bottomright: Radius.circular(5),
                            topright: Radius.circular(5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        width: 300,
                        margin: const EdgeInsets.only(bottom: 6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Column(children: [
                          CircleAvatar(
                            backgroundColor: Colors.indigo.shade900,
                            maxRadius: 68,
                            minRadius: 67.5,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: 66,
                              minRadius: 60,
                              child: CircleAvatar(
                                backgroundImage: AssetImage('imguser.jpg'),
                                maxRadius: 59,
                                minRadius: 56,
                              ),
                            ),
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Designation',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.indigo.shade900,
                                height: 0),
                          ),
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: MediaQuery.of(context).size.height,
                              ),
                              width:
                                  MediaQuery.of(context).size.width * 8.5 / 10,
                              child: Card(
                                child: Container(
                                  child: Text(
                                    'Basic Details',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.indigo.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
