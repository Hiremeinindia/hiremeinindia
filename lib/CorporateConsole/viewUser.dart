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
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Classes/language.dart';
import '../Classes/language_constants.dart';
import '../Widgets/hiremeinindia.dart';
import '../widgets/customdropdown.dart';
import '../Widgets/customTextstyle.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';

// ignore: must_be_immutable
class FullPagePopup extends StatefulWidget {
  final Candidate candidate;
  const FullPagePopup({Key? key, required this.candidate}) : super(key: key);
  @override
  _FullPagePopupState createState() => _FullPagePopupState();
}

class _FullPagePopupState extends State<FullPagePopup> {
  Widget? child;
  IconData? icon;
  Candidate? verified;

  DateTime? _selectedDateTime;
  void initState() {
    super.initState();
  }

  bool expandWork = false;
  bool expandCertificate = false;
  bool expandCourse = false;
  bool expandProject = false;
  void _callNumber(String? mobile) async {
    String url = "tel://$mobile";
    print('Mobile Number:$mobile');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $mobile';
    }
  }

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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 15,
                          color: Colors.indigo.shade900,
                        ),
                        label: Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.indigo.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
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
                            width: 15,
                          ),
                          SizedBox(
                            height: 30,
                            width: 125,
                            child: CustomDropDown<Candidate?>(
                              value: verified,
                              onChanged: (Candidate) {},
                              items: [
                                DropdownMenuItem<Candidate?>(
                                  value: Candidate(verify: 'awaiting_response'),
                                  child: Text('Awaiting response'),
                                ),
                                DropdownMenuItem<Candidate?>(
                                  value:
                                      Candidate(verify: 'interview_scheduled'),
                                  child: Text('Interview Scheduled'),
                                ),
                                DropdownMenuItem<Candidate?>(
                                  value: Candidate(verify: 'curated'),
                                  child: Text('Curated'),
                                ),
                                DropdownMenuItem<Candidate?>(
                                  value: Candidate(verify: 'rejected'),
                                  child: Text('Rejected'),
                                ),
                                DropdownMenuItem<Candidate?>(
                                  value: Candidate(verify: 'hired'),
                                  child: Text('Hired'),
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
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30, bottom: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Container(
                          width: 300,
                          height: 700,
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
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            '${widget.candidate.skills![0]}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            '${widget.candidate.skills![1]}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
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
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            '${widget.candidate.workins![0] ?? '- - -'}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 25,
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
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
                                    onPressed: () async {
                                      DateTime? dateTime =
                                          await showOmniDateTimePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1600).subtract(
                                            const Duration(days: 3652)),
                                        lastDate: DateTime.now().add(
                                          const Duration(days: 3652),
                                        ),
                                        is24HourMode: false,
                                        isShowSeconds: false,
                                        minutesInterval: 1,
                                        secondsInterval: 1,
                                        isForce2Digits: true,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        constraints: const BoxConstraints(
                                          maxWidth: 350,
                                          maxHeight: 650,
                                        ),
                                        transitionBuilder:
                                            (context, anim1, anim2, child) {
                                          return FadeTransition(
                                            opacity: anim1.drive(
                                              Tween(
                                                begin: 0,
                                                end: 1,
                                              ),
                                            ),
                                            child: child,
                                          );
                                        },
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        barrierDismissible: true,
                                        selectableDayPredicate: (dateTime) {
                                          // Disable 25th Feb 2023
                                          if (dateTime ==
                                              DateTime(2023, 2, 25)) {
                                            return false;
                                          } else {
                                            return true;
                                          }
                                        },
                                      );

                                      if (dateTime != null) {
                                        setState(() {
                                          _selectedDateTime = dateTime;
                                        });
                                      }

                                      print("dateTime: $dateTime");
                                    },
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
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          _selectedDateTime != null
                                              ? "${_selectedDateTime.toString()}"
                                              : 'Schedule an interview',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _callNumber(widget.candidate.mobile),
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
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Positioned(
                          bottom: 570,
                          left: 80,
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
                                  '${widget.candidate.name}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo.shade900,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${widget.candidate.skills![0]}',
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
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //basic detail container opening
                          width: 800,
                          height: 265,
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
                                padding:
                                    const EdgeInsets.only(top: 10, left: 20),
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
                                          '${widget.candidate.mobile}',
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
                                          '${widget.candidate.email}',
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
                                          '${widget.candidate.address}',
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
                                padding: const EdgeInsets.only(left: 20.0),
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
                          height: 10,
                        ),
                        AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 800,
                            height: expandWork ? 265 : 50,
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
                            child: expandWork
                                ? Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandWork = !expandWork;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                      ListTile(
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple.shade200),
                                          title: Text(
                                            'Job Description',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
                                          subtitle: Text(
                                            'Work Experience',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          )),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandWork = !expandWork;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                    ],
                                  )),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 800,
                            height: expandCertificate ? 265 : 50,
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
                            child: expandCertificate
                                ? Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandCertificate =
                                                      !expandCertificate;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                      ListTile(
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple.shade200),
                                          title: Text(
                                            'Job Description',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
                                          subtitle: Text(
                                            'Work Experience',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          )),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandCertificate =
                                                      !expandCertificate;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                    ],
                                  )),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 800,
                            height: expandCourse ? 265 : 50,
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
                            child: expandCourse
                                ? Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandCourse = !expandCourse;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                      ListTile(
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple.shade200),
                                          title: Text(
                                            'Job Description',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
                                          subtitle: Text(
                                            'Work Experience',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          )),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandCourse = !expandCourse;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                    ],
                                  )),
                        SizedBox(
                          height: 10,
                        ),
                        AnimatedContainer(
                            duration: Duration(seconds: 1),
                            width: 800,
                            height: expandProject ? 265 : 50,
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
                            child: expandProject
                                ? Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandProject =
                                                      !expandProject;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                      ListTile(
                                          leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.deepPurple.shade200),
                                          title: Text(
                                            'Job Description',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          ),
                                          subtitle: Text(
                                            'Work Experience',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.indigo.shade900,
                                                height: 0),
                                          )),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        width: 800,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Work Experience',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(Icons
                                                  .arrow_drop_down_circle_rounded),
                                              iconSize: 30,
                                              color: Colors.indigo.shade900,
                                              onPressed: () {
                                                setState(() {
                                                  expandProject =
                                                      !expandProject;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.only(
                                            top: 5, left: 20),
                                      ),
                                    ],
                                  )),
                      ])
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
