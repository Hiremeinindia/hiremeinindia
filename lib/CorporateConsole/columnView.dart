import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/CorporateConsole/viewUser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../User/user.dart';
import '../classes/language_constants.dart';

class ColumnView extends StatefulWidget {
  @override
  _ColumnViewState createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  Widget? child;
  IconData? icon;
  Candidate? verified;
  Candidate? candidate;
  Stream<QuerySnapshot<Map<String, dynamic>>>? _currentStream;
  late Stream<Map<String, dynamic>?> userStream;
  bool scheduledata = false;
  bool expandWork = false;
  bool expandCertificate = false;
  bool expandCourse = false;
  final ScrollController _scrollController = ScrollController();
  bool expandProject = false;
  late Query<Map<String, dynamic>> query;
  final agentsRef = FirebaseFirestore.instance
      .collection("greycollaruser")
      .where('label', isEqualTo: 'Blue');
  final fireStore =
      FirebaseFirestore.instance.collection('greycollaruser').snapshots();

  void initState() {
    query = agentsRef;
    super.initState();
    _currentStream = AllCandidates();
  }

  void _callNumber(String? mobile) async {
    String url = "tel://$mobile";
    print('Mobile Number:$mobile');
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $mobile';
    }
  }

  Future<int> totalCandidatesCount() async {
    int blueCount = await BlueResult();
    int greyCount = await GreyResult();

    return blueCount + greyCount;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> AllCandidates() {
    return FirebaseFirestore.instance.collection("greycollaruser").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> BlueCandidates() {
    return FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('label', isEqualTo: 'Blue')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> GreyCandidates() {
    return FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('label', isEqualTo: 'Grey')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> CuratedCandidates() {
    return FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('labelText', isEqualTo: 'Curated')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> SelectedCandidates() {
    return FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('labelText', isEqualTo: 'Selected')
        .snapshots();
  }

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

  Future<int> CuratedResult() async {
    var query = await FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('labelText', isEqualTo: 'Curated');
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  Future<int> SelectedResult() async {
    var query = await FirebaseFirestore.instance
        .collection("greycollaruser")
        .where('labelText', isEqualTo: 'Selected');
    var snapshot = await query.get();
    var count = snapshot.size;
    return count; // Add this line to return the count
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 170, right: 170),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  _currentStream = AllCandidates();
                });
              },
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
              onTap: () {
                setState(() {
                  _currentStream = BlueCandidates();
                });
              },
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
              onTap: () {
                setState(() {
                  _currentStream = GreyCandidates();
                });
              },
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
                  color: Color.fromARGB(255, 197, 197, 197),
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
            InkWell(
              onTap: () {
                setState(() {
                  _currentStream = CuratedCandidates();
                });
              },
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
                  color: Color.fromARGB(223, 251, 217, 84),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).curatedCandidates,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<int>(
                        future: CuratedResult(),
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
            InkWell(
              onTap: () {
                setState(() {
                  _currentStream = SelectedCandidates();
                });
              },
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
                  color: Color.fromARGB(224, 92, 181, 95),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        translation(context).selectedCandidates,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder<int>(
                        future: SelectedResult(),
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
          ],
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
        height: 550,
        child: SizedBox(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _currentStream, // Use the BlueCandidates query's stream
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(translation(context).nocandidateswereadded));
              } else {
                // Map documents to Candidate objects
                List<Candidate> blueCandidates = snapshot.data!.docs
                    .map((doc) => Candidate.fromSnapshot(doc))
                    .toList();

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
                              columns: CandidateListSource.getColumns(
                                  context), // Pass context here
                              source: CandidateListSource(
                                blueCandidates,
                                context: context,
                                onSelect: (candidate) {
                                  // Show details dialog when a row is selected
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return FullPagePopup(
                                          candidate: candidate);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    ]);
  }
}

class CandidateListSource extends DataTableSource {
  final List<Candidate> candidates;
  final BuildContext context;
  final Function(Candidate) onSelect;

  CandidateListSource(this.candidates,
      {required this.context, required this.onSelect});

  @override
  DataRow? getRow(int index) {
    final e = candidates[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(e.name.toString()),
          onTap: () {
            onSelect(e);
          },
        ),
        DataCell(
          SizedBox(
            width: 27,
            height: 27,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 51, 116, 53),
            ),
          ),
        ),
        DataCell(Text(e.qualification?.toString() ?? 'nill')),
        DataCell(Text(e.skills!.isNotEmpty ? e.skills![0] : '')),
        DataCell(Text(e.skills!.isNotEmpty ? e.skills![1] : '')),
        DataCell(Text(e.selectedOption?.toString() ?? '- - - -')),
        DataCell(Text(e.mobile.toString())),
        DataCell(Text(e.name.toString())),
      ],
    );
  }

  static List<DataColumn> getColumns(BuildContext context) {
    return [
      DataColumn(label: Text(translation(context).candidate)),
      DataColumn(label: Text(translation(context).verified)),
      DataColumn(label: Text(translation(context).qualification)),
      DataColumn(label: Text(translation(context).jobClassification)),
      DataColumn(label: Text(translation(context).jobClassification)),
      DataColumn(label: Text(translation(context).label)),
      DataColumn(label: Text(translation(context).noOfDaysOpen)),
      DataColumn(label: Text(translation(context).cvDocs)),
    ];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => candidates.length;

  @override
  int get selectedRowCount => 0;
}
