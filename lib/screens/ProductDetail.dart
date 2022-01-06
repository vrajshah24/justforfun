import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/modules/order_page_module/order_page_page.dart';
import 'package:untitled/app/theme/app_colors.dart';

import '../l10n.dart';
import '../main.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.title, this.ProductID}) : super(key: key);
  final String title;
  final int ProductID;

  @override
  _DetailPage createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  var mProduct;
  var counter = 1;

  @override
  Widget build(BuildContext context) {
    void getProductDetail(BuildContext context, int ProductID) async {
      var client = http.Client();
      try {
        dynamic data = {
          'ProductID': ProductID,
        };
        print("post: " + jsonEncode(data));
        var uriResponse = await client.post(
            Uri.parse(
                "http://app.wellsunebusiness.online/WellSunWS.svc/GetProductDetails"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
            body: jsonEncode(data));
        print('result ' + uriResponse.body.toString());

        var result = jsonDecode(uriResponse.body)["GetProductDetailsResult"];
        var HasError = result["HasError"];
        if (HasError) {
          var ErrorCode = result["ErrorCode"];
          var Message = result["Messages"];
          showAlertDialog(context, Message[0].toString());
        } else {
          mProduct = result["mProduct"];
          print(mProduct.toString());
          setState(() {});
        }
      } finally {
        client.close();
      }
    }

    if (mProduct == null) getProductDetail(context, widget.ProductID);

    Align getBottomMenu(BuildContext context) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
            height: 60,
            width: double.infinity,
            child: Stack(alignment: Alignment.centerLeft, children: [
              GestureDetector(
                onTap: () {
                  if (counter > 0) counter--;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                  height: 50,
                  width: ((MediaQuery.of(context).size.width) / 4.5),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '-',
                      style: GoogleFonts.lato(
                          color: getMyAppColor(),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    counter++;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        left: ((MediaQuery.of(context).size.width) / 4.5),
                        top: 0,
                        right: 0,
                        bottom: 0),
                    height: 50,
                    width: ((MediaQuery.of(context).size.width) / 4.5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '+',
                        style: GoogleFonts.lato(
                            color: getMyAppColor(),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(left: 5, top: 0, right: 0, bottom: 0),
                  height: 50,
                  width: ((MediaQuery.of(context).size.width - 75) * 0.5),
                  child: Center(
                    child: Text(
                      '$counter',
                      style: GoogleFonts.lato(
                          color: getMyAppColor(),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  margin: EdgeInsets.only(left: 0, top: 0, right: 5, bottom: 0),
                  height: 50,
                  width: ((MediaQuery.of(context).size.width - 75) * 0.5),
                  decoration: BoxDecoration(
                      color: getMyAppColor(),
                      borderRadius: BorderRadius.circular(13)),
                  child: TextButton(
                    onPressed: () {
                      //OpenDialog(context);
                      // showAlertDialog(context, "Order placed. Please wait for the approval");
                      Get.to(() => OrderPagePage(), arguments: []);
                    },
                    child: Text(
                      'ORDER',
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ])
            ]),
            decoration: BoxDecoration(
              color: getBgColor(),
              border: Border.all(color: getBorderColor()),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            )),
      );
    }

    Scaffold getSettingsPage(BuildContext context, List<IconTitle> entries) {
      return Scaffold(
          backgroundColor: getBgColor(),
          body: Stack(children: [
            ListView(
              padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 120),
              children: [
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: 30, top: 120, right: 30, bottom: 0),
                        child: Row(children: [
                          Expanded(
                            child: Center(
                                child: Image.network(
                              mProduct == null
                                  ? "https://wellsunebusiness.online/assets/images/item/Vejita.jpg"
                                  : "http://wellsunebusiness.online/" +
                                      mProduct['cPath']
                                          .toString()
                                          .replaceAll("~", ""),
                              fit: BoxFit.cover,
                            )),
                          ),
                        ]),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: getBorderColor()),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                    child: Text(description(language),
                        style: GoogleFonts.lato(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start)),
                SizedBox.fromSize(size: Size(10, 10)),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(mProduct == null ? "" : mProduct['cMfg'],
                        // "Poshak contains potent biological extracts combined under scientifically controlled conditions for optimum growth enhancement and pest control. \n\nPoshak is of completely natural origin and exhibits excellent medicinal and nutritional values. When sprayed on the crop Poshak enhances inherent immunity in crop – Systemic Acquired Immunity and also increases flowering, flower retention and fruiting resulting in higher yields.",
                        style: GoogleFonts.lato(
                            fontSize: 12, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start)),
                Divider(color: getBorderColor()),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("What is ${widget.title}?",
                        style: GoogleFonts.lato(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start)),
                SizedBox.fromSize(size: Size(10, 10)),
                Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                        "Poshak contains potent biological extracts combined under scientifically controlled conditions for optimum growth enhancement and pest control. \n\nPoshak is of completely natural origin and exhibits excellent medicinal and nutritional values. When sprayed on the crop Poshak enhances inherent immunity in crop – Systemic Acquired Immunity and also increases flowering, flower retention and fruiting resulting in higher yields.",
                        style: GoogleFonts.lato(
                            fontSize: 12, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.start)),
              ],
            ),
            getBottomMenu(context),
            Container(
              margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
              height: 55,
              width: double.infinity,
              child: Stack(children: [
                Container(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          "assets/icon/ic_back.png",
                          width: 20,
                        )),
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    alignment: Alignment.centerLeft),
                Center(
                    child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ))
              ]),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: getBorderColor()),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ]));
    }

    final List<IconTitle> entries = <IconTitle>[
      IconTitle('Attendance', 'ic_attendance'),
      IconTitle('Homework', 'ic_home_work'),
      IconTitle('Notice', 'ic_notice'),
      IconTitle('Schedule', 'ic_daily_session'),
      IconTitle('Daily Session', 'ic_daily_session'),
      IconTitle('Daily Test', 'ic_daily_test'),
      IconTitle('Material', 'ic_material'),
      IconTitle('Leave Request', 'ic_leaverequest'),
      IconTitle('Query', 'ic_query'),
      IconTitle('Remarks', 'ic_remarks'),
      IconTitle('Food Menu', 'ic_food_menu'),
      IconTitle('Events', 'ic_events'),
    ];
    return getSettingsPage(context, entries);
  }
}

String getProduct() {
  var list = ['1.png', '2.png', '3.jpeg'];
  // generates a new Random object
  final _random = new Random();
  // generate a random index based on the list length
  // and use it to retrieve the element
  var element = list[_random.nextInt(list.length)];
  return element;
}

dynamic callApi(dynamic data, String apiName) async {
  var client = http.Client();
  var response;
  try {
    print("post: " + jsonEncode(data));
    var uriResponse = await client.post(Uri.parse(apiName),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
        },
        body: jsonEncode(data));
    print("request url: " + apiName);
    print("input params: " + jsonEncode(data));
    response = jsonDecode(uriResponse.body);
    print("response: " + response.toString());
  } finally {
    client.close();
  }
  return response;
}

OpenDialog(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: getBgColor(),
      context: context,
      builder: (context) {
        return ListView(
          children: <Widget>[
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 20, right: 20, bottom: 0),
                        child: Image.asset(
                          "assets/icon/ic_close.png",
                          width: 30,
                        )))),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 0, right: 20, bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: getBorderColor()),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      // color:data.color,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon/" + "product1.png",
                            width: 50,
                          ),
                        ],
                      )),
                  Text(
                    'Poshak',
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: getBorderColor()),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      // color:data.color,
                      child: Row(
                        children: [
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("-")),
                          ),
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("1")),
                          ),
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("+")),
                          ),
                        ],
                      ))
                ]),
            //getDivider(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 0, right: 20, bottom: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: getBorderColor()),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      // color:data.color,
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/icon/product1.png",
                            width: 50,
                          ),
                        ],
                      )),
                  Text(
                    'Poshak',
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(color: getBorderColor()),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      // color:data.color,
                      child: Row(
                        children: [
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("-")),
                          ),
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("1")),
                          ),
                          SizedBox.fromSize(
                            size: Size(30, 20),
                            child: Center(child: Text("+")),
                          ),
                        ],
                      ))
                ]),
            //getDivider(),
            Container(
              margin: EdgeInsets.only(left: 0, top: 0, right: 20, bottom: 20),
              height: 20,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 20, bottom: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Center(
                        child: Text(
                      'CONTINUE ORDER',
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF777777)),
                    )),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, top: 0, right: 20, bottom: 20),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        color: getMyAppColor(),
                        borderRadius: BorderRadius.circular(13)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'PLACE ORDER',
                        style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ]),
          ],
        );
      });
}

GetAllSubjects(BuildContext context) async {
  print("starting");
  dynamic data = {};
  var apiResult =
      await callApi(data, "http://app.snvschool.org/SchoolWS.svc/GetSubject");

  var result = apiResult["GetSubjectResult"];

  var HasError = result["HasError"];

  if (HasError) {
    var ErrorCode = result["ErrorCode"];
    var Message = result["Messages"];
    print('Error Code : ' + ErrorCode);
    print('Messages : ' + Message[0].toString());
  } else {
    var lstSubject = result["lstSubject"];
    var firstItem = lstSubject[0];
    //GetChapters(context, firstItem['nCode'], firstItem['nCode']);
  }
}
