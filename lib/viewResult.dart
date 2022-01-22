import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapplication/homepage.dart';
import 'package:myapplication/model/Result_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_utils/api.dart';

class ViewResult extends StatefulWidget {
  @override
  _ViewResultState createState() => _ViewResultState();
}

Future<ResponseResult> getResult() async {
  // final url = Network().link('/attempt/18/result');
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

class _ViewResultState extends State<ViewResult> {
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
                                // Text(
                                //   snapshot.data.result.createdAt,
                                //   style: TextStyle(
                                //       color: Colors.black,
                                //       fontStyle: FontStyle.normal,
                                //       fontSize: 17.0),
                                // ),
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
                              return ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    int myAnswer = snapshot
                                        .data.result.answer[index].optionId;
                                    return ListTile(
                                      title: Text(
                                          snapshot.data.result.answer[index]
                                              .question.questionText,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: snapshot
                                                        .data
                                                        .result
                                                        .answer[index]
                                                        .question
                                                        .options[0]
                                                        .correct ==
                                                    1
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                      ),
                                                      Text(snapshot
                                                              .data
                                                              .result
                                                              .answer[index]
                                                              .question
                                                              .options[0]
                                                              .option +
                                                          " (Correct Answer)"),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                      Text(snapshot
                                                          .data
                                                          .result
                                                          .answer[index]
                                                          .question
                                                          .options[0]
                                                          .option)
                                                    ],
                                                  ),
                                          ),
                                          Container(
                                              child: snapshot
                                                          .data
                                                          .result
                                                          .answer[index]
                                                          .question
                                                          .options[1]
                                                          .correct ==
                                                      1
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(snapshot
                                                                .data
                                                                .result
                                                                .answer[index]
                                                                .question
                                                                .options[1]
                                                                .option +
                                                            " (Correct Answer)"),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                        Text(snapshot
                                                            .data
                                                            .result
                                                            .answer[index]
                                                            .question
                                                            .options[1]
                                                            .option)
                                                      ],
                                                    )),
                                          Container(
                                              child: snapshot
                                                          .data
                                                          .result
                                                          .answer[index]
                                                          .question
                                                          .options[2]
                                                          .correct ==
                                                      1
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(snapshot
                                                                .data
                                                                .result
                                                                .answer[index]
                                                                .question
                                                                .options[2]
                                                                .option +
                                                            " (Correct Answer)"),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                        Text(snapshot
                                                            .data
                                                            .result
                                                            .answer[index]
                                                            .question
                                                            .options[2]
                                                            .option)
                                                      ],
                                                    )),
                                          Container(
                                              child: snapshot
                                                          .data
                                                          .result
                                                          .answer[index]
                                                          .question
                                                          .options[3]
                                                          .correct ==
                                                      1
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Text(snapshot
                                                                .data
                                                                .result
                                                                .answer[index]
                                                                .question
                                                                .options[3]
                                                                .option +
                                                            " (Correct Answer)"),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                        Text(snapshot
                                                            .data
                                                            .result
                                                            .answer[index]
                                                            .question
                                                            .options[3]
                                                            .option)
                                                      ],
                                                    )),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              debugPrint("Loading to fetch Result");
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                    FlatButton(
                      child: Text(
                        'Done',
                        textDirection: TextDirection.ltr,
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
