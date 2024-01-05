import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/corporateconsole.dart';
import 'package:hiremeinindiaapp/widgets/hiremeinindia.dart';
import 'package:hiremeinindiaapp/widgets/textstylebutton.dart';

import 'classes/language_constants.dart';
import 'widgets/customcard.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole();
  @override
  State<AdminConsole> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminConsole> {
  @override
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

  bool val1 = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: HireMeInIndia(),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 50.0, top: 10),
              child: Row(
                children: [
                  Text(
                    'Admin Console',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.indigo.shade900,
                        fontFamily: 'Poppins'),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suresh',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
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
                    Row(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: const Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Hello Suresh',
                                    style: CustomTextStyle.nameOfUser,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: items
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: CustomTextStyle.nameOflist,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: 270,
                              elevation: 1,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_sharp,
                              ),
                              iconSize: 45,
                              iconEnabledColor: Colors.indigo,
                              iconDisabledColor: null,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 210,
                              width: 270,
                              elevation: 0,
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              scrollPadding: EdgeInsets.all(5),
                              scrollbarTheme: ScrollbarThemeData(
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 50,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        CustomCard(
                          color: Color.fromARGB(255, 153, 51, 49),
                          title1: translation(context).noOfCandidates,
                          title2: '1',
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        CustomCard(
                          color: Color.fromARGB(255, 105, 182, 46),
                          title1: translation(context).noOfCompanies,
                          title2: '100',
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        CustomCard(
                          color: Color.fromARGB(255, 138, 40, 156),
                          title1: translation(context).candidates,
                          title2: '100',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CorporateConsole()),
                            );
                          },
                        ),
                        SizedBox(
                          width: 60,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translation(context).payments,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Poppins'),
                        ),
                        SizedBox(
                          width: 100,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Text(
                                    translation(context).today,
                                    style: CustomTextStyle.nameOfHeading,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: CustomTextStyle.nameOflist,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
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
                                iconSize: 14,
                                iconEnabledColor: Colors.grey,
                                iconDisabledColor: null,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 210,
                                width: 270,
                                elevation: 0,
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black),
                                  color: Colors.white,
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
                      ],
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomCard(
                          color: const Color.fromARGB(255, 125, 83, 196),
                          title1: translation(context).cash,
                          title2: '1',
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        CustomCard(
                          color: const Color.fromARGB(255, 125, 83, 196),
                          title1: translation(context).online,
                          title2: '100',
                        ),
                        Spacer(),
                        Text(
                          translation(context).total,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ));
  }
}
