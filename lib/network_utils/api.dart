import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://wowbm.nadofficial.com';
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  patchData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.patch(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  postData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.post(Uri.parse(fullUrl), headers: _setHeaders());
  }

  // getData(apiUrl) async {
  //   var fullUrl = _url + apiUrl;
  //   await _getToken();
  //   print('${token}');
  //   return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  // }

  link(apiUrl) {
    var fullUrl = _url + apiUrl;
    return fullUrl;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
