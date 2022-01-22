import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapplication/exercise.dart';
import 'package:myapplication/model/Writing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/ExerciseQuestion_model.dart';
import 'network_utils/api.dart';

class WritingPage extends StatefulWidget {
  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  bool isLoading = true;
  int currentIndex = 0;
  List questions = List();
  List myAnswers = [];
  int i = 2;
  int index = 0;
  bool isVisible = false;
  Future<WritingResponse> loadQuestion() async {
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
      WritingResponse res = WritingResponse.fromJson(json.decode(jsonResponce));
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
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  i++;
                });
                if (i >= 5) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => FinishedExercise()));
                }
                //navigate to page where can choose to back to dashboard or ulang balik.

                print("moving to next page");
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<WritingResponse>(
                future: loadQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Question list = snapshot.data.question;
                    List<QuestionOption> lists = snapshot.data.questionOption;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            snapshot.data.question.questionText,
                            // "Why do we need to save the turtle? Give 2 reasons.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Sample Answer",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                    // });
                  } else if (snapshot.hasError) {
                    debugPrint("${snapshot.error}");
                    return Text("${snapshot.error}",
                        style: TextStyle(fontSize: 15));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Expanded(
                child: FutureBuilder<WritingResponse>(
              future: loadQuestion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QuestionOption> lists = snapshot.data.questionOption;
                  return ListView.builder(
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Visibility(
                              visible: isVisible,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: new SingleChildScrollView(
                                      // width: 350,
                                      // height: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          snapshot
                                              .data.questionOption[index].text,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              height: 2.5),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                } else if (snapshot.hasError) {
                  debugPrint("${snapshot.error}");
                  return Text("${snapshot.error}",
                      style: TextStyle(fontSize: 15));
                }

                return Center(child: CircularProgressIndicator());
              },
            ))
          ],
        ),
      ),
    );
  }
}

class FinishedExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    "Take Exercise Again",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => WritingPage()));
                },
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    "Back to Dashboard",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ExercisePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
