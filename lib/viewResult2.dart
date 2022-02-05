import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/homepage.dart';
import 'package:myapplication/model/Result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import 'network_utils/api.dart';

class ViewResult2 extends StatefulWidget {


  @override
  _ViewResult2State createState() => _ViewResult2State();
}

class _ViewResult2State extends State<ViewResult2> {

  // String id;
  // @override
  // void initState() {
  //   _loadUserData();
  //   super.initState();
  // }
  //
  // _loadUserData() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var user = jsonDecode(localStorage.getString('resultId'));
  //
  //   if (user != null) {
  //     setState(() {
  //       id = user['id'];
  //     });
  //   }
  // }

  Future<ResponseResult> getResult() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final resultId = jsonDecode(localStorage.getString('resultId'));
    final url = Network().link('/api/attempt/$resultId/result');
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print('token: $token');
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = response.body;
      ResponseResult res = ResponseResult.fromJson(json.decode(jsonResponse));
      return res;
    } else
      throw Exception('Failed to load User Profile');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Results"),
        backgroundColor: Color(0xffff9800),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: FutureBuilder<ResponseResult>(
            future: getResult(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ResponseResult> list =
                    snapshot.data.result.answer.cast<ResponseResult>();
                String date = snapshot.data.result.createdAt;
                // var now = new DateTime.now();
                // var formatter = new DateFormat('EEEEEEEE, MMM-dd-yyyy, hh:mm aaa');
                // String formatted =formatter.format(now);
                return Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FractionColumnWidth(.3),
                          1: FractionColumnWidth(.7),
                        },
                        children: [
                          TableRow(children: [
                            Column(
                              children: [
                                Text(
                                  "User",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  snapshot.data.result.user.name +
                                      " (" +
                                      snapshot.data.result.user.email +
                                      ")",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  // formatted,
                                  date.substring(0,10),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                          ]),
                          TableRow(children: [
                            Column(
                              children: [
                                Text(
                                  "Score",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  snapshot.data.result.result.toString() +
                                      " / " +
                                      snapshot.data.result.totalQuestions
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17.0),
                                ),
                              ],
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<ResponseResult>(
                          future: getResult(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ResponseResult> list = snapshot
                                  .data.result.answer
                                  .cast<ResponseResult>();
                              return ListView(
                                children: [
                                  for(int i =0;i<list.length;i++)
                                    Column(
                                      children: [
                                        Text(snapshot.data.result.answer[i].question.questionText,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                                fontSize: 18.0
                                            )
                                        ),
                                        SizedBox(height: 10),
                                        for(int j=0; j<snapshot.data.result.answer[i].question.options.length; j++)
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: snapshot.data.result.answer[i].question.options[j].correct==1
                                                    ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  // mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(snapshot.data.result.answer[i].question.options[j].option,
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontStyle: FontStyle.normal,
                                                                fontSize: 17.0)
                                                        ),
                                                        if (snapshot.data.result.answer[i].optionId==snapshot.data.result.answer[i].question.options[j].id)
                                                          (Text("  (Your Answer)",
                                                              style: TextStyle(
                                                              color: Colors.green,
                                                              fontStyle: FontStyle.normal,
                                                              fontSize: 17.0,
                                                                  fontWeight: FontWeight.w700,))),
                                                      ],
                                                    )
                                                    : Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  // mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ),
                                                    Text(snapshot.data.result.answer[i].question.options[j].option,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: 17.0)
                                                    ),
                                                    // Icon(
                                                    //   Icons.arrow_forward,
                                                    //   color: Colors.black,
                                                    // ),
                                                    if (snapshot.data.result.answer[i].optionId==snapshot.data.result.answer[i].question.options[j].id)
                                                      (Text("  (Your Answer)",
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontStyle: FontStyle.normal,
                                                              fontSize: 17.0,
                                                              fontWeight: FontWeight.w600)
                                                      )),
                                                  ],


                                                )
                                              )
                                            ],
                                          ),
                                        SizedBox(height: 10),
                                        Container(
                                          margin: EdgeInsets.all(3.0),
                                          child: new SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text("Explanation: ",
                                                    style: TextStyle(
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w600)
                                                ),
                                                Text(snapshot.data.result.answer[i].question.answerExplanation,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 17.0)
                                                ),
                                              ],
                                            ),
                                          ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                                );
                            } else {
                              debugPrint("Loading to fetch Result");
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    FlatButton(
                      child: Text(
                        'Done',
                        // textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      color: Colors.orange,
                      disabledColor: Colors.grey,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirstScreen()));
                      },
                    ),
                  ],
                );
              } else {
                debugPrint("Loading to fetch Result");
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
