import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:myapplication/model/Question_model.dart';
import 'package:myapplication/viewResult.dart';
import 'package:myapplication/viewResult2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingExerciseID extends StatefulWidget {
  @override
  _ReadingExerciseIDState createState() => _ReadingExerciseIDState();
}

class _ReadingExerciseIDState extends State<ReadingExerciseID> {
  bool _isloading = false;
  int questionId;
  int groupValue;
  int optionId;
  bool isPressed = false;
  int i = 23;
  int total = 24;
  Future<QuestionId> loadQuestion() async {
    final url = Network().link('/api/question/' + i.toString());
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonResponce = response.body;
      QuestionId res = QuestionId.fromJson(json.decode(jsonResponce));
      return res;
    } else
      throw Exception('Failed to load Question');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Set 1"),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.white),
            ),
            // onPressed: () => Navigator.pop(context)
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuestionId>(
                future: loadQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // List<Option> list = snapshot.data.option;
                    Question list = snapshot.data.question;
                    questionId = snapshot.data.question.id;

                    // return ListView.builder(
                    //   itemCount: list.length,
                    //   itemBuilder: (context, index) {
                    // Option option = list[index];
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
                                  style: TextStyle(fontSize: 20)),
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
                        )
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
                  if (i <= total) {
                    setState(() {
                      questionId = questionId;
                      print(questionId);
                      optionId = optionId;
                      print(optionId);
                      i++;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getAns() {}

  Future<Sent> submitAns(int questionId, int optionId) async {
    setState(() {
      _isloading = true;
    });

    // final data = {
    //   "question_id": questionId,
    //   "option_id": optionId,
    // };

    Map<String, List<Map<String, int>>> data = {
      "data": [
        {"question_id": questionId, "option_id": optionId},
      ]
    };

    var url = await Network().link("/api/exercise/1/saveAnswer");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      print("Save success");
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('resultId', json.encode(body['result']['id']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ViewResult2()),
      );
    } else {
      print(response.body);
      print("Save failed");
    }
  }
}

class SubmitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                "Submit the answer",
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
              // Navigator.push(context,
              //     new MaterialPageRoute(builder: (context) => ViewResult()));
              CupertinoAlertDialog(
                title: Text("Submit?"),
                content: Text("Are you sure to submit?"),
                actions: [
                  CupertinoDialogAction(),
                  CupertinoDialogAction(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Sent {
  List<Data> data;

  Sent({this.data});

  Sent.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int questionId;
  int optionId;

  Data({this.questionId, this.optionId});

  Data.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    optionId = json['option_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['option_id'] = this.optionId;
    return data;
  }
}
