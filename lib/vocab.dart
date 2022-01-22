import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapplication/vocab_admin.dart';
import 'package:myapplication/vocab_user.dart';

class VocabPage extends StatefulWidget {
  @override
  _VocabPageState createState() => _VocabPageState();
}

class _VocabPageState extends State<VocabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Vocabulary"),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Padding(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VocabAdminPage()));
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
                              "Vocabulary Lists",
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VocabUserPage()));
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
                              "Extra Own Vocabulary",
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
        ));
  }
}
