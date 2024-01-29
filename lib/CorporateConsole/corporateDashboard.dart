import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate.dart';
import 'package:hiremeinindiaapp/CorporateConsole/multipleFilter.dart';
import 'package:hiremeinindiaapp/Providers/session.dart';
import '../Classes/language.dart';
import '../Classes/language_constants.dart';
import '../Widgets/hiremeinindia.dart';
import 'columnView.dart';
import '../Widgets/customTextstyle.dart';
import '../gen_l10n/app_localizations.dart';
import '../main.dart';

class CorporateDashboard extends StatefulWidget {
  final User user;
  CorporateDashboard({required this.user});
  @override
  State<CorporateDashboard> createState() => _CorporateDashboard();
}

class _CorporateDashboard extends State<CorporateDashboard> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  bool dropdownValue = false;
  bool isArrowClick = false;
  bool val1 = false;

  bool isPressed = false;

  @override
  late Stream<Map<String, dynamic>?> userStream;
  String _userName = '';
  String _designation = '';

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
                                '$_designation',
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
        body: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 170, right: 170, top: 20, bottom: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        isPressed ? 'Multiple View' : 'Column View',
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
                                            'Hello $_userName',
                                            style: CustomTextStyle.nameOfUser,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          IconButton(
                                            icon: Icon(
                                                Icons.arrow_downward_sharp),
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
                                          'Tata Salt',
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
                                  width: 73,
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
                                    child: ImageIcon(
                                      AssetImage("filter.png"),
                                      size: 25,
                                      color: isPressed
                                          ? Colors.white
                                          : Colors.indigo.shade900,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 73,
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
                                    child: ImageIcon(
                                      AssetImage("column.png"),
                                      size: 25,
                                      color: isPressed
                                          ? Colors.indigo.shade900
                                          : Colors.white,
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
                      height: 50,
                    ),
                    isPressed ? MultipleFilter() : ColumnView(),
                  ]),
            ),
          ],
        ));
  }
}
