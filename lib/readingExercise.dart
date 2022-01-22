import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model/ReadingExerciseSet_model.dart';
import 'network_utils/api.dart';

class ReadingSetPage extends StatefulWidget {
  @override
  _ReadingSetPageState createState() => _ReadingSetPageState();
}

class _ReadingSetPageState extends State<ReadingSetPage> {
  String name;

  // getExerciseId() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   // final ExerciseId = jsonDecode(localStorage.getString('ExerciseId'));
  //   final exerciseName = localStorage.getString('exercise_id');
  //
  //   if (exerciseName != null) {
  //     setState(() {
  //       name = exerciseName;
  //       debugPrint("Can collect data");
  //     });
  //   } else
  //     throw Exception("Cannot get info");
  // }

  Future<ReadingExercise> getReadingList() async {
    final url = Network().link("/api/exerciselist/1");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = response.body;
      ReadingExercise res = ReadingExercise.fromJson(json.decode(jsonResponse));
      return res;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ReadingSetPage()));
    } else
      throw Exception('Failed to load Exercise List');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Sets of Reading Exercise"),
        backgroundColor: Colors.orange,
      ),
      // body: Center(
      //   child: Padding(
      //     padding: const EdgeInsets.only(
      //         top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
      //     child: Center(
      //       child: Wrap(
      //         spacing: 10.0,
      //         runSpacing: 10.0,
      //         children: <Widget>[
      //           SizedBox(
      //             width: 350.0,
      //             height: 90.0,
      //             child: GestureDetector(
      //               onTap: () {
      //                 // Navigator.push(
      //                 //     context,
      //                 //     MaterialPageRoute(
      //                 //         builder: (context) => VocabAdminPage()));
      //               },
      //               child: Card(
      //                 // color: Color.fromARGB(255,21, 21, 21),
      //                 color: Colors.orangeAccent,
      //                 elevation: 2.0,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(8.0)),
      //
      //                 child: Center(
      //                     child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Center(
      //                     child: Text(
      //                       "Reading set $name",
      //                       textAlign: TextAlign.center,
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 19,
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: 350.0,
      //             height: 90.0,
      //             child: GestureDetector(
      //               onTap: () {
      //                 // Navigator.push(
      //                 //     context,
      //                 //     MaterialPageRoute(
      //                 //         builder: (context) => VocabUserPage()));
      //               },
      //               child: Card(
      //                 color: Colors.orangeAccent,
      //                 elevation: 2.0,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(8.0)),
      //                 child: Center(
      //                     child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Center(
      //                     child: Text(
      //                       "Extra Own Vocabulary",
      //                       textAlign: TextAlign.center,
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 19,
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // )

      // this the Future

      // body: Center(
      //   child: Center(
      //     child: FutureBuilder<ReadingExercise>(
      //       future: getReadingList(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return Center(
      //             child: Padding(
      //               padding: const EdgeInsets.only(
      //                   top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
      //               child: Center(
      //                 child: Wrap(
      //                   spacing: 10.0,
      //                   runSpacing: 10.0,
      //                   children: <Widget>[
      //                     SizedBox(
      //                       width: 350.0,
      //                       height: 90.0,
      //                       child: GestureDetector(
      //                         onTap: () {
      //                           // Navigator.push(
      //                           //     context,
      //                           //     MaterialPageRoute(
      //                           //         builder: (context) => VocabAdminPage()));
      //                         },
      //                         child: Card(
      //                           // color: Color.fromARGB(255,21, 21, 21),
      //                           color: Colors.orangeAccent,
      //                           elevation: 2.0,
      //                           shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(8.0)),
      //
      //                           child: Center(
      //                               child: Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Center(
      //                               child: Text(
      //                                 snapshot.data.result.exerciseName,
      //                                 textAlign: TextAlign.center,
      //                                 style: TextStyle(
      //                                   fontWeight: FontWeight.w600,
      //                                   fontSize: 19,
      //                                 ),
      //                               ),
      //                             ),
      //                           )),
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       width: 350.0,
      //                       height: 90.0,
      //                       child: GestureDetector(
      //                         onTap: () {
      //                           int id = snapshot.data.result.id;
      //                         },
      //                         child: Card(
      //                           color: Colors.orangeAccent,
      //                           elevation: 2.0,
      //                           shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(8.0)),
      //                           child: Center(
      //                               child: Padding(
      //                             padding: const EdgeInsets.all(8.0),
      //                             child: Center(
      //                               child: Text(
      //                                 snapshot.data.result.exerciseName,
      //                                 textAlign: TextAlign.center,
      //                                 style: TextStyle(
      //                                   fontWeight: FontWeight.w600,
      //                                   fontSize: 19,
      //                                 ),
      //                               ),
      //                             ),
      //                           )),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           );
      //         } else {
      //           debugPrint("Loading to fetch data");
      //           return Center(child: CircularProgressIndicator());
      //         }
      //       },
      //     ),
      //   ),
      // )
    );
  }
}
