import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/CorporateConsole/multipleFilter.dart';
import 'package:sizer/sizer.dart';
import '../Widgets/hiremeinindia.dart';
import '../Widgets/customTextstyle.dart';
import '../classes/language.dart';
import '../classes/language_constants.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';
import 'columnView.dart';

class CorporateDashboard extends StatefulWidget {
  final User user;
  CorporateDashboard({required this.user});
  @override
  State<CorporateDashboard> createState() => _CorporateDashboard();
}

class _CorporateDashboard extends State<CorporateDashboard> {
  String? selectedValue;

  bool dropdownValue = false;
  bool isArrowClick = false;
  bool val1 = false;

  bool isPressed = false;

  @override
  late Stream<Map<String, dynamic>?> userStream;
  String _userName = '';
  String _designation = '';
  String _companyName = '';

  @override
  void initState() {
    super.initState();
    userStream = fetchData().map((data) => data);
  }

  Stream<Map<String, dynamic>?> fetchData() {
    try {
      return FirebaseFirestore.instance
          .collection('corporateuser')
          .doc(widget.user.uid)
          .snapshots()
          .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()!;
          String name = data['name'];
          String designation = data['designation'];
          String companyName = data['companyname'];
          _companyName = companyName;
          _userName = name;
          _designation = designation;
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
                    Text(
                      translation(context).corporateconsole,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.indigo.shade900,
                          fontFamily: 'Poppins'),
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
                    StreamBuilder<Map<String, dynamic>?>(
                      stream: userStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          // Display the user's name
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                '$_designation',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.indigo.shade900,
                                    height: 0),
                              ),
                            ],
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
        ),
      ),
      body: Material(
        elevation: 4,
        child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints) {
          if (constraints.maxWidth >= 633) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(2.5.w, 2.5.h, 2.5.w, 2.5.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          isPressed
                              ? translation(context).multiplefilter
                              : translation(context).columnview,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: StreamBuilder<Map<String, dynamic>?>(
                                  stream: userStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      // Display the user's name
                                      return Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "${translation(context).hello} $_userName",
                                              style: CustomTextStyle.nameOfUser,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(
                                                  Icons.arrow_drop_down_sharp),
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
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    // Display the user's name
                                    return Visibility(
                                      visible: isArrowClick,
                                      child: Row(
                                        children: [
                                          Text(
                                            '$_designation',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                          ),
                                          Text('|'),
                                          Text(
                                            '$_companyName',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
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
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPressed
                                            ? Colors.indigo.shade900
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              7), // Adjust border radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ImageIcon(
                                          NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/filter.png?alt=media&token=fb12f309-716f-4b68-94b0-2c551dd998b5',
                                          ),
                                          size: 25,
                                          color: isPressed
                                              ? Colors.white
                                              : Colors.indigo.shade900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPressed
                                            ? Colors.white
                                            : Colors.indigo.shade900,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              7), // Adjust border radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ImageIcon(
                                          NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/table.png?alt=media&token=75eaa626-2b1f-4faf-8ce5-73480c3141df',
                                          ),
                                          size: 25,
                                          color: isPressed
                                              ? Colors.indigo.shade900
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isPressed ? MultipleFilter() : ColumnView(),
                    ]),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(2.5.w, 2.5.h, 2.5.w, 2.5.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          isPressed
                              ? translation(context).multiplefilter
                              : translation(context).columnview,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: StreamBuilder<Map<String, dynamic>?>(
                                  stream: userStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      // Display the user's name
                                      return Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "${translation(context).hello} $_userName",
                                              style: CustomTextStyle.nameOfUser,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            IconButton(
                                              hoverColor: Colors.transparent,
                                              icon: Icon(
                                                  Icons.arrow_drop_down_sharp),
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
                                  if (snapshot.hasData &&
                                      snapshot.data != null) {
                                    // Display the user's name
                                    return Visibility(
                                      visible: isArrowClick,
                                      child: Row(
                                        children: [
                                          Text(
                                            '$_designation',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
                                          ),
                                          Text('|'),
                                          Text(
                                            '$_companyName',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.indigo.shade900,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Poppins'),
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
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPressed
                                            ? Colors.indigo.shade900
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              7), // Adjust border radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ImageIcon(
                                          NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/filter.png?alt=media&token=fb12f309-716f-4b68-94b0-2c551dd998b5',
                                          ),
                                          size: 25,
                                          color: isPressed
                                              ? Colors.white
                                              : Colors.indigo.shade900,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 70,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isPressed
                                            ? Colors.white
                                            : Colors.indigo.shade900,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              7), // Adjust border radius as needed
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: ImageIcon(
                                          NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/table.png?alt=media&token=75eaa626-2b1f-4faf-8ce5-73480c3141df',
                                          ),
                                          size: 25,
                                          color: isPressed
                                              ? Colors.indigo.shade900
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isPressed ? MultipleFilter() : ColumnView(),
                    ]),
              ),
            );
          }
        }),
      ),
    );
  }
}
