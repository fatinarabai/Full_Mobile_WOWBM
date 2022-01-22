import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:myapplication/Topic%20Note/note_2.dart';
import 'package:myapplication/Topic%20Note/note_3.dart';
import 'package:myapplication/Topic%20Note/note_4.dart';
import 'package:myapplication/Topic%20Note/note_5.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../network_utils/api.dart';
import 'note_1.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  loadUrl_1() async {
    final url = Network().link('/api/topic/1');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'fileUrl', json.encode(body['result']['file_url']));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TopicFirstPage()));
    } else {
      print(response.body);
    }
  }

  loadUrl_2() async {
    final url = Network().link('/api/topic/2');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'fileUrl', json.encode(body['result']['file_url']));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TopicSecondPage()));
    } else {
      print(response.body);
    }
  }

  loadUrl_3() async {
    final url = Network().link('/api/topic/3');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'fileUrl', json.encode(body['result']['file_url']));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TopicThirdPage()));
    } else {
      print(response.body);
    }
  }

  loadUrl_4() async {
    final url = Network().link('/api/topic/4');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'fileUrl', json.encode(body['result']['file_url']));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TopicForthPage()));
    } else {
      print(response.body);
    }
  }

  loadUrl_5() async {
    final url = Network().link('/api/topic/5');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var body = json.decode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'fileUrl', json.encode(body['result']['file_url']));
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TopicFifthPage()));
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Note for Topic 1"),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: Center(
                  child: Text(
                    "5 Topics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // SizedBox(
              //   height: 10,
              // ),

              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 30.0, right: 30.0),
                child: Center(
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      SizedBox(
                        width: 350.0,
                        height: 90.0,
                        child: GestureDetector(
                          onTap: () {
                            loadUrl_1();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicFirstPage()));
                          },
                          child: Card(
                            // color: Color.fromARGB(255,21, 21, 21),
                            color: Colors.orangeAccent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),

                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Aktiviti Harian\n(Everyday Activities)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350.0,
                        height: 90.0,
                        child: GestureDetector(
                          onTap: () {
                            loadUrl_2();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicSecondPage()));
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Kehidupan Peribadi dan Sosial\n(Personal and social life)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350.0,
                        height: 90.0,
                        child: GestureDetector(
                          onTap: () {
                            loadUrl_3();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicThirdPage()));
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Dunia di Sekeliling Kita\n(The world around us)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350.0,
                        height: 90.0,
                        child: GestureDetector(
                          onTap: () {
                            loadUrl_4();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicForthPage()));
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Dunia Pekerjaan\n(The world of work)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 350.0,
                        height: 90.0,
                        child: GestureDetector(
                          onTap: () {
                            loadUrl_5();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopicFifthPage()));
                          },
                          child: Card(
                            color: Colors.orangeAccent,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Dunia Antarabangsa\n(The international world)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
