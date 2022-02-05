import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapplication/exercise.dart';
import 'package:myapplication/model/WritingSpeakingQuestion_model.dart';
import 'package:myapplication/Speaking/speakingSample.dart';
import 'package:myapplication/Speaking/speakingSample2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network_utils/api.dart';

class SpeakingPage extends StatefulWidget {
  final int id;
  SpeakingPage(this.id);

  @override
  _SpeakingPageState createState() => _SpeakingPageState();
}

class _SpeakingPageState extends State<SpeakingPage> {
  bool isLoading = true;
  int currentIndex = 0;
  List questions = List();
  List myAnswers = [];
  // int i=21;
  int index = 0;
  bool isVisible = false;

  Future<WritingQuestion> loadQuestion() async{
    final url = Network().link('/api/exercise/'+ widget.id.toString()+'/questions');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode==200){
      var jsonResponce = response.body;
      WritingQuestion res = WritingQuestion.fromJson(json.decode(jsonResponce));
      return res;
    }
    else
      throw Exception('Failed to load Question');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Speaking Exercise"),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton(
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // setState(() {
                //   i++;
                // });
                // if (i >= 5) {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => FinishedExercise()));
                // }
                //navigate to page where can choose to back to dashboard or ulang balik.

                print("moving to next page");
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<WritingQuestion>(
                future: loadQuestion(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Questions> list = snapshot.data.questions;
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        int Qid = snapshot.data.questions[index].id;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                child: Text(
                                  snapshot.data.questions[index].questionText,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.w600, height: 1.5),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(builder: (context) => SpeakingSample2Page(Qid)),
                                  // setState(() {
                                  //   isVisible = !isVisible;
                                  // }
                                );
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
                      },
                    );
                  } else if (snapshot.hasError) {
                    debugPrint("${snapshot.error}");
                    return Text("${snapshot.error}",
                        style: TextStyle(fontSize: 15));
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
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
                  Navigator.pop(
                      context);
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
