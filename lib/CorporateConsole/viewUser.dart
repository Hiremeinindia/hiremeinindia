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
            padding: const EdgeInsets.all(80.0),
            child: Column(
              children: [
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FullPagePopup(); // Your custom full-page pop-up widget
                            },
                          );
                        },
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
                ),
              ],
            ),
          ),
        ));
  }
}

class FullPagePopup extends StatelessWidget {
  Candidate? verified;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // The Dialog widget provides a full-page overlay
      child: Container(
        height: 1000,
        width: 1500,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
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
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Container(
                          width: 300,
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
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 140,
                                  ),
                                  Text(
                                    'Designation about the candidate',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.indigo.shade900,
                                        height: 0),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Skills',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.indigo.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF000000),
                                                style: BorderStyle
                                                    .solid), //Border.all
                                            /*** The BorderRadius widget  is here ***/
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ), //BorderRadius.all
                                          ), //BoxDecoration
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 25,
                                        width: 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF000000),
                                                style: BorderStyle
                                                    .solid), //Border.all
                                            /*** The BorderRadius widget  is here ***/
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ), //BorderRadius.all
                                          ), //BoxDecoration
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        width: 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF000000),
                                                style: BorderStyle
                                                    .solid), //Border.all
                                            /*** The BorderRadius widget  is here ***/
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(25),
                                            ), //BorderRadius.all
                                          ), //BoxDecoration
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 25,
                                        width: 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF000000),
                                                style: BorderStyle
                                                    .solid), //Border.all
                                            /*** The BorderRadius widget  is here ***/
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ), //BorderRadius.all
                                          ), //BoxDecoration
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(45),
                                      fixedSize:
                                          const Size.fromWidth(double.infinity),
                                      backgroundColor:
                                          Color.fromARGB(255, 113, 46, 168),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Adjust border radius as needed
                                      ),
                                    ),
                                    child: Row(children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Schedule an interview',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(45),
                                      fixedSize:
                                          const Size.fromWidth(double.infinity),
                                      backgroundColor:
                                          Color.fromARGB(255, 58, 206, 63),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Adjust border radius as needed
                                      ),
                                    ),
                                    child: Row(children: [
                                      Icon(
                                        Icons.call_rounded,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Make a call',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Positioned(
                          bottom: 400,
                          left: 70,
                          child: Container(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.indigo.shade900,
                                  maxRadius: 68,
                                  minRadius: 67.5,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    maxRadius: 66,
                                    minRadius: 60,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('imguser.jpg'),
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          //basic detail container opening
                          width: 800,
                          height: 300,
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
                          child: Column(
                            children: [
                              Container(
                                width: 800,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 146, 176, 226),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5))),
                                child: Text(
                                  'Basic Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                padding: const EdgeInsets.only(left: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '22',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Work Experience',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '8 months',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Contact Number',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '7897897897',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'CTC',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '2.3 Lakh',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Email address',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'mail@gmail.com',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'location',
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 230,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(45),
                                          fixedSize: const Size.fromWidth(
                                              double.infinity),
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust border radius as needed
                                          ),
                                        ),
                                        child: Row(children: [
                                          Icon(
                                            Icons.download,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Download CV',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 230,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust border radius as needed
                                          ),
                                        ),
                                        child: Row(children: [
                                          Icon(
                                            Icons.download,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Download Documents',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ), //basic detail container closing
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          //basic detail container opening
                          width: 800,
                          height: 300,
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
                          child: Column(
                            children: [
                              Container(
                                width: 800,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 146, 176, 226),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5))),
                                child: Text(
                                  'Basic Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                padding: const EdgeInsets.only(left: 20),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Age',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '22',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Work Experience',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '8 months',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Contact Number',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '7897897897',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'CTC',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '2.3 Lakh',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Email address',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'mail@gmail.com',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Location',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'location',
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
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 230,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(45),
                                          fixedSize: const Size.fromWidth(
                                              double.infinity),
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust border radius as needed
                                          ),
                                        ),
                                        child: Row(children: [
                                          Icon(
                                            Icons.download,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Download CV',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    SizedBox(
                                      height: 40,
                                      width: 230,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5), // Adjust border radius as needed
                                          ),
                                        ),
                                        child: Row(children: [
                                          Icon(
                                            Icons.download,
                                            size: 25,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Download Documents',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ), //basic detail container closing
                      ]),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
