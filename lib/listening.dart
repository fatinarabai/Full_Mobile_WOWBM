import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/ListeningQuestion_model.dart';
import 'package:myapplication/viewResult2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:splashscreen/splashscreen.dart';

import 'network_utils/api.dart';


class ListeningPage extends StatefulWidget {
  final int id;
  ListeningPage(this.id);


  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  bool _isLoading = true;
  int questionId;
  // List groupValue;
  int groupValue;
  List optionId=[];
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

  _launchURLBrowser() async {
    const url = 'https://drive.google.com/file/d/1GyDOtirxeY9RQ4Nu1OELLyvwgUjEifiM/preview';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLApp() async {
    const url = 'https://drive.google.com/file/d/1GyDOtirxeY9RQ4Nu1OELLyvwgUjEifiM/preview';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
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
                        // print(audiolink);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  audiolink,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),

                            RaisedButton(
                              color: Colors.amber,
                              onPressed: _launchURLBrowser,
                              child: Text("Open at Browser",
                              style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                            SizedBox(height: 8),
                            RaisedButton(
                              color: Colors.amber,
                              onPressed: _launchURLApp,
                              child: Text("Open at App",
                                style: TextStyle(
                                    color: Colors.white
                                ),),
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



