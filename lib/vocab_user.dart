import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapplication/model/Vocab_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'network_utils/api.dart';

class VocabUserPage extends StatefulWidget {
  @override
  _VocabUserPageState createState() => _VocabUserPageState();
}

class _VocabUserPageState extends State<VocabUserPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController wordController = TextEditingController();
  TextEditingController meaningController = TextEditingController();

  Future<Response> getVocab() async {
    final url = Network().link('/api/vocablist/user');
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

  deleteVocab(int id) async {
    final url = Network().link('/api/vocabulary/' + id.toString() + '/delete');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.delete(Uri.parse(url), headers: {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Own Vocabulary"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[_form(), _list()],
      )),
    );
  }

  _form() => Container(
        color: Colors.white70,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: wordController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Word'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please enter the word";
                    } else if (!RegExp(r'^[a-zA]+$').hasMatch(value)) {
                      return "Please enter a word without number and symbols";
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: meaningController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Meaning'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Please enter the meaning";
                      }
                      return null;
                    }),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () async {
                      var form = _formKey.currentState;
                      if (form.validate()) {
                        final String word = wordController.text;
                        final String meaning = meaningController.text;

                        addVocab();
                        //reset the form
                        form.reset();
                        //refresh the page
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                      }
                    },
                    child: Text('Add'),
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ),
              ],
            )),
      );
  _list() => Expanded(
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
                    Expanded(
                      child: Text("Actions",
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
                        List<Result> list = snapshot.data.result.cast<Result>();
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
                                      Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              // int id = snapshot
                                              //     .data.result[index].id;
                                              // deleteVocab(id);
                                              // //refresh the page
                                              // Navigator.pushReplacement(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             super.widget));
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        "Do you really want to delete this vocabulary?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            int id = snapshot
                                                                .data
                                                                .result[index]
                                                                .id;
                                                            deleteVocab(id);
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Yes"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("No"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.delete)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        debugPrint("Loading to fetch data");
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      );

  addVocab() async {
    final data = {
      'word': wordController.text,
      'meaning': meaningController.text
    };

    var url = await Network().link('/api/vocabulary/create');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> dataDecode = jsonDecode(response.body);
      // var jsonResponse = response.body;
      // vocabUser res = vocabUser.fromJson(json.decode(jsonResponse));
      debugPrint("Success add vocab");
    } else
      throw Exception('Failed adding Vocabulary');
  }
}
