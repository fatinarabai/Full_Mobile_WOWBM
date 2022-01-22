import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapplication/model/Speaking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network_utils/api.dart';


class SpeakingSamplePage extends StatefulWidget {
  final int qid;
  SpeakingSamplePage(this.qid);



  @override
  _SpeakingSamplePageState createState() => _SpeakingSamplePageState();
}

class _SpeakingSamplePageState extends State<SpeakingSamplePage> {
  // bool isLoading = true;
  String videoID;
  bool showItem = false;
  String linkRef;



  Future<SpeakingResponse> loadQuestionOption() async {
    final url = Network().link('/api/question/' + widget.qid.toString());
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final token = jsonDecode(localStorage.getString('token'));
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    // print(response.body);
    if (response.statusCode == 200) {
      var jsonResponce = response.body;
      SpeakingResponse res = SpeakingResponse.fromJson(json.decode(jsonResponce));
      return res;
    } else
      throw Exception('Failed to load Question');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Speaking Exercise Sample Answer"),
        backgroundColor: Colors.orange,
      ),

    );

  }
}

