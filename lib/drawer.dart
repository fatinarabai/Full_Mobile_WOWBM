import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myapplication/exercise.dart';
import 'package:myapplication/profile.dart';
import 'package:myapplication/vocab_admin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'analysis.dart';
import 'login.dart';
import 'network_utils/api.dart';
import 'Topic Note/notes.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.white,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: 'My Profile',
              icon: Icons.account_circle,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Notes',
              icon: Icons.menu_book,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Exercise',
              icon: Icons.drive_file_rename_outline,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Vocabulary',
              icon: Icons.article,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Analysis',
              icon: Icons.bar_chart,
              onClicked: () => selectedItem(context, 4),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => logout(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.orange;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color, fontSize: 19),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    //so before navigate to next page, drawer will close first
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => Profile()));
        break;
      case 1:
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => NotesPage()));
        break;
      case 2:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => ExercisePage()));
        break;
      case 3:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => VocabAdminPage()));
        break;
      case 4:
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => AnalysisPage()));
        break;
    }
  }

  void logout(BuildContext context) async {
    var res = await Network().postData('/api/auth/logout');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(res.body);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
