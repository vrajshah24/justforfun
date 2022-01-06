import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/screens/ProductList.dart';

class RandomColorModel {
  Random random = Random();

  Color getColor() {
    // return Color.fromARGB(random.nextInt(300), random.nextInt(300),
    //     random.nextInt(300), random.nextInt(300));
    return Colors.blue;
  }
}

class QueryPage extends StatefulWidget {
  QueryPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _QueryPage createState() => _QueryPage();
}

class _QueryPage extends State<QueryPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    bool _saving = false;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: GoogleFonts.lato()),
      ),
      body: ModalProgressHUD(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: GoogleFonts.lato(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Department',
                      hintText: 'Select query department'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  style: GoogleFonts.lato(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your query',
                      alignLabelWithHint: true,
                      hintText: 'Enter your query here'),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: getMyAppColor(),
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: GoogleFonts.lato(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: _saving,
      ),
    );
  }
}

class _HomePageState extends State<QueryPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final List<String> entries = <String>[
      'Attendance',
      'Homework',
      'Notice',
      'Schedule',
      'Daily Session',
      'Daily Test',
      'Material',
      'Leave Request',
      'Query',
      'Remarks',
      'Food Menu',
      'Events'
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Home"),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: (1 / 1),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          //physics:BouncingScrollPhysics(),
          padding: EdgeInsets.all(10.0),
          children: entries
              .map(
                (data) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (position) => MyHomePage(title: data)));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        //  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        //color:data.color,
                        color: RandomColorModel().getColor(),
                        child:
                            /*Icon(
                      data.icon,
                      size: 25,
                      color: Colors.black,
                    ),*/
                            Center(
                                child: Text(data,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                    textAlign: TextAlign.center)))),
              )
              .toList(),
        ),
      ),
    );
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
}
