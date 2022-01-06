import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FullImagePage extends StatefulWidget {
  FullImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FullImagePage createState() => _FullImagePage();
}

class _FullImagePage extends State<FullImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Christmas 2021"),
        ),
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(color: Colors.white24),
              child: Image.network("http://sw.snvschool.org/" +
                  widget.title.toString().replaceAll("~", "")))
        ]));
  }

  void loginUser(BuildContext context, String username, String password) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(
          Uri.parse(
              'http://lms.nadiadayurveda.org/JsAyurvedicWS.svc/GetAllUser'),
          body: {'name': 'doodle', 'color': 'blue'});
    } finally {
      client.close();
    }
  }

  List<Widget> createListTiles() {
    List<Widget> tiles = <Widget>[];
    for (int i = 0; i < 40; i++) {
      int count = i + 1;
      tiles.add(new ListTile(
        leading: new CircleAvatar(
          child: new Text("$count"),
          backgroundColor: Colors.lightGreen[700],
        ),
        title: new Text("Title number $count"),
        subtitle: new Text("This is the subtitle number $count"),
      ));
    }
    return tiles;
  }
}
