import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../User/user.dart';
import '../Providers/session.dart';
import '../widgets/custombutton.dart';

class MultipleFilter extends StatefulWidget {
  @override
  _MultipleFilterState createState() => _MultipleFilterState();
}

class _MultipleFilterState extends State<MultipleFilter> {
  Candidate? skills;
  Candidate? qualification;
  late String job;
  late Query<Map<String, dynamic>> query;
  late Query<Map<String, dynamic>> originalQuery;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    originalQuery = FirebaseFirestore.instance.collection("greycollaruser");
    query = originalQuery;
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
                      value: skills,
                      isExpanded: true,
                      items: AppSession()
                          .candidates
                          .map((agentIterable) => DropdownMenuItem<Candidate>(
                                value: agentIterable,
                                child: Text(agentIterable.skills![0]),
                              ))
                          .followedBy([
                        const DropdownMenuItem<Candidate>(
                          value: null,
                          child: Text('Job Classification'),
                        )
                      ]).toList(),
                      onChanged: (item) {
                        setState(() {
                          skills = item;
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2<Candidate?>(
                        value: qualification,
                        isExpanded: true,
                        items: AppSession()
                            .candidates
                            .map((agentIterable) => DropdownMenuItem<Candidate>(
                                  value: agentIterable,
                                  child: Text(agentIterable.qualification!),
                                ))
                            .followedBy([
                          const DropdownMenuItem<Candidate>(
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
                    );
                  }),
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
                onPressed: () {
                  // Reset the query to its original state
                  query = originalQuery;

                  // Check if skills are selected
                  if (skills != null) {
                    query = query.where(
                      "skills",
                      arrayContainsAny: skills!.skills,
                    );
                  }

                  // Check if qualification is selected
                  if (qualification != null) {
                    query = query.where(
                      "qualification",
                      isEqualTo: qualification!.qualification,
                    );
                  }

                  // You can add more conditions here for other filters

                  // Update the StreamBuilder to reflect the new query
                  setState(() {});
                },
              ),
              SizedBox(
                width: 15,
              ),
              CustomButton(
                text: 'Clear',
                onPressed: () {
                  setState(() {
                    skills = null;
                    qualification = null;

                    // Reset the query to its initial state
                    query =
                        FirebaseFirestore.instance.collection("greycollaruser");
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
                stream: query.snapshots().map((snapshot) {
                  return snapshot.docs
                      .map((doc) => Candidate.fromSnapshot(doc))
                      .toList();
                }),
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
                                  rowsPerPage: 8,
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
        DataCell(SizedBox(
          width: 27,
          height: 27,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 51, 116, 53),
          ),
        )),
        DataCell(Text(e.qualification ?? '')),
        DataCell(
          Text(e.skills!.isNotEmpty ? e.skills![0] : ''),
        ),
        DataCell(
          Text(e.skills!.isNotEmpty ? e.skills![1] : ''),
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
