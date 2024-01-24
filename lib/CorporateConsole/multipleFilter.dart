import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/gen_l10n/app_localizations.dart';
import 'package:hiremeinindiaapp/homepage.dart';

import '../Models/candidated.dart';
import '../classes/language_constants.dart';
import '../widgets/custombutton.dart';
import '../widgets/customcard.dart';

class MultipleFilter extends StatefulWidget {
  @override
  _MultipleFilterState createState() => _MultipleFilterState();
}

class _MultipleFilterState extends State<MultipleFilter> {
  late String job;
  late String qualification;
  late String selectedQualification;
  late Query<Map<String, dynamic>> query;
  final List<String> jobClassification = [
    'Electrician',
    'Mechanic',
    'Construction Helper ',
    'Meson ',
    'Ac Technician',
    'Telecom Technician',
    'Plumber',
    'Construction Worker',
    'Welder',
    'Fitter',
    'Carpenter',
    'Machine Operators',
    'Operator',
    'Drivers',
    'Painter ',
    'Aircraft mechanic',
    'Security',
    'Logistics Labours',
    'Airport Ground workers',
    'Delivery Workers',
    'Cleaners',
    'Cook',
    'Office Boy',
    'Maid',
    'Collection Staff',
    'Shop Keepers',
    'Electronic repair Technicians ',
    'Barber',
    'Beautician',
    'Catering Workers',
    'Pest Control',
    'Senior Plumber',
    'Junior Plumber',
    'Skill 1',
    'Senior Electrician',
    'Junior Electrician',
    'Skill 2',
  ];
  final List<String> Qualification = [
    "Nill",
    "10th Pass",
    "12th Pass",
    "Diploma",
    "ITI",
    "Under Graduate",
    "Post Graduate",
  ];

  @override
  void initState() {
    job = jobClassification.first;
    qualification = Qualification.first;
    query = FirebaseFirestore.instance.collection("greycollaruser");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.white,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: job,
                        isExpanded: true,
                        items: jobClassification
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            job = item!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 30,
                          width: 200,
                          elevation: 2,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                          ),
                          iconSize: 25,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: null,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 210,
                          width: 156,
                          elevation: 1,
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
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
                          height: 25,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        value: qualification,
                        isExpanded: true,
                        items: Qualification.map(
                            (item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )).toList(),
                        onChanged: (item) {
                          setState(() {
                            qualification = item!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 30,
                          width: 200,
                          elevation: 2,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.white,
                          ),
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                          ),
                          iconSize: 25,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: null,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 210,
                          width: 156,
                          elevation: 1,
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
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
                          height: 25,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  text: 'Save',
                  onPressed: () {},
                ),
                CustomButton(
                  text: 'Run',
                  onPressed: () {},
                ),
                CustomButton(
                  text: 'Create',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 550,
            child: StreamBuilder(
              stream: query.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.hasData) {
                  List<Candidate> candidates = [];
                  candidates = snapshot.data!.docs
                      .map((e) => Candidate.fromSnapshot(e))
                      .toList();
                  if (candidates.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text("No candidates are added yet"),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0.0, 1.0),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(1),
                                  border: Border.all(color: Colors.black12),
                                  color: Colors.white,
                                ),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: PaginatedDataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                      (states) =>
                                          Color.fromARGB(255, 104, 104, 208),
                                    ),
                                    showFirstLastButtons: true,
                                    rowsPerPage: 20,
                                    columns: CandidateListSource.getColumns(),
                                    source: CandidateListSource(
                                      candidates,
                                      context: context,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                if (snapshot.hasError) {
                  return Center(
                    child: SelectableText(snapshot.error.toString()),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CandidateListSource extends DataTableSource {
  final List<Candidate> candidates;
  final BuildContext context;
  CandidateListSource(this.candidates, {required this.context});

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    final e = candidates[(index)];

    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text((index + 1).toString())),
        DataCell(Text(e.name.toString())),
        DataCell(Text(e.mobile.toString())),
        DataCell(Text(e.qualification.toString())),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![0] : ''),
        ),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![1] : ''),
        ),
        DataCell(Text(e.selectedOption?.toString() ?? 'No Option')),
        DataCell(Text(e.mobile.toString())),
        DataCell(Text(e.name.toString())),
      ],
    );
  }

  static List<DataColumn> getColumns() {
    List<DataColumn> list = [];
    list.addAll([
      // const DataColumn(label: Text("S.No")),
      const DataColumn(label: Text('Candidate')),
      const DataColumn(label: Text('Verified')),
      const DataColumn(label: Text('Qualification')),
      const DataColumn(label: Text('Job Classification 1')),
      const DataColumn(label: Text('Job Classification 2')),
      const DataColumn(label: Text('Label')),
      const DataColumn(label: Text('No of Days Open')),
      const DataColumn(label: Text('CV Docs')),
    ]);
    return list;
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => (candidates.length);

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
