import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TopicSecondPage extends StatefulWidget {
  @override
  _TopicSecondPageState createState() => _TopicSecondPageState();
}

class _TopicSecondPageState extends State<TopicSecondPage> {
  bool _isLoading = true;
  // PDFDocument document;
  dynamic url;


  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  loadDocument() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final fileUrl = jsonDecode(localStorage.getString('fileUrl'));
    var finalUrl = Uri.parse(fileUrl.replaceAll(" ", "%20"));
    debugPrint(finalUrl.toString());
    print(finalUrl);
    setState(() => _isLoading = true);
    url=finalUrl;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Note for Topic 1"),
        backgroundColor: Colors.orange,
      ),

      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SfPdfViewer.network(
              "$url")
      ),
    );
  }
}
