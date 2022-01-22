import 'package:flutter/material.dart';
import 'package:myapplication/viewResult.dart';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Analysis"),
        backgroundColor: Color(0xffff9800),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                "View Result",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            color: Colors.orange,
            disabledColor: Colors.grey,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            onPressed: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => ViewResult()));
            },
          ),
        ),
      ),
    );
  }
}
