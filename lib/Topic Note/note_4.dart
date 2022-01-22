import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicForthPage extends StatefulWidget {
  @override
  _TopicForthPageState createState() => _TopicForthPageState();
}

class _TopicForthPageState extends State<TopicForthPage> {
  bool _isLoading = true;
  dynamic url;

  @override
  void initState() {
    super.initState();
    loadDocument();
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

  // loadDocument() async {
  //   setState(() => _isLoading = true);
  //   // document = await PDFDocument.fromAsset('assets/sample.pdf');
  //   var url = await Network().link("/");
  //   document = await PDFDocument.fromURL(
  //       url + "web//upload/1/DP%20Lab%204a%20Singleton.pdf");
  //   setState(() => _isLoading = false);
  // }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //     home: Scaffold(
    // klau buat 2 atas ni, takkan ada arrow back at appbar
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Note for Topic 1"),
        backgroundColor: Colors.orange,
      ),

      // body: SafeArea(
      //     child: Container(
      //             height: 599,
      //             child: PDFViewer(document: document),
      //           ),
      //       ),
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SfPdfViewer.network(
              "$url")
        // : PDFViewer(
        //     document: document,
        //     zoomSteps: 1,
        //   ),
      ),
    );
    // );
  }
}
