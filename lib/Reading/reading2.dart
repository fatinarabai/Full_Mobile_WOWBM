import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/Question_model.dart';
import 'package:myapplication/model/ReadingQuestion_model.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:myapplication/readingQuiz.dart';
import 'package:myapplication/viewResult2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Reading2Page extends StatefulWidget {
  final int id;
  Reading2Page(this.id, {Key key}): super(key: key);

  @override
  _Reading2PageState createState() => _Reading2PageState();
}

class _Reading2PageState extends State<Reading2Page> {

  int questionId;
  // List groupValue;
  int groupValue;
  List optionId=[];
  int newValue;

  Color getColor(Set<MaterialState> states) {
    return Colors.amber;
  }



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
                List<Questions> list = snapshot.data.questions;
                debugPrint("Has Data");
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

                                        while(optionId.length<=questionId){
                                          optionId.add(0);
                                        }
                                        if(optionId[questionId]!=0){
                                          optionId.removeAt(questionId);
                                          optionId.insert(questionId, newValue);
                                        }
                                        else{
                                          optionId.insert(questionId, newValue);
                                        }
                                        print(optionId);

                                        // print(optionId[questionId]);
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
                        submitAns(snapshot.data.questions,optionId);
                        // print(snapshot.data.questions);
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

  Future submitAns(List Q, List Oid) async{

    Map<String, List<dynamic>> data;
    //
    // for(int i=0; i<Q.length; i++) {
    //   print(Q[i].id);

      // data=Q[i].id;
      // data = {
      //   "data": [
      //     {"question_id": Q[i].id, "option_id": Oid[Q[i].id]},
      //   ]
      // };
    // };
    // print(data);

        data={
          "data":Oid
        };


    var url = await Network().link("/api/exercise/"+widget.id.toString()+"/saveAnswerMobile");
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
