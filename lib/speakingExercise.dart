import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/speaking.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'model/ExerciseList_model.dart';
import 'network_utils/api.dart';

class SpeakingSetPage extends StatefulWidget {
  @override
  _SpeakingSetPageState createState() => _SpeakingSetPageState();
}

class _SpeakingSetPageState extends State<SpeakingSetPage> {

  Future<ExerciseList> getReadingList() async {
    final url = Network().link("/api/exerciselist/4");
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
      ExerciseList res = ExerciseList.fromJson(json.decode(jsonResponse));
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
        title: Text("Speaking Exercises"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Expanded(
                child: Text(
                  "Exercise Set Available",
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
                        "Name",
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
                child: FutureBuilder<ExerciseList>(
                    future: getReadingList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Result> list = snapshot.data.result;
                        debugPrint("Has Data");
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            int id=snapshot.data.result[index].id;
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
                                          // "word",
                                          snapshot.data.result[index].exerciseName,
                                          // "${snapshot.data[index]['word']}",
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
                                                  builder: (context) => SpeakingPage(id)));
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
