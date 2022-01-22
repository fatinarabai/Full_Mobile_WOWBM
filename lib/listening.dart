import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/model/ListeningQuestion_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



import 'network_utils/api.dart';



class ListeningPage extends StatefulWidget {
  final int id;
  ListeningPage(this.id);


  @override
  _ListeningPageState createState() => _ListeningPageState();
}

class _ListeningPageState extends State<ListeningPage> {
  bool _isLoading = true;

  Future<ListeningQuestion> loadQuestion() async{
    final url = Network().link('/api/exercise/'+ widget.id.toString()+'/questions');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if(response.statusCode==200){
      var jsonResponce = response.body;
      ListeningQuestion res = ListeningQuestion.fromJson(json.decode(jsonResponce));
      return res;
    }
    else
      throw Exception('Failed to load Question');
  }

  // Future loadQuestion() async {
  //   var url = Network().link(
  //       '/api/exercise/' + widget.id.toString() + '/questions');
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   final token = jsonDecode(localStorage.getString('token'));
  //   http.Response response = await http.get(Uri.parse(url), headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   var body = json.decode(response.body);
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     localStorage.setString(
  //         'audioUrl', json.encode(body['exercise']['audio_link']));
  //   } else {
  //     print(response.body);
  //   }
  // }

    // getAudioLink() async {
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   final audioUrl = jsonDecode(localStorage.getString('audioUrl'));
    //   setState(() => _isLoading = true);
    //   url = audioUrl;
    //   setState(() => _isLoading = false);
    // }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Listening Exercise"),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder<ListeningQuestion>(
                    future: loadQuestion(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String audiolink = snapshot.data.exercise.audioLink;
                        print(audiolink);
                        return Column(
                          children: [
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
                  ))
            ],
          ),
        ),
      );
    }
  }


