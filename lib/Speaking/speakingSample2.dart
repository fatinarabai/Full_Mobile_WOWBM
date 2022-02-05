import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapplication/model/Speaking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network_utils/api.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:splashscreen/splashscreen.dart';


class SpeakingSample2Page extends StatefulWidget {
  final int qid;
  SpeakingSample2Page(this.qid);


  @override
  _SpeakingSample2PageState createState() => _SpeakingSample2PageState();
}

class _SpeakingSample2PageState extends State<SpeakingSample2Page> {

  _launchURLBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURLApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

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

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: FutureBuilder<SpeakingResponse>(
                  future: loadQuestionOption(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<QuestionOption> videolink = snapshot.data
                          .questionOption;
                      return ListView.builder(
                          itemCount: videolink.length,
                          itemBuilder: (context, index) {
                            String link = snapshot.data.questionOption[index].youtubeLink;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text(
                                link,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),

                          RaisedButton(
                            color: Colors.amber,
                            onPressed: (){
                              _launchURLBrowser(link);
                            },
                            child: Text("Open at Browser",
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                          ),
                          SizedBox(height: 8),
                          RaisedButton(
                            color: Colors.amber,
                            onPressed: (){
                              _launchURLApp(link);
                            },
                            child: Text("Open at App",
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                          ),

                        ],

                      );
                    }
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
          ],
        ),
      ),
    );
  }
}

