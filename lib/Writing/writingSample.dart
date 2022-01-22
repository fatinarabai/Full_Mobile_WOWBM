import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapplication/exercise.dart';
import 'package:myapplication/model/WritingSpeakingQuestion_model.dart';
import 'package:myapplication/model/Writing_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/ExerciseQuestion_model.dart';
import '../network_utils/api.dart';

class WritingSamplePage extends StatefulWidget {
  final int qid;
  WritingSamplePage(this.qid);



  @override
  _WritingSamplePageState createState() => _WritingSamplePageState();
}

class _WritingSamplePageState extends State<WritingSamplePage> {
  // bool isLoading = true;
  // int currentIndex = 0;
  // List questions = List();
  // List myAnswers = [];
  // // int i=21;
  // int index = 0;
  // bool isVisible = false;



  Future<WritingResponse> loadQuestionOption() async {
    final url = Network().link('/api/question/' + widget.qid.toString());
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<WritingResponse>(
                  future: loadQuestionOption(),
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
                                // Visibility(
                                //   visible: isVisible,
                                Column(
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
                                             snapshot.data.questionOption[index].text,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  height: 2.5),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context);
                                        },
                                        color: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                // ),
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

