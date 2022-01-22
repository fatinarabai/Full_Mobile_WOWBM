import 'dart:html';

import 'package:flutter/material.dart';

class SubmitPage extends StatefulWidget {
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Submit"),
        backgroundColor: Color(0xffff9800),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              child: Text(
                "Submit",
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
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
