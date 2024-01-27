import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/homepage.dart';

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

  late Query<Map<String, dynamic>> query;
  Future<int> totalCandidatesCount() async {
    int blueCount = await BlueResult();
    int greyCount = await GreyResult();

    return blueCount + greyCount;
  }

  final fireStore =
      FirebaseFirestore.instance.collection('greycollaruser').snapshots();

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

  final agentsRef = FirebaseFirestore.instance.collection("greycollaruser");

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 170, right: 170),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 140, 138, 138),
                      spreadRadius: 0.5, //spread radius
                      blurRadius: 4, // blu
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromARGB(255, 153, 51, 49),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).noOfCandidates,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<int>(
                        future: totalCandidatesCount(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            int totalDocCount = snapshot.data ?? 0;
                            return Text(
                              ' $totalDocCount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 140, 138, 138),
                      spreadRadius: 0.5, //spread radius
                      blurRadius: 4, // blu
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.indigo.shade900,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).blueColler,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                              '$docCount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 140, 138, 138),
                      spreadRadius: 0.5, //spread radius
                      blurRadius: 4, // blu
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.indigo.shade900,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).greyColler,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
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
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
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
                    MaterialPageRoute(builder: (context) => HomePage()),
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
                    child: Text("No staffs are added yet"),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            // height: double.maxFinite,
                            width: double.maxFinite,
                            child: PaginatedDataTable(
                              showFirstLastButtons: true,
                              rowsPerPage: 20,
                              // (Get.height ~/ kMinInteractiveDimension) -
                              //     4,
                              columns: CandidateListSource.getColumns(),
                              source: CandidateListSource(candidates,
                                  context: context),
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
        DataCell(Text(e.qualification?.toString() ?? 'nill')),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![0] : ''),
        ),
        DataCell(
          Text(e.selectedSkills!.isNotEmpty ? e.selectedSkills![1] : ''),
        ),
        DataCell(Text(e.selectedOption?.toString() ?? '- - - -')),
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
