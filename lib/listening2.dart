import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/ListeningQuestion_model.dart';
import 'package:myapplication/viewResult2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';


import 'network_utils/api.dart';

const url = 'https://drive.google.com/file/d/1GyDOtirxeY9RQ4Nu1OELLyvwgUjEifiM/preview';

class Listening2Page extends StatefulWidget {
  final int id;
  Listening2Page(this.id);


  @override
  _Listening2PageState createState() => _Listening2PageState();
}

class _Listening2PageState extends State<Listening2Page> {
  bool _isLoading = true;
  int questionId;
  int groupValue;
  int optionId;
  int newValue;

  Future<ListeningQuestion> loadQuestion() async {
    final url = Network().link(
        '/api/exercise/' + widget.id.toString() + '/questions');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var jsonResponce = response.body;
      ListeningQuestion res = ListeningQuestion.fromJson(
          json.decode(jsonResponce));
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
        title: Text("Listening Exercise"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: FutureBuilder<ListeningQuestion>(
                    future: loadQuestion(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String audiolink = snapshot.data.exercise.audioLink;
                        String audioId=audiolink.substring(32);
                        String finalId=audioId.substring(0,33);
                        print(finalId);
                        String drivelink="https://drive.google.com/uc?export=view&id="+finalId;
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  drivelink,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),

                          ],
                        );

                      }
                      else if (snapshot.hasError) {
                        debugPrint("${snapshot.error}");
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 15));
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )),
              SizedBox(height: 10),
              Container(
                child: Expanded(
                    child: FutureBuilder<ListeningQuestion>(
                      future: loadQuestion(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Questions> list = snapshot.data.questions;
                          return ListView(
                            children: [
                              for(int i=0; i<list.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data.questions[i].questionText,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 20.0, fontWeight: FontWeight.w600),
                                      ),
                                      for(int j=0; j<snapshot.data.questions[i].options.length;j++)
                                        Row(
                                          children: [
                                            Radio(
                                              fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                                              value: snapshot.data.questions[i].options[j].id,
                                              groupValue: newValue,
                                              onChanged: (value){
                                                newValue=value;
                                                setState(() {
                                                  questionId = snapshot.data.questions[i].id;
                                                  print(questionId);
                                                  optionId = newValue;
                                                  print(optionId);
                                                });
                                              },
                                            ),
                                            Text(snapshot.data.questions[i].options[j].option,
                                                style: TextStyle(fontSize: 19)),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              SizedBox(height: 10),
                              FlatButton(
                                onPressed: () {
                                  submitAns(questionId,optionId);
                                },
                                color: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],

                          );

                        }
                        else if (snapshot.hasError) {
                          debugPrint("${snapshot.error}");
                          return Text("${snapshot.error}",
                              style: TextStyle(fontSize: 15));
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Sent> submitAns(int Qid, int Oid) async{

    Map<String, List<Map<String, int>>> data = {
      "data": [
        {"question_id": questionId, "option_id": optionId},
      ]
    };

    var url = await Network().link("/api/exercise/"+widget.id.toString()+"/saveAnswer");
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



