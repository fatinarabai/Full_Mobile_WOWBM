import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'inputDeco.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';
import 'network_utils/api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var name;
  var email;
  var school;
  var role;
  var password;
  var confirmpassword;
  String _chosenValue;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.amber, Colors.deepPurple])),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Card(
                      elevation: 1.0,
                      color: Colors.white,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Username",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (nameValue) {
                                  if (nameValue.isEmpty) {
                                    return 'Please enter username';
                                  }
                                  name = nameValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (emailValue) {
                                  if (emailValue.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(
                                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                      .hasMatch(emailValue)) {
                                    return 'Enter a valid Email';
                                  }
                                  email = emailValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.school,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Name of Institution/School",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (schoolname) {
                                  if (schoolname.isEmpty) {
                                    return 'Please enter name of Institution/School';
                                  }
                                  school = schoolname;
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              DropdownButtonFormField<String>(
                                style: TextStyle(color: Color(0xFF000000)),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.people,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Register As",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
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
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (passwordValue) {
                                  if (passwordValue.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  if (passwordValue.length < 3) {
                                    return 'Please enter Password more than 3 characters';
                                  }
                                  password = passwordValue;
                                  return null;
                                },
                              ),
                              TextFormField(
                                style: TextStyle(color: Color(0xFF000000)),
                                cursorColor: Color(0xFF9b9b9b),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                validator: (confirmpasswordValue) {
                                  if (confirmpasswordValue.isEmpty) {
                                    return 'Please enter confirm password';
                                  }
                                  confirmpassword = confirmpasswordValue;
                                  if (password != confirmpassword) {
                                    return "Password does not match";
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FlatButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 10, right: 10),
                                    child: Text(
                                      _isLoading ? 'Register' : 'Register',
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
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _register();
                                      setState(() {
                                        message = "Processing..";
                                      });
                                    }
                                  },
                                ),
                              ),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Already Have an Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.5,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var role;
    if (_chosenValue == "Student") {
      role = 2;
    } else
      role = 3;

    var data = {
      'name': name,
      'email': email,
      'role': role,
      'school': school,
      'password': password,
      'password_confirmation': confirmpassword
    };

    var res = await Network().authData(data, '/api/auth/register');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(res.body);
      // SharedPreferences localStorage = await SharedPreferences.getInstance();
      // localStorage.setString('user', json.encode(body['result']['user']));
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => LoginPage()),
      );
      setState(() {
        message = "Registration Successful";
      });
    } else {
      setState(() {
        _isLoading = false;
        message = "Registration Failed. Please try again.";
      });
      setState(() {});
      throw new Exception("Registration Failed");
    }
  }
}
