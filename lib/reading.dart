import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/Question_model.dart';
import 'package:myapplication/model/ReadingQuestion_model.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReadingPage extends StatefulWidget {
  final int id;
  ReadingPage(this.id, {Key key}): super(key: key);

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  // int questionId;
  // int groupValue;
  // int optionId;

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
        title: Text("Set 1"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<ReadingQuestion>(
              future: getQuestion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Questions> list = snapshot.data.questions;
                  debugPrint("Has Data");
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      // List<Options> listopt = snapshot.data.questions[index].options;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            // width: double.infinity,
                            child: Text(
                              // snapshot.data.question.questionText,
                             list[1].questionText,
                              // "Which is the fastest animal on the land?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w600),
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
          ],
        ),
      ),
    );
  }
}
