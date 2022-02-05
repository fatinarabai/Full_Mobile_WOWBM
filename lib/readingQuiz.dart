import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/ReadingQuiz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'network_utils/api.dart';

class ReadingQuizPage extends StatefulWidget {
  final int id;
  ReadingQuizPage(this.id);

  @override
  _ReadingQuizPageState createState() => _ReadingQuizPageState();
}

class _ReadingQuizPageState extends State<ReadingQuizPage> {
  int questionId;
  int groupValue;
  int optionId;

  Future<ReadingQuiz> getQuestion() async {
    final url = Network().link('/api/question/'+ widget.id.toString());
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
      ReadingQuiz res = ReadingQuiz.fromJson(json.decode(jsonResponce));
      return res;
    } else
      throw Exception('Failed to load Question');
  }

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
          children: [
            Expanded(
              child: FutureBuilder<ReadingQuiz>(
                future: getQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // List<Option> list = snapshot.data.option;
                    List list = snapshot.data.questionOption;
                    // return ListView.builder(
                    //   itemCount: list.length,
                    //   itemBuilder: (context, index) {
                    //     String image=snapshot.data.questionOption[index].image;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                          Container(
                          width: double.infinity,
                          child: Text(
                            snapshot.data.question.questionText,
                            // "Which is the fastest animal on the land?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                            Container(
                              width: 150,
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                      value: snapshot.data.questionOption[0].id,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        groupValue = value;
                                        setState(() {
                                          optionId = value;
                                        });
                                      }),
                                  Text(snapshot.data.questionOption[0].option,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                      value: snapshot.data.questionOption[1].id,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        groupValue = value;
                                        setState(() {
                                          optionId = value;
                                        });
                                      }),
                                  Text(snapshot.data.questionOption[1].option,
                                      style: TextStyle(fontSize: 20))
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                      value: snapshot.data.questionOption[2].id,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        groupValue = value;
                                        setState(() {
                                          optionId = value;
                                        });
                                      }),
                                  Text(snapshot.data.questionOption[2].option,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Row(
                                children: <Widget>[
                                  Radio(
                                      value: snapshot.data.questionOption[3].id,
                                      groupValue: groupValue,
                                      onChanged: (value) {
                                        groupValue = value;
                                        setState(() {
                                          optionId = value;
                                        });
                                      }),
                                  Text(snapshot.data.questionOption[3].option,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),

                        ],
                        );
                    // },
                    // );
                  } else if (snapshot.hasError) {
                    debugPrint("${snapshot.error}");
                    return Text("${snapshot.error}",
                        style: TextStyle(fontSize: 15));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: FlatButton(
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    'Next',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                color: Colors.orange,
                disabledColor: Colors.grey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {
                  // if (i <= total) {
                  //   setState(() {
                  //     questionId = questionId;
                  //     print(questionId);
                  //     optionId = optionId;
                  //     print(optionId);
                  //     i++;
                  //   });
                  // }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
