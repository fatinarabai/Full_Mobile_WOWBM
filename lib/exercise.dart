import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:myapplication/reading.dart';
import 'package:myapplication/readingExercise.dart';
import 'package:myapplication/reading_id.dart';
import 'package:myapplication/writing.dart';
import 'package:myapplication/reading_1.dart';
import 'package:myapplication/try.dart';
import 'package:myapplication/model/ReadingExerciseSet_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Exercises"),
        backgroundColor: Color(0xffff9800),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Center(
                child: Text(
                  "4 type of exercises",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
              child: Center(
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: <Widget>[
                    SizedBox(
                      width: 350.0,
                      height: 90.0,
                      child: GestureDetector(
                        onTap: () {
                          // ReadingList();
                          // final url =
                          //     Network().link('/api/exercise/1/questions');
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReadingPage(url)));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReadingSetPage()));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReadingPage2()));
                        },
                        child: Card(
                          // color: Color.fromARGB(255,21, 21, 21),
                          color: Colors.orangeAccent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),

                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Reading Exercise\n-Text with MCQs-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350.0,
                      height: 90.0,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReadingExercise()));
                        },
                        child: Card(
                          color: Colors.orangeAccent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Listening Exercise\n-Voice Recording with MCQs-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350.0,
                      height: 90.0,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => ReadingPage2()));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WritingPage()));
                        },
                        child: Card(
                          color: Colors.orangeAccent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Writing\n-Text with Subjective Questions-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 350.0,
                      height: 90.0,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => WritingPage()));
                        },
                        child: Card(
                          color: Colors.orangeAccent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Speaking\n-Video Recording-",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void ReadingList() async {
  //   final url = Network().link("/api/exerciselist/1");
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   final token = jsonDecode(localStorage.getString('token'));
  //   http.Response response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   // var body = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     final data = jsonDecode(response.body) as Map<String, dynamic>;
  //     for (var exercise in data['result']) {
  //       if (exercise['exercise_name'] == 'Reading Set 1') {
  //         SharedPreferences localStorage =
  //             await SharedPreferences.getInstance();
  //         localStorage.setInt('exercise_id', exercise);
  //       }
  //     }
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => ReadingSetPage()));
  //   } else
  //     throw Exception('Failed to load Vocabulary');
  // }
}
