import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/Question_model.dart';
import 'package:myapplication/model/ReadingQuestion_model.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:myapplication/readingQuiz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReadingPage extends StatefulWidget {
  final int id;
  ReadingPage(this.id, {Key key}): super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {

  int questionId;
  int groupValue;
  int optionId;

  Future<ReadingQuestion> getQuestion() async {
    final url = Network().link('/api/exercise/' + widget.id.toString()+"/questions");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponce = response.body;
      print(response.body);
      ReadingQuestion res = ReadingQuestion.fromJson(json.decode(jsonResponce));
      return res;
    } else
      throw Exception('Failed to load Question');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Reading Exercise"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Container(
              child: FutureBuilder<ReadingQuestion>(
                future: getQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // List<Questions> list = snapshot.data.questions;
                    List list = snapshot.data.questions;
                    debugPrint("Has Data");
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        int id= snapshot.data.questions[index].id;
                        return Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Container(
                            //   // width: double.infinity,
                            //   child: InkWell(
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           new MaterialPageRoute(
                            //               builder: (context) => ReadingQuizPage(id)));
                            //     },
                            //     child: Text(
                            //       "Answer the Quiz",
                            //       // snapshot.data.result[index].meaning,
                            //       // "${snapshot.data[index]['meaning']}",
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ),
                            // ),


                            Container(
                              // width: double.infinity,
                              child: Text(
                                // snapshot.data.question.questionText,
                                snapshot.data.questions[index].questionText,
                                // "Which is the fastest animal on the land?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.w600),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                // width: 200,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: snapshot.data.questions[0].id,
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          groupValue = value;
                                          setState(() {
                                            questionId = questionId;
                                            print(questionId);
                                            optionId = groupValue;
                                            print(optionId);
                                          });
                                        }),
                                    Text(snapshot.data.questions[0].options[0].option,
                                        style: TextStyle(fontSize: 19)),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                // width: 200,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: snapshot.data.questions[1].id,
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          groupValue = value;
                                          setState(() {
                                            questionId = questionId;
                                            print(questionId);
                                            optionId = groupValue;
                                            print(optionId);
                                          });
                                        }),
                                    Text(snapshot.data.questions[1].options[1].option,
                                        style: TextStyle(fontSize: 19)),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                // width: 200,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: snapshot.data.questions[2].id,
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          groupValue = value;
                                          setState(() {
                                            questionId = questionId;
                                            print(questionId);
                                            optionId = groupValue;
                                            print(optionId);
                                          });
                                        }),
                                    Text(snapshot.data.questions[2].options[2].option,
                                        style: TextStyle(fontSize: 19)),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                // width: 200,
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: snapshot.data.questions[3].id,
                                        groupValue: groupValue,
                                        onChanged: (value) {
                                          groupValue = value;
                                          setState(() {
                                            questionId = questionId;
                                            print(questionId);
                                            optionId = groupValue;
                                            print(optionId);
                                          });
                                        }),
                                    Text(snapshot.data.questions[3].options[3].option,
                                        style: TextStyle(fontSize: 19)),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        );
                      },
                    );

                  } else {
                    debugPrint("Loading to fetch data");
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
        ),
      ),
    );
  }
}
