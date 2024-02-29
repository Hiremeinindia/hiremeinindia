import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/CorporateConsole/corporate_registration.dart';
import 'package:hiremeinindiaapp/gethired.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'Widgets/customtextstyle.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'widgets/custombutton.dart';
import 'package:sizer/sizer.dart';
import 'widgets/hiremeinindia.dart';

class HomePage extends StatefulWidget {
  const HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
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
                                              style:
                                                  CustomTextStyle.dropdowntext,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              e.langname,
                                              style:
                                                  CustomTextStyle.dropdowntext,
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
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                              SizedBox(
                                height: 5,
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
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.1.w, 0.1.h, 0.1.w, 0.1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Text(
                          translation(context).indiasBestPortalforBlue,
                          style: TextStyle(
                              color: Colors.indigo.shade900,
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          translation(context).andGreyCollarJob,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                          ),
                        ),
                      ]),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imgbuilding.jpeg?alt=media&token=000f8b21-f783-4c92-a475-767b75dab94c',
                                height: 200,
                                width: 200,
                              ),
                              SizedBox(
                                width: 200,
                                height: 50,
                                child: CustomButton(
                                  text: translation(context).hireNow,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return CorporateRegistration();
                                      },
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 50),
                          Column(
                            children: [
                              Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/img.jpg?alt=media&token=4f013131-5ba4-4811-bfd3-f25c6ececb1e',
                                height: 200,
                                width: 200,
                              ),
                              SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: CustomButton(
                                    text: translation(context).getJob,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Hired()),
                                      );
                                    },
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            endDrawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.only(
                    top: 3.h,
                  ),
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 41,
                      minRadius: 41,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        maxRadius: 40,
                        minRadius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 60,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text(
                        translation(context).guest,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.indigo.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        translation(context).user,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo.shade900,
                            height: 0),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ExpansionTile(
                      collapsedBackgroundColor: Colors.indigo.shade900,
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      textColor: Colors.black,
                      iconColor: Colors.black,
                      title: Text(
                        AppLocalizations.of(context)!.english,
                      ),
                      children: Language.languageList().map((language) {
                        return ListTile(
                          hoverColor: Colors.indigo.shade100,
                          title: Text(
                            language.langname,
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: () async {
                            // Handle language selection
                            Locale _locale =
                                await setLocale(language.languageCode);
                            HireApp.setLocale(context, _locale);
                          },
                        );
                      }).toList(),
                    ),
                    ExpansionTile(
                        collapsedBackgroundColor: Colors.indigo.shade900,
                        collapsedIconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        iconColor: Colors.black,
                        textColor: Colors.black,
                        title: Text(
                          AppLocalizations.of(context)!.findaJob,
                        ),
                        children: [
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option1',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            hoverColor: Colors.indigo.shade100,
                            title: Text(
                              'option2',
                              style: TextStyle(color: Colors.black),
                            ),
                            onTap: () {},
                          )
                        ]),
                  ]),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Container(
                height: 80,
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HireMeInIndia(),
                        Builder(
                            builder: (context) => IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openEndDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color: Colors.indigo.shade900,
                                  ),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0.1.w, 0.1.h, 0.1.w, 0.1.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Text(
                          translation(context).indiasBestPortalforBlue,
                          style: TextStyle(
                              color: Colors.indigo.shade900,
                              fontFamily: 'Poppins',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          translation(context).andGreyCollarJob,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Poppins',
                            fontSize: 11.sp,
                          ),
                        ),
                      ]),
                      SizedBox(height: 30),
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/imgbuilding.jpeg?alt=media&token=000f8b21-f783-4c92-a475-767b75dab94c',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: CustomButton(
                          text: translation(context).hireNow,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CorporateRegistration();
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50),
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/img.jpg?alt=media&token=4f013131-5ba4-4811-bfd3-f25c6ececb1e',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                          width: 200,
                          height: 50,
                          child: CustomButton(
                            text: translation(context).getJob,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hired()),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(translation(context).loginorpleaseregister),
          content: Text(''),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    text: translation(context).login),
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CorporateRegistration()),
                      );
                    },
                    text: translation(context).signup),
              ],
            ),
          ],
        );
      },
    );
  }
}
