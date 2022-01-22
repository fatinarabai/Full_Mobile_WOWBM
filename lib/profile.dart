import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapplication/editProfile.dart';
import 'package:myapplication/model/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network_utils/api.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

Future<Response> getUser() async {
  final url = Network().link('/api/auth/user');
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  final token = jsonDecode(localStorage.getString('token'));
  http.Response response = await http.get(Uri.parse(url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  // print('token: $token');
  print(response.body);
  if (response.statusCode == 200) {
    var jsonResponse = response.body;
    Response res = Response.fromJson(json.decode(jsonResponse));
    return res;
  } else
    throw Exception('Failed to load User Profile');
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
           Container(
             width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: FutureBuilder<Response>(
                future: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user = snapshot.data.data.role.toString();
                    if (user == "2") {
                      user = "Student";
                    } else
                      user = "Teacher";
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Full Name\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 19.0),
                          ),
                          Text(
                            snapshot.data.data.name,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Email\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 19.0),
                          ),
                          Text(
                            snapshot.data.data.email,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Name of Institute/School\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 19.0),
                          ),
                          Text(
                            snapshot.data.data.school,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Role as\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                fontSize: 19.0),
                          ),
                          Text(
                            user,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    debugPrint("Loading to fetch User Data");
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,
            child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => EditProfile()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints:
                        BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
