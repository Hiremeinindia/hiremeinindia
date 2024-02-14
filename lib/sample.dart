import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/widgets/custombutton.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/language_constants.dart';

// ignore: must_be_immutable
class Sample extends StatefulWidget {
  const Sample();
  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  Widget? child;
  IconData? icon;
  Candidate? verified;

  DateTime? _selectedDateTime;
  Color? labelColor;
  String labelText = '';
  bool expandWork = false;
  bool expandCertificate = false;
  bool expandCourse = false;
  bool expandProject = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // The Dialog widget provides a full-page overlay
      child: Padding(
        padding:
            const EdgeInsets.only(left: 80.0, right: 80, top: 50, bottom: 50),
        child: Container(
          height: 1000,
          width: 1200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        translation(context).back,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    children: [
                      Text(
                        translation(context).status,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomRectButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: 50,
                          child: Icon(
                            Icons.check,
                            color: Colors.indigo.shade900,
                            size: 30,
                          ),
                        ),
                        colors: Colors.green.shade200,
                        bottomleft: Radius.circular(5),
                        topleft: Radius.circular(5),
                        bottomright: Radius.zero,
                        topright: Radius.zero,
                      ),
                      CustomRectButton(
                        onPressed: () {},
                        child: SizedBox(
                          height: 50,
                          child: Icon(
                            Icons.question_mark,
                            color: Colors.indigo.shade900,
                            size: 30,
                          ),
                        ),
                        colors: Colors.yellow.shade200,
                        bottomleft: Radius.zero,
                        topleft: Radius.zero,
                        bottomright: Radius.zero,
                        topright: Radius.zero,
                      ),
                      CustomRectButton(
                        onPressed: () {},
                        child: SizedBox(
                          width: 50,
                          child: Icon(
                            Icons.cancel,
                            color: Colors.indigo.shade900,
                            size: 30,
                          ),
                        ),
                        colors: Colors.red.shade200,
                        bottomleft: Radius.zero,
                        topleft: Radius.zero,
                        bottomright: Radius.circular(5),
                        topright: Radius.circular(5),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Container(
                        width: 360,
                        height: 680,
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
                                  height: 120,
                                ),
                                Text(
                                  '{widget.candidate.aboutYou}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.indigo.shade900,
                                      height: 0),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  translation(context).skills,
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
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        '{widget.candidate.skills![0]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.indigo.shade900,
                                            height: 0),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF000000),
                                            style:
                                                BorderStyle.solid), //Border.all
                                        /*** The BorderRadius widget  is here ***/
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ), //BorderRadius.all
                                      ), //BoxDecoration
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        '{widget.candidate.skills![1]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.indigo.shade900,
                                            height: 0),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF000000),
                                            style:
                                                BorderStyle.solid), //Border.all
                                        /*** The BorderRadius widget  is here ***/
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ), //BorderRadius.all
                                      ), //BoxDecoration
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3),
                                      child: Text(
                                        '{widget.candidate.workins![0]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.indigo.shade900,
                                            height: 0),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF000000),
                                            style:
                                                BorderStyle.solid), //Border.all
                                        /*** The BorderRadius widget  is here ***/
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ), //BorderRadius.all
                                      ), //BoxDecoration
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
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
                                            style:
                                                BorderStyle.solid), //Border.all
                                        /*** The BorderRadius widget  is here ***/
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ), //BorderRadius.all
                                      ), //BoxDecoration
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
                                      firstDate: DateTime(1600)
                                          .subtract(const Duration(days: 3652)),
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
                                        if (dateTime == DateTime(2023, 2, 25)) {
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        _selectedDateTime != null
                                            ? DateFormat.yMMMd()
                                                .add_jm()
                                                .format(_selectedDateTime!)
                                            : translation(context)
                                                .scheduleaninterview,
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
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(45),
                                    backgroundColor:
                                        Color.fromARGB(255, 58, 206, 63),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Adjust border radius as needed
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.call_rounded,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          translation(context).makeacall,
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
                        bottom: 580,
                        left: 85,
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
                                      backgroundImage: NetworkImage(
                                          '{widget.candidate.imgPic}'),
                                      maxRadius: 59,
                                      minRadius: 56,
                                    )),
                              ),
                              Text(
                                '{widget.candidate.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '{widget.candidate.skills![0]}',
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
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 55.0),
                      child: Column(children: [
                        Container(
                          height: 255,
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
                                height: 50,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 146, 176, 226),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5))),
                                child: Text(
                                  translation(context).basicdetails,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          translation(context).age,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '{widget.candidate.age}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          translation(context).workExperience,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.indigo.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '{widget.candidate.workexpcount}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.indigo.shade900,
                                              height: 0),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(100, 45),
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
                                              translation(context).downloadcv,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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

// class FireStoreDataBase {
//   String? dowloadURL;
//   Future getData() async {
//     try {
//       await downloadURLExample();
//       return dowloadURL;
//     } catch (e) {
//       debugPrint("Error - $e");
//       return null;
//     }
//   }

//   Future<void> downloadURLExample() async {
//     dowloadURL = await FirebaseStorage.instance
//         .ref()
//         .child('${widget.candidate.qualification}')
//         .getDownloadURL();
//     debugPrint(dowloadURL.toString());
//   }
// }
