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
  List<Query<Map<String, dynamic>>> savedQueries = [];
  late Query<Map<String, dynamic>> query;
  late Query<Map<String, dynamic>> originalQuery;
  final ScrollController _scrollController = ScrollController();
  List<String> itemList = [];

  List<Candidate?> skillsList = [];
  List<Candidate?> qualificationList = [];

  @override
  void initState() {
    originalQuery = FirebaseFirestore.instance.collection("greycollaruser");
    query = originalQuery;
    for (int i = 0; i < 3; i++) {
      skillsList.add(null);
      qualificationList.add(null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 165,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      icon: Icon(Icons.add),
                      iconSize: 30,
                      color: Colors.black,
                      onPressed: () {
                        // When the icon button is clicked, add a new item to the list
                        setState(() {
                          itemList.add(" ${itemList.length + 2}");
                        });
                      },
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
                            value: skills,
                            isExpanded: true,
                            items: AppSession()
                                .candidates
                                .map((skill1Iterable) =>
                                    DropdownMenuItem<Candidate?>(
                                      value: skill1Iterable,
                                      child: Text(skill1Iterable
                                          .skills![0]), // Update this line
                                    ))
                                .followedBy([
                              const DropdownMenuItem<Candidate?>(
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
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                                  .map((skill2Iterable) =>
                                      DropdownMenuItem<Candidate?>(
                                        value: skill2Iterable,
                                        child:
                                            Text(skill2Iterable.qualification!),
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
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
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
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CustomButton(
                      text: 'Save',
                      onPressed: () {
                        // Save the current query when the "Save" button is pressed
                        setState(() {
                          savedQueries.add(query);
                          print('Saved query: $query');
                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CustomButton(
                      text: 'Run',
                      onPressed: () {
                        if (savedQueries.isNotEmpty) {
                          // Create a copy of the original query to start fresh
                          Query<Map<String, dynamic>> currentQuery =
                              originalQuery;

                          for (final savedQuery in savedQueries) {
                            List<String> allSkills = [];
                            for (int index = 0;
                                index < skillsList.length;
                                index++) {
                              if (skillsList[index] != null &&
                                  skillsList[index]!.skills!.isNotEmpty) {
                                allSkills.addAll(skillsList[index]!.skills!);
                              }
                            }

                            if (allSkills.isNotEmpty) {
                              currentQuery = currentQuery.where(
                                "skills",
                                arrayContainsAny: allSkills,
                              );
                              print('Applying skills filter: $allSkills');
                            }

                            for (int index = 0;
                                index < qualificationList.length;
                                index++) {
                              if (qualificationList[index] != null) {
                                currentQuery = currentQuery.where(
                                  "qualification",
                                  isEqualTo:
                                      qualificationList[index]!.qualification,
                                );
                                print(
                                    'Applying qualification filter: ${qualificationList[index]!.qualification}');
                              }
                            }

                            // Print the final query for debugging
                            print('Final query: $currentQuery');
                          }

                          // Update the UI after applying all saved queries
                          setState(() {
                            query = currentQuery;
                          });

                          // Print the final query for debugging
                          print('Applying saved queries: $query');
                        } else {
                          // If no saved queries, apply the current query logic
                          query = originalQuery;
                          print('Applying original query: $query');

                          if (skills != null && skills!.skills!.isNotEmpty) {
                            // Use 'array-contains' for skills filter
                            query = query.where("skills",
                                arrayContains: skills!.skills![0]);
                            print(
                                'Applying skills filter: ${skills!.skills![0]}');
                          }
                          if (qualification != null) {
                            query = query.where(
                              "qualification",
                              isEqualTo: qualification!.qualification,
                            );
                            print(
                                'Applying qualification filter: ${qualification!.qualification}');
                          }

                          // Update the UI
                          setState(() {});
                        }
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
                          itemList.clear();
                          query = originalQuery;
                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Container(
                  height: 100,
                  constraints: BoxConstraints(
                    maxWidth: 600, // Set your desired maximum width here
                  ),
                  child: ListView.builder(
                    itemCount: itemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Candidate? skills =
                          skillsList[index]; // Use skillsList for each item
                      Candidate? qualification = qualificationList[
                          index]; // Use qualificationList for each item

                      return ListTile(
                        title: Row(
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
                                        .map((agentIterable) =>
                                            DropdownMenuItem<Candidate>(
                                              value: agentIterable,
                                              child: Text(
                                                  agentIterable.skills![0]),
                                            ))
                                        .followedBy([
                                      DropdownMenuItem<Candidate>(
                                        value: null,
                                        child: Text(
                                            'Job Classification ${itemList[index]}'),
                                      )
                                    ]).toList(),
                                    onChanged: (item) {
                                      setState(() {
                                        skillsList[index] =
                                            item; // Update skillsList
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 30,
                                      width: 200,
                                      elevation: 2,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
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
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 25,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                                        .map((agentIterable) =>
                                            DropdownMenuItem<Candidate>(
                                              value: agentIterable,
                                              child: Text(
                                                  agentIterable.qualification!),
                                            ))
                                        .followedBy([
                                      DropdownMenuItem<Candidate>(
                                        value: null,
                                        child: Text(
                                            'Qualification Set ${itemList[index]}'),
                                      )
                                    ]).toList(),
                                    onChanged: (item) {
                                      setState(() {
                                        qualificationList[index] =
                                            item; // Update qualificationList
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: 30,
                                      width: 200,
                                      elevation: 2,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 14),
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
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 25,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
