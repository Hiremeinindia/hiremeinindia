import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/User/user.dart';
import 'package:hiremeinindiaapp/widgets/custombutton.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/language_constants.dart';

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
  Color? labelColor;
  String labelText = '';
  bool expandWork = false;
  bool expandCertificate = false;
  bool expandCourse = false;
  bool expandProject = false;
  void initState() {
    super.initState();
  }

  void _callNumber(String? mobile) async {
    String url = "tel://$mobile";
    print('Mobile Number:$mobile');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $mobile';
    }
  }

  void downloadImage(String imageUrl) async {
    // Check if the URL is not null or empty
    if (imageUrl.isNotEmpty) {
      // Use url_launcher package to launch the URL
      await launch(imageUrl);
    }
    print('image url:$imageUrl');
  }

  void _updateCandidateLabelText(String newText, Color newColor) {
    setState(() {
      labelText = newText;
      labelColor = newColor;
    });
    widget.candidate.updateLabel(newText, newColor);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Padding(
        padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 2.h),
        child: Dialog(
          // The Dialog widget provides a full-page overlay
          child: Material(
            elevation: 4,
            child: LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints) {
              if (constraints.maxWidth >= 870) {
                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
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
                                Container(
                                  width: 130,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color:
                                          labelColor, // Use labelColor variable directly
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('greycollaruser')
                                          .doc(widget.candidate.docId)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return CircularProgressIndicator();
                                        }
                                        return Text(
                                          snapshot.data!.get('labelText') ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.indigo.shade900,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomRectButton(
                                  onPressed: () {
                                    setState(() {
                                      labelText = translation(context).selected;
                                      _updateCandidateLabelText(
                                          translation(context).selected,
                                          Colors.green.shade200);
                                    });
                                  },
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
                                  onPressed: () {
                                    setState(() {
                                      labelText = translation(context).curated;
                                      _updateCandidateLabelText(
                                          translation(context).curated,
                                          Colors.green.shade200);
                                    });
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    child: Icon(
                                      Icons.question_mark_outlined,
                                      color: Colors.indigo.shade900,
                                      size: 30,
                                    ),
                                  ),
                                  colors: Colors.green.shade200,
                                  bottomleft: Radius.zero,
                                  topleft: Radius.zero,
                                  bottomright: Radius.zero,
                                  topright: Radius.zero,
                                ),
                                CustomRectButton(
                                  onPressed: () {
                                    setState(() {
                                      _updateCandidateLabelText(
                                          translation(context).rejected,
                                          Colors.red.shade200);
                                    });
                                  },
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 120,
                                          ),
                                          Text(
                                            '${widget.candidate.aboutYou}',
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.skills![0]}',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(3),
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.skills![1]}',
                                                ),
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.workins![0]}',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              // ignore: unnecessary_null_comparison
                                              widget.candidate.workins![1] !=
                                                      null
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(3),
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
                                                            255, 166, 189, 229),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        '${widget.candidate.workins![1]}',
                                                      ),
                                                    )
                                                  : Container(),
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
                                                    .subtract(const Duration(
                                                        days: 3652)),
                                                lastDate: DateTime.now().add(
                                                  const Duration(days: 3652),
                                                ),
                                                is24HourMode: false,
                                                isShowSeconds: false,
                                                minutesInterval: 1,
                                                secondsInterval: 1,
                                                isForce2Digits: true,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: 350,
                                                  maxHeight: 650,
                                                ),
                                                transitionBuilder: (context,
                                                    anim1, anim2, child) {
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
                                                    const Duration(
                                                        milliseconds: 200),
                                                barrierDismissible: true,
                                                selectableDayPredicate:
                                                    (dateTime) {
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
                                              minimumSize:
                                                  const Size.fromHeight(45),
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor: Color.fromARGB(
                                                  255, 113, 46, 168),
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
                                                  Icons.calendar_month_outlined,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  _selectedDateTime != null
                                                      ? DateFormat.yMMMd()
                                                          .add_jm()
                                                          .format(
                                                              _selectedDateTime!)
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
                                            onPressed: () => _callNumber(
                                                widget.candidate.mobile),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(45),
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor: Color.fromARGB(
                                                  255, 58, 206, 63),
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
                                                    translation(context)
                                                        .makeacall,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                  bottom: 590,
                                  left: 110,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          maxRadius: 68,
                                          minRadius: 67.5,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              maxRadius: 66,
                                              minRadius: 60,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '${widget.candidate.imgPic}'),
                                                maxRadius: 59,
                                                minRadius: 56,
                                              )),
                                        ),
                                        Text(
                                          '${widget.candidate.name}',
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
                            SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  //basic detail container opening
                                  width: 900,
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
                                        width: 900,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
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
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context).age,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.age}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .workExperience,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.workexpcount}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 170,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      downloadImage(
                                                          '${widget.candidate.imgCv}');
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              45),
                                                      fixedSize:
                                                          const Size.fromWidth(
                                                              double.infinity),
                                                      backgroundColor: Colors
                                                          .indigo.shade900,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                                        translation(context)
                                                            .downloadcv,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context)
                                                      .contactnumber,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.mobile}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'CTC',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.ctc}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 225,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      downloadImage(
                                                          '${widget.candidate.imgPic}');
                                                      downloadImage(
                                                          '${widget.candidate.imgVoter}');
                                                      downloadImage(
                                                          '${widget.candidate.imgExp}');
                                                      downloadImage(
                                                          '${widget.candidate.imgAadhar}');
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              45),
                                                      fixedSize:
                                                          const Size.fromWidth(
                                                              double.infinity),
                                                      backgroundColor: Colors
                                                          .indigo.shade900,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                                        translation(context)
                                                            .downloaddoc,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context)
                                                      .emailaddress,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.email}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  translation(context).location,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.address}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ), //basic detail container closing
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandWork ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandWork = !expandWork;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .workExperience,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandWork =
                                                                !expandWork;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.workexp}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text(
                                                      '${widget.candidate.workexpcount}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandWork = !expandWork;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .workExperience,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandWork =
                                                                !expandWork;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandCertificate ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCertificate =
                                                        !expandCertificate;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .educationalqualification,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCertificate =
                                                                !expandCertificate;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.qualification}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text(
                                                      '${widget.candidate.qualiDescription}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCertificate =
                                                        !expandCertificate;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .educationalqualification,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCertificate =
                                                                !expandCertificate;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandCourse ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCourse =
                                                        !expandCourse;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .certifiedcourses,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCourse =
                                                                !expandCourse;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.course}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text('')),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCourse =
                                                        !expandCourse;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .certifiedcourses,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCourse =
                                                                !expandCourse;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandProject ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandProject =
                                                        !expandProject;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .projectworked,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandProject =
                                                                !expandProject;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.project}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text('')),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandProject =
                                                        !expandProject;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .projectworked,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandProject =
                                                                !expandProject;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                              ]),
                            )
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: SingleChildScrollView(
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
                                Container(
                                  width: 130,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color:
                                          labelColor, // Use labelColor variable directly
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('greycollaruser')
                                          .doc(widget.candidate.docId)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return CircularProgressIndicator();
                                        }
                                        return Text(
                                          snapshot.data!.get('labelText') ?? '',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.indigo.shade900,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomRectButton(
                                  onPressed: () {
                                    setState(() {
                                      labelText = translation(context).selected;
                                      _updateCandidateLabelText(
                                          translation(context).selected,
                                          Colors.green.shade200);
                                    });
                                  },
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
                                  onPressed: () {
                                    setState(() {
                                      labelText = translation(context).curated;
                                      _updateCandidateLabelText(
                                          translation(context).curated,
                                          Colors.green.shade200);
                                    });
                                  },
                                  child: SizedBox(
                                    width: 50,
                                    child: Icon(
                                      Icons.question_mark_outlined,
                                      color: Colors.indigo.shade900,
                                      size: 30,
                                    ),
                                  ),
                                  colors: Colors.green.shade200,
                                  bottomleft: Radius.zero,
                                  topleft: Radius.zero,
                                  bottomright: Radius.zero,
                                  topright: Radius.zero,
                                ),
                                CustomRectButton(
                                  onPressed: () {
                                    setState(() {
                                      _updateCandidateLabelText(
                                          translation(context).rejected,
                                          Colors.red.shade200);
                                    });
                                  },
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 120,
                                          ),
                                          Text(
                                            '${widget.candidate.aboutYou}',
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.skills![0]}',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(3),
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.skills![1]}',
                                                ),
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
                                                      255, 166, 189, 229),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  '${widget.candidate.workins![0]}',
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              // ignore: unnecessary_null_comparison
                                              widget.candidate.workins![1] !=
                                                      null
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(3),
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
                                                            255, 166, 189, 229),
                                                        border: Border.all(
                                                          color: Colors.black,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Text(
                                                        '${widget.candidate.workins![1]}',
                                                      ),
                                                    )
                                                  : Container(),
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
                                                    .subtract(const Duration(
                                                        days: 3652)),
                                                lastDate: DateTime.now().add(
                                                  const Duration(days: 3652),
                                                ),
                                                is24HourMode: false,
                                                isShowSeconds: false,
                                                minutesInterval: 1,
                                                secondsInterval: 1,
                                                isForce2Digits: true,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(16)),
                                                constraints:
                                                    const BoxConstraints(
                                                  maxWidth: 350,
                                                  maxHeight: 650,
                                                ),
                                                transitionBuilder: (context,
                                                    anim1, anim2, child) {
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
                                                    const Duration(
                                                        milliseconds: 200),
                                                barrierDismissible: true,
                                                selectableDayPredicate:
                                                    (dateTime) {
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
                                              minimumSize:
                                                  const Size.fromHeight(45),
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor: Color.fromARGB(
                                                  255, 113, 46, 168),
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
                                                  Icons.calendar_month_outlined,
                                                  size: 25,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  _selectedDateTime != null
                                                      ? DateFormat.yMMMd()
                                                          .add_jm()
                                                          .format(
                                                              _selectedDateTime!)
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
                                            onPressed: () => _callNumber(
                                                widget.candidate.mobile),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(45),
                                              fixedSize: const Size.fromWidth(
                                                  double.infinity),
                                              backgroundColor: Color.fromARGB(
                                                  255, 58, 206, 63),
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
                                                    translation(context)
                                                        .makeacall,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                  bottom: 590,
                                  left: 110,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Colors.indigo.shade900,
                                          maxRadius: 68,
                                          minRadius: 67.5,
                                          child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              maxRadius: 66,
                                              minRadius: 60,
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    '${widget.candidate.imgPic}'),
                                                maxRadius: 59,
                                                minRadius: 56,
                                              )),
                                        ),
                                        Text(
                                          '${widget.candidate.name}',
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
                            SingleChildScrollView(
                              child: Column(children: [
                                Container(
                                  //basic detail container opening
                                  width: 900,
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
                                        width: 900,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 146, 176, 226),
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
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 20),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context).age,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.age}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  translation(context)
                                                      .workExperience,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.workexpcount}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 170,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      downloadImage(
                                                          '${widget.candidate.imgCv}');
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              45),
                                                      fixedSize:
                                                          const Size.fromWidth(
                                                              double.infinity),
                                                      backgroundColor: Colors
                                                          .indigo.shade900,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                                        translation(context)
                                                            .downloadcv,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context)
                                                      .contactnumber,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.mobile}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'CTC',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.ctc}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                SizedBox(
                                                  width: 225,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      downloadImage(
                                                          '${widget.candidate.imgPic}');
                                                      downloadImage(
                                                          '${widget.candidate.imgVoter}');
                                                      downloadImage(
                                                          '${widget.candidate.imgExp}');
                                                      downloadImage(
                                                          '${widget.candidate.imgAadhar}');
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              45),
                                                      fixedSize:
                                                          const Size.fromWidth(
                                                              double.infinity),
                                                      backgroundColor: Colors
                                                          .indigo.shade900,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                                        translation(context)
                                                            .downloaddoc,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  translation(context)
                                                      .emailaddress,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.email}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  translation(context).location,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        Colors.indigo.shade900,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${widget.candidate.address}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors
                                                          .indigo.shade900,
                                                      height: 0),
                                                ),
                                                SizedBox(
                                                  height: 60,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ), //basic detail container closing
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandWork ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandWork = !expandWork;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .workExperience,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandWork =
                                                                !expandWork;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.workexp}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text(
                                                      '${widget.candidate.workexpcount}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandWork = !expandWork;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .workExperience,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandWork =
                                                                !expandWork;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandCertificate ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCertificate =
                                                        !expandCertificate;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .educationalqualification,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCertificate =
                                                                !expandCertificate;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.qualification}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text(
                                                      '${widget.candidate.qualiDescription}',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    )),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCertificate =
                                                        !expandCertificate;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .educationalqualification,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCertificate =
                                                                !expandCertificate;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandCourse ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCourse =
                                                        !expandCourse;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .certifiedcourses,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCourse =
                                                                !expandCourse;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.course}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text('')),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandCourse =
                                                        !expandCourse;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .certifiedcourses,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandCourse =
                                                                !expandCourse;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                                AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 900,
                                    height: expandProject ? 255 : 50,
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
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandProject =
                                                        !expandProject;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 146, 176, 226),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(5),
                                                              topRight: Radius
                                                                  .circular(
                                                                      5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .projectworked,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandProject =
                                                                !expandProject;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 10),
                                                child: ListTile(
                                                    title: Text(
                                                      '${widget.candidate.project}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          height: 0),
                                                    ),
                                                    subtitle: Text('')),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    expandProject =
                                                        !expandProject;
                                                  });
                                                },
                                                child: Container(
                                                  width: 900,
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Color
                                                              .fromARGB(
                                                                  255,
                                                                  146,
                                                                  176,
                                                                  226),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        translation(context)
                                                            .projectworked,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        hoverColor:
                                                            Colors.transparent,
                                                        icon: Icon(Icons
                                                            .arrow_drop_down_circle_rounded),
                                                        iconSize: 30,
                                                        color: Colors
                                                            .indigo.shade900,
                                                        onPressed: () {
                                                          setState(() {
                                                            expandProject =
                                                                !expandProject;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 20),
                                                ),
                                              ),
                                            ],
                                          )),
                              ]),
                            )
                          ],
                        ),
                        SizedBox(height: 16.0),
                      ],
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







    