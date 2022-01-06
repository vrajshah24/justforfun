import 'package:flutter/material.dart';
import 'package:untitled/screens/ProductList.dart';

import 'FullImagePage.dart';

class EventGalleryScreen extends StatefulWidget {
  EventGalleryScreen({Key key, this.title, this.eventId}) : super(key: key);

  final String title;
  final int eventId;

  @override
  _EventGalleryScreen createState() => _EventGalleryScreen();
}

class _EventGalleryScreen extends State<EventGalleryScreen> {
  List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    void reloadList(dynamic value) {
      data = (value);
      print(data.toString());
      setState(() {});
    }

    if (data == null) {
      Future<dynamic> value = GetEventDetail(context, widget.eventId);
      value.then((value) => {reloadList(value)});

      print(value.toString());
    }
    if (data == null) return EmptyView(widget.title);

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Flexible(child: Container(child: Text(widget.title))),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(color: Colors.white24),
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: (1 / 1),
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              padding: EdgeInsets.all(2.0),
              children: data == null
                  ? <dynamic>[]
                  : data
                      .map(
                        (data) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (position) =>
                                          FullImagePage(title: data['Path'])));
                            },
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                // color:data.color,
                                // color: getMyAppColor(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      "http://a.com/" +
                                          data['Path']
                                              .toString()
                                              .replaceAll("~", ""),
                                    ),
                                  ],
                                ))),
                      )
                      .toList(),
            ),
          )
        ]));
  }
}

Scaffold EmptyView(String widget) {
  return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget),
      ),
      body: Stack(children: []));
}

GetEventDetail(BuildContext context, int EventID) async {
  var lstPhotos;
  dynamic data = {
    "EventID": EventID,
  };
  String api = "GetEventDetail";
  var apiResult =
      await callApi(data, "http://app.snvschool.org/SchoolWS.svc/" + api);

  var result = apiResult[api + "Result"];

  var HasError = result["HasError"];
  var ErrorCode = result["ErrorCode"];
  var Message = result["Messages"];

  if (HasError) {
  } else {
    lstPhotos = result["lstPhotos"];
  }
  return lstPhotos;
}
