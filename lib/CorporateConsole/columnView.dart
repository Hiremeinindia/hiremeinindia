import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/homepage.dart';

import '../User/user.dart';
import '../classes/language_constants.dart';
import '../widgets/custombutton.dart';
import '../widgets/customcard.dart';
import '../widgets/customdropdown.dart';

class ColumnView extends StatefulWidget {
  @override
  _ColumnViewState createState() => _ColumnViewState();
}

class _ColumnViewState extends State<ColumnView> {
  Widget? child;
  IconData? icon;
  Candidate? verified;
  bool isExpanded = false;
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
                    child: Text("No users are added yet"),
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
                              source: CandidateListSource(
                                candidates,
                                context: context,
                                onSelect: (candidate) {
                                  // Show details dialog when a row is selected
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        // The Dialog widget provides a full-page overlay
                                        child: Container(
                                          height: 1000,
                                          width: 1500,
                                          child: Padding(
                                            padding: const EdgeInsets.all(30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      TextButton.icon(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_back_ios_new_outlined,
                                                            size: 15,
                                                            color: Colors.indigo
                                                                .shade900,
                                                          ),
                                                          label: Text(
                                                            'Back',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .indigo
                                                                  .shade900,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Status',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .indigo
                                                                    .shade900,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            ),
                                                            SizedBox(
                                                              height: 30,
                                                              width: 125,
                                                              child:
                                                                  CustomDropDown<
                                                                      Candidate?>(
                                                                value: verified,
                                                                onChanged:
                                                                    (Candidate) {},
                                                                items: [
                                                                  DropdownMenuItem<
                                                                      Candidate?>(
                                                                    value: Candidate(
                                                                        verify:
                                                                            'awaiting_response'),
                                                                    child: Text(
                                                                        'Awaiting response'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      Candidate?>(
                                                                    value: Candidate(
                                                                        verify:
                                                                            'interview_scheduled'),
                                                                    child: Text(
                                                                        'Interview Scheduled'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      Candidate?>(
                                                                    value: Candidate(
                                                                        verify:
                                                                            'curated'),
                                                                    child: Text(
                                                                        'Curated'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      Candidate?>(
                                                                    value: Candidate(
                                                                        verify:
                                                                            'rejected'),
                                                                    child: Text(
                                                                        'Rejected'),
                                                                  ),
                                                                  DropdownMenuItem<
                                                                      Candidate?>(
                                                                    value: Candidate(
                                                                        verify:
                                                                            'hired'),
                                                                    child: Text(
                                                                        'Hired'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            CustomRectButton(
                                                              onPressed: () {},
                                                              child: ImageIcon(
                                                                  AssetImage(
                                                                      "table.png"),
                                                                  size: 40,
                                                                  color: Colors
                                                                      .indigo
                                                                      .shade900),
                                                              colors: Colors
                                                                  .green
                                                                  .shade200,
                                                              bottomleft: Radius
                                                                  .circular(5),
                                                              topleft: Radius
                                                                  .circular(5),
                                                              bottomright:
                                                                  Radius.zero,
                                                              topright:
                                                                  Radius.zero,
                                                            ),
                                                            CustomRectButton(
                                                              onPressed: () {},
                                                              child: ImageIcon(
                                                                  AssetImage(
                                                                      "table.png"),
                                                                  size: 30,
                                                                  color: Colors
                                                                      .indigo
                                                                      .shade900),
                                                              colors: Colors
                                                                  .grey
                                                                  .shade200,
                                                              bottomleft:
                                                                  Radius.zero,
                                                              topleft:
                                                                  Radius.zero,
                                                              bottomright:
                                                                  Radius.zero,
                                                              topright:
                                                                  Radius.zero,
                                                            ),
                                                            CustomRectButton(
                                                              onPressed: () {},
                                                              child: ImageIcon(
                                                                  AssetImage(
                                                                      "table.png"),
                                                                  size: 50,
                                                                  color: Colors
                                                                      .indigo
                                                                      .shade900),
                                                              colors: Colors
                                                                  .red.shade200,
                                                              bottomleft:
                                                                  Radius.zero,
                                                              topleft:
                                                                  Radius.zero,
                                                              bottomright:
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                              topright: Radius
                                                                  .circular(5),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30.0,
                                                              right: 30,
                                                              bottom: 20),
                                                      child: Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          SizedBox(
                                                            height: 200,
                                                          ),
                                                          Container(
                                                            width: 300,
                                                            height: 700,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  offset: Offset(
                                                                      0.0,
                                                                      1.0), //(x,y)
                                                                  blurRadius:
                                                                      6.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      30.0),
                                                              child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          140,
                                                                    ),
                                                                    Text(
                                                                      'Designation about the candidate',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          color: Colors
                                                                              .indigo
                                                                              .shade900,
                                                                          height:
                                                                              0),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          40,
                                                                    ),
                                                                    Text(
                                                                      'Skills',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .indigo
                                                                            .shade900,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              '${candidate.skills![0]}',
                                                                              style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: const Color(0xFF000000), style: BorderStyle.solid), //Border.all
                                                                              /*** The BorderRadius widget  is here ***/
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(15),
                                                                              ), //BorderRadius.all
                                                                            ), //BoxDecoration
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              '${candidate.skills![1]}',
                                                                              style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: const Color(0xFF000000), style: BorderStyle.solid), //Border.all
                                                                              /*** The BorderRadius widget  is here ***/
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(15),
                                                                              ), //BorderRadius.all
                                                                            ), //BoxDecoration
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              '${candidate.workins![0] ?? '- - -'}',
                                                                              style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: const Color(0xFF000000), style: BorderStyle.solid), //Border.all
                                                                              /*** The BorderRadius widget  is here ***/
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(15),
                                                                              ), //BorderRadius.all
                                                                            ), //BoxDecoration
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              25,
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.all(3),
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: const Color(0xFF000000), style: BorderStyle.solid), //Border.all
                                                                              /*** The BorderRadius widget  is here ***/
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(15),
                                                                              ), //BorderRadius.all
                                                                            ), //BoxDecoration
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          60,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        minimumSize: const Size
                                                                            .fromHeight(
                                                                            45),
                                                                        fixedSize: const Size
                                                                            .fromWidth(
                                                                            double.infinity),
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            113,
                                                                            46,
                                                                            168),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5), // Adjust border radius as needed
                                                                        ),
                                                                      ),
                                                                      child: Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.calendar_month_outlined,
                                                                              size: 25,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              'Schedule an interview',
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                    ),
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        minimumSize: const Size
                                                                            .fromHeight(
                                                                            45),
                                                                        fixedSize: const Size
                                                                            .fromWidth(
                                                                            double.infinity),
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            58,
                                                                            206,
                                                                            63),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5), // Adjust border radius as needed
                                                                        ),
                                                                      ),
                                                                      child: Row(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.call_rounded,
                                                                              size: 25,
                                                                              color: Colors.white,
                                                                            ),
                                                                            Text(
                                                                              'Make a call',
                                                                              style: TextStyle(
                                                                                fontSize: 15,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                          ]),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 200,
                                                          ),
                                                          Positioned(
                                                            bottom: 570,
                                                            left: 80,
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundColor: Colors
                                                                        .indigo
                                                                        .shade900,
                                                                    maxRadius:
                                                                        68,
                                                                    minRadius:
                                                                        67.5,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      maxRadius:
                                                                          66,
                                                                      minRadius:
                                                                          60,
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundImage:
                                                                            AssetImage('imguser.jpg'),
                                                                        maxRadius:
                                                                            59,
                                                                        minRadius:
                                                                            56,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${candidate.name}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .indigo
                                                                          .shade900,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '${candidate.skills![0]}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .indigo
                                                                            .shade900,
                                                                        height:
                                                                            0),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Container(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                //basic detail container opening
                                                                width: 800,
                                                                height: 300,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      offset: Offset(
                                                                          0.0,
                                                                          1.0), //(x,y)
                                                                      blurRadius:
                                                                          6.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          800,
                                                                      height:
                                                                          50,
                                                                      decoration: const BoxDecoration(
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              146,
                                                                              176,
                                                                              226),
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(5),
                                                                              topRight: Radius.circular(5))),
                                                                      child:
                                                                          Text(
                                                                        'Basic Details',
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors
                                                                              .indigo
                                                                              .shade900,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              10,
                                                                          left:
                                                                              20),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          20.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Age',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '22',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Text(
                                                                                'Work Experience',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '8 months',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Contact Number',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${candidate.mobile}',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Text(
                                                                                'CTC',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '2.3 Lakh',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                'Email address',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${candidate.email}',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 20,
                                                                              ),
                                                                              Text(
                                                                                'Location',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  color: Colors.indigo.shade900,
                                                                                  fontWeight: FontWeight.bold,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${candidate.address}',
                                                                                style: TextStyle(fontSize: 15, color: Colors.indigo.shade900, height: 0),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          20.0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                230,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {},
                                                                              style: ElevatedButton.styleFrom(
                                                                                minimumSize: const Size.fromHeight(45),
                                                                                fixedSize: const Size.fromWidth(double.infinity),
                                                                                backgroundColor: Colors.indigo.shade900,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                                                                                ),
                                                                              ),
                                                                              child: Row(children: [
                                                                                Icon(
                                                                                  Icons.download,
                                                                                  size: 25,
                                                                                  color: Colors.white,
                                                                                ),
                                                                                Text(
                                                                                  'Download CV',
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                30,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                230,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {},
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: Colors.indigo.shade900,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(5), // Adjust border radius as needed
                                                                                ),
                                                                              ),
                                                                              child: Row(children: [
                                                                                Icon(
                                                                                  Icons.download,
                                                                                  size: 25,
                                                                                  color: Colors.white,
                                                                                ),
                                                                                Text(
                                                                                  'Download Documents',
                                                                                  style: TextStyle(
                                                                                    fontSize: 15,
                                                                                    color: Colors.white,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ]),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ), //basic detail container closing
                                                              SizedBox(
                                                                height: 50,
                                                              ),
                                                              Container(
                                                                  width: 800,
                                                                  height:
                                                                      isExpanded
                                                                          ? 300
                                                                          : 50,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    color: Colors
                                                                        .amber,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey,
                                                                        offset: Offset(
                                                                            0.0,
                                                                            1.0), //(x,y)
                                                                        blurRadius:
                                                                            6.0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      AnimatedContainer(
                                                                        duration:
                                                                            Duration(microseconds: 500),
                                                                        width:
                                                                            800,
                                                                        height:
                                                                            50,
                                                                        decoration: const BoxDecoration(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                146,
                                                                                176,
                                                                                226),
                                                                            borderRadius:
                                                                                BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Work Experience',
                                                                              style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: Colors.indigo.shade900,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                              hoverColor: Colors.transparent,
                                                                              icon: Icon(Icons.arrow_drop_down_circle_rounded),
                                                                              iconSize: 30,
                                                                              color: Colors.indigo.shade900,
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  isExpanded = !isExpanded;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                10,
                                                                            left:
                                                                                20),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ]),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 16.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
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
  final Function(Candidate) onSelect;
  CandidateListSource(this.candidates,
      {required this.context, required this.onSelect});

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    final e = candidates[(index)];

    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text((index + 1).toString())),
        DataCell(
          Text(e.name.toString()),
          onTap: () {
            onSelect(e);
          },
        ),
        DataCell(SizedBox(
          width: 27,
          height: 27,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 51, 116, 53),
          ),
        )),
        DataCell(Text(e.qualification?.toString() ?? 'nill')),
        DataCell(
          Text(e.skills!.isNotEmpty ? e.skills![0] : ''),
        ),
        DataCell(
          Text(e.skills!.isNotEmpty ? e.skills![1] : ''),
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
