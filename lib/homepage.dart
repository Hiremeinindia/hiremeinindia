import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/gethired.dart';
import 'package:hiremeinindiaapp/loginpage.dart';
import 'package:hiremeinindiaapp/main.dart';
import 'package:hiremeinindiaapp/widgets/customtextfield.dart';
import 'package:get/get.dart';
import 'Candidate/blueregistration.dart';
import 'Providers/session.dart';
import 'classes/language.dart';
import 'classes/language_constants.dart';
import 'gen_l10n/app_localizations.dart';
import 'widgets/custombutton.dart';
import 'widgets/hiremeinindia.dart';
import 'widgets/textstylebutton.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': "hello world",
          'message': 'welcome',
        },
        'hi_IN': {
          'hello': 'हिन्दी',
          'message': 'हिन्दी',
        }
      };
}

class HomePage extends StatefulWidget {
  const HomePage();
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ['Tamil', 'English', 'French', 'Malayalam'];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HireMeInIndia(),
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
              translation(context).indiasBestPortalforBlue,
              style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontFamily: 'Poppins',
                  fontSize: 60),
            ),
            Text(
              translation(context).andGreyCollarJob,
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 60),
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
                        child: Image(image: AssetImage('imgbuilding.jpeg'))),
                    SizedBox(
                      width: 200,
                      height: 40,
                      child: CustomButton(
                        text: translation(context).hireNow,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('img.jpg'))),
                    SizedBox(
                        width: 200,
                        height: 40,
                        child: CustomButton(
                          text: translation(context).getJob,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Hired()),
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
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login or Please Register"),
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
                    text: 'Log In'),
                CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BlueRegistration()),
                      );
                    },
                    text: 'Sign Up'),
              ],
            ),
          ],
        );
      },
    );
  }
}
