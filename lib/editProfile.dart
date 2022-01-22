import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapplication/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController schoolController = new TextEditingController();
  // final TextEditingController passwordController = new TextEditingController();

  String name;
  String email;
  String school;
  String _chosenValue;
  // String password;
  String message = '';

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if (user != null) {
      setState(() {
        name = user['name'];
        email = user['email'];
        // password = user['password'];
        school=user['school'];
      });
    }

    setState(() {
      nameController.text = name;
      emailController.text = email;
      schoolController.text=school;
    });
  }

  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
        centerTitle: true,
        backgroundColor: Color(0xffff9800),
      ),
      body: new Form(
        key: _formKey,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            Container(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "Full Name", hintText: "Enter your Username"),
                controller: nameController,
                onChanged: (String value) {
                  name = value;
                },
              ),
            ),
            Container(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "Enter your Email"),
                controller: emailController,
                onChanged: (String value) {
                  email = value;
                },
              ),
            ),
            Container(
              child: TextField(
                decoration: const InputDecoration(
                    labelText: "School", hintText: "Enter School/Institution"),
                controller: schoolController,
                onChanged: (String value) {
                 school = value;
                },
              ),
            ),
            Container(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  hintText: "Register As",
                ),
                items: <String>[
                  'Student',
                  'Teacher',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;
                  });
                },
              ),
            ),
            // Container(
            //   child: TextField(
            //     decoration: const InputDecoration(
            //         labelText: "Password", hintText: "Enter your Password"),
            //     controller: passwordController,
            //     onChanged: (String value) {
            //       password = value;
            //     },
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("CANCEL",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                RaisedButton(
                  onPressed: () {
                    updateUser();
                  },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Text(message,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }

  void updateUser() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'name': name, 'email': email};
    var res = await Network().patchData(data, '/api/settings/profile');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
      setState(() {
        message = "Update Profile Success";
      });
      print(res.body);
    } else {
      setState(() {
        message = "Update Profile Failed. Try Again";
      });
    }
  }
}
