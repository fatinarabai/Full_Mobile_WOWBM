import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapplication/model/Vocab_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'network_utils/api.dart';

class VocabAdminPage extends StatefulWidget {
  @override
  _VocabAdminPageState createState() => _VocabAdminPageState();
}

Future<Response> getVocab() async {
  final url = Network().link('/api/vocablist/admin');
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  final token = jsonDecode(localStorage.getString('token'));
  http.Response response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  // await Future.delayed(Duration(seconds: 3));
  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = response.body;
    Response res = Response.fromJson(json.decode(jsonResponse));
    return res;
  } else
    throw Exception('Failed to load Vocabulary');
}

class _VocabAdminPageState extends State<VocabAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Vocabulary"),
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.orangeAccent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Word",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text("Meaning",
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
                child: FutureBuilder<Response>(
                    future: getVocab(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Result> list = snapshot.data.result;
                        debugPrint("Has Data");
                        return ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
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
                                      snapshot.data.result[index].word,
                                      // "${snapshot.data[index]['word']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                    Expanded(
                                        child: Text(
                                      // "meaning",
                                      snapshot.data.result[index].meaning,
                                      // "${snapshot.data[index]['meaning']}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
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
