import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/User/userRegistration.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';
import 'package:sizer/sizer.dart';
import 'widgets/custombutton.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'Widgets/customtextstyle.dart';

class Hired extends StatefulWidget {
  Hired();
  @override
  State<Hired> createState() => _HiredState();
}

class _HiredState extends State<Hired> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> BlueResult() async {
    var query = await FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('label', isEqualTo: 'Blue');
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<int> GreyResult() async {
    var query = await FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('label', isEqualTo: 'Grey');
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
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
                                width: 150,
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
          body: LayoutBuilder(
              builder: (BuildContext ctx, BoxConstraints constraints) {
            if (constraints.maxWidth >= 850) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).getHiredFromTheBest,
                        style: TextStyle(
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imgman.jpg?alt=media&token=cdedbec0-90cb-4dcd-a1dc-0b14519e23e0',
                                height: 200,
                                width: 200,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: CustomButton(
                                    text: translation(context).blueCollerJobs,
                                    onPressed: () {
                                      String selectedOption = 'Blue';
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Registration(
                                            selectedOption: selectedOption,
                                          );
                                        },
                                      );
                                    },
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              FutureBuilder<int>(
                                future: BlueResult(),
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
                              Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imggirl.jpg?alt=media&token=3f69ad23-aa0a-4609-a05c-f845e37ab381',
                                height: 200,
                                width: 200,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: CustomButton(
                                    text: translation(context).greyCollerJobs,
                                    onPressed: () {
                                      String selectedOption = 'Grey';
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Registration(
                                            selectedOption: selectedOption,
                                          );
                                        },
                                      );
                                    },
                                  )),
                              SizedBox(
                                height: 7,
                              ),
                              FutureBuilder<int>(
                                future: GreyResult(),
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
            } else {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).getHiredFromTheBest,
                        style: TextStyle(
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(height: 30),
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imgman.jpg?alt=media&token=cdedbec0-90cb-4dcd-a1dc-0b14519e23e0',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                          width: 200,
                          height: 50,
                          child: CustomButton(
                            text: translation(context).blueCollerJobs,
                            onPressed: () {
                              String selectedOption = 'Blue';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Registration(
                                    selectedOption: selectedOption,
                                  );
                                },
                              );
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FutureBuilder<int>(
                        future: BlueResult(),
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
                      SizedBox(height: 50),
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imggirl.jpg?alt=media&token=3f69ad23-aa0a-4609-a05c-f845e37ab381',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                          width: 200,
                          height: 50,
                          child: CustomButton(
                            text: translation(context).greyCollerJobs,
                            onPressed: () {
                              String selectedOption = 'Grey';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Registration(
                                    selectedOption: selectedOption,
                                  );
                                },
                              );
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FutureBuilder<int>(
                        future: GreyResult(),
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
                ),
              );
            }
          }));
    });
  }

  void _showblueDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            translation(context).blueCollerJobs,
          ),
          content: Text(translation(context).loginorpleaseregister),
          actions: <Widget>[
            CustomButton(
              text: translation(context).login,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            CustomButton(
              text: translation(context).signup,
              onPressed: () {
                String selectedOption = 'Blue';
                showDialog(
                  context: context,
                  builder: (context) {
                    return Registration(
                      selectedOption: selectedOption,
                    );
                  },
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
        content: Text(translation(context).loginorpleaseregister),
        actions: <Widget>[
          CustomButton(
            text: translation(context).login,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          CustomButton(
            text: translation(context).signup,
            onPressed: () {
              String selectedOption = 'Grey';
              showDialog(
                context: context,
                builder: (context) {
                  return Registration(
                    selectedOption: selectedOption,
                  );
                },
              );
            },
          )
        ],
      );
    },
  );
}
