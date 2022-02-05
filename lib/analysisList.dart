import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/AnalysisList_model.dart';
import 'package:myapplication/reading.dart';
import 'package:myapplication/Reading/reading2.dart';
import 'package:myapplication/viewResult.dart';
import 'package:myapplication/viewResult2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model/ExerciseList_model.dart';
import 'network_utils/api.dart';

class AnalysisListPage extends StatefulWidget {
  @override
  _AnalysisListPageState createState() => _AnalysisListPageState();
}

class _AnalysisListPageState extends State<AnalysisListPage> {

  Future<AnalysisList> getAnalysisList() async {
    final url = Network().link("/api/result/all");
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = response.body;
      AnalysisList res = AnalysisList.fromJson(json.decode(jsonResponse));
      return res;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => ReadingSetPage()));
    } else
      throw Exception('Failed to load Exercise List');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Analysis"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
                child: Text(
                  "Analysis History",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21.0,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.orangeAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Exercise Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Type",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text("Action",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: FutureBuilder<AnalysisList>(
                    future: getAnalysisList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                          List list = snapshot.data.result;
                        debugPrint("Has Data");
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            int id=snapshot.data.result[index].id;
                            int type=snapshot.data.result[index].exerciseTypeId;
                            String a;
                            if(type==1){
                              a = "Reading";
                            }
                            else if(type==2){
                              a="Writing";
                            }
                            else if(type==3){
                              a="Listening";
                            }
                            else if(type==4){
                              a="Speaking";
                            }
                            return Card(
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 17.0,
                                    bottom: 17.0,
                                    left: 1.0,
                                    right: 1.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          snapshot.data.result[index].exerciseName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    Expanded(
                                        child: Text(
                                          a,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) => ViewResult(id)));
                                        },
                                        child: Text(
                                          "Attempt",
                                          // snapshot.data.result[index].meaning,
                                          // "${snapshot.data[index]['meaning']}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        debugPrint("Loading to fetch data");
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
