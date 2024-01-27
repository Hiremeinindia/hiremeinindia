import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Models/candidated.dart';
import '../Providers/session.dart';
import '../widgets/custombutton.dart';

class MultipleFilter extends StatefulWidget {
  @override
  _MultipleFilterState createState() => _MultipleFilterState();
}

class _MultipleFilterState extends State<MultipleFilter> {
  Candidate? selectedSkills;
  Candidate? qualification;
  late String job;
  late Query<Map<String, dynamic>> query;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    query = FirebaseFirestore.instance.collection("greycollaruser");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Candidate?>(
                      value: selectedSkills,
                      isExpanded: true,
                      items: AppSession()
                          .candidates
                          .map((skill1Iterable) => DropdownMenuItem<Candidate?>(
                                value: skill1Iterable,
                                child: Text(skill1Iterable.selectedSkills![0]),
                              ))
                          .followedBy([
                        const DropdownMenuItem<Candidate?>(
                          value: null,
                          child: Text('Job Classification'),
                        )
                      ]).toList(),
                      onChanged: (item) {
                        setState(() {
                          selectedSkills = item;
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
                        width: 250,
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
                width: 15,
              ),
              SizedBox(
                height: 30,
                width: 250,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<Candidate?>(
                      value: qualification,
                      isExpanded: true,
                      items: AppSession()
                          .candidates
                          .map((skill2Iterable) => DropdownMenuItem<Candidate?>(
                                value: skill2Iterable,
                                child: Text(skill2Iterable.qualification!),
                              ))
                          .followedBy([
                        const DropdownMenuItem<Candidate?>(
                          value: null,
                          child: Text('Qualification Set'),
                        )
                      ]).toList(),
                      onChanged: (item) {
                        setState(() {
                          qualification = item;
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
                        width: 250,
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
                width: 15,
              ),
              CustomButton(
                text: 'Save',
                onPressed: () {},
              ),
              SizedBox(
                width: 15,
              ),
              CustomButton(
                text: 'Run',
                onPressed: () {},
              ),
              SizedBox(
                width: 15,
              ),
              CustomButton(
                text: 'Clear',
                onPressed: () {
                  setState(() {
                    selectedSkills = null;
                    qualification = null;
                  });
                },
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 550,
          child: SizedBox(
            child: StreamBuilder<List<Candidate>>(
                stream: Candidate.getQualifications(candidate: qualification),
                builder: (context, AsyncSnapshot<List<Candidate>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData) {
                    return Listener(
                      onPointerSignal: (event) {
                        if (event is PointerScrollEvent) {
                          final offset = event.scrollDelta.dy;
                          _scrollController
                              .jumpTo(_scrollController.offset + offset);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                child: PaginatedDataTable(
                                  showFirstLastButtons: true,
                                  controller: _scrollController,
                                  rowsPerPage: 20,
                                  // (Get.height ~/ kMinInteractiveDimension) -
                                  //     7,
                                  columns: CandidateListSource.getColumns(),
                                  source: CandidateListSource(
                                    snapshot.data!,
                                    context: context,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: SelectableText(snapshot.error.toString()),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
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
        DataCell(Text(e.mobile ?? '')),
        DataCell(Text(e.qualification ?? '')),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![0] : ''),
        ),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![1] : ''),
        ),
        DataCell(Text(e.selectedOption ?? '- - - -')),
        DataCell(Text(e.mobile ?? '')),
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
