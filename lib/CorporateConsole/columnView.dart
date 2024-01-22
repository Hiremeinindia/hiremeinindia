import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'corporateconsole.dart';
import '../Models/candidated.dart';
import '../classes/language_constants.dart';
import '../widgets/customcard.dart';

class ColumnView extends StatefulWidget {
  @override
  _ColumnViewState createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  Widget? child;
  IconData? icon;
  void initState() {
    query = agentsRef;
    super.initState();
  }

  final agentsRef = FirebaseFirestore.instance.collection("users");
  late Query<Map<String, dynamic>> query;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 170, right: 170),
        child: Row(
          children: [
            Expanded(
              child: CustomCard(
                color: Color.fromARGB(255, 153, 51, 49),
                title1: translation(context).noOfCandidates,
                title2: '200',
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Expanded(
              child: CustomCard(
                color: Color.fromARGB(255, 14, 75, 206),
                title1: translation(context).blueColler,
                title2: '100',
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Expanded(
              child: CustomCard(
                color: Color.fromARGB(228, 178, 186, 178),
                title1: translation(context).greyColler,
                title2: '100',
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Expanded(
              child: CustomCard(
                color: Color.fromARGB(223, 251, 217, 84),
                title1: translation(context).curatedCandidates,
                title2: '50',
              ),
            ),
            SizedBox(
              width: 60,
            ),
            Expanded(
              child: CustomCard(
                color: Color.fromARGB(224, 92, 181, 95),
                title1: translation(context).selectedCandidates,
                title2: '50',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CorporateConsole()),
                  );
                },
              ),
            )
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
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 2,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(1),
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                            ),
                            child: SizedBox(
                              // height: double.maxFinite,
                              width: double.maxFinite,
                              child: PaginatedDataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 104, 104, 208)),
                                showFirstLastButtons: true,
                                rowsPerPage: 20,
                                // (Get.height ~/ kMinInteractiveDimension) -
                                //     4,
                                columns: CandidateListSource.getColumns(),

                                source: CandidateListSource(candidates,
                                    context: context),
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
                child: SelectableText(snapshot.data.toString()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )
    ]));
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
        DataCell(Text(e.mobile.toString())),
        DataCell(Text(e.email.toString())),
        DataCell(Text(e.name.toString())),
        DataCell(Text(e.name.toString())),
        DataCell(Text(e.name.toString())),
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
