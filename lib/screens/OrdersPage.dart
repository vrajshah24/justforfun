import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/GetUserSalesModel.dart';
import 'package:untitled/app/theme/app_colors.dart';

import '../l10n.dart';
import '../main.dart';

class MyOrdersPage extends StatefulWidget {
  MyOrdersPage({Key key, this.title, this.language, this.username})
      : super(key: key);

  final String title;
  final String language;
  final String username;

  @override
  _MyOrdersPage createState() => _MyOrdersPage();
}

bool isLogin = false;

String getCapitalizeString({String str}) {
  if (str.length <= 1) {
    return str.toUpperCase();
  }
  return '${str[0].toUpperCase()}${str.substring(1)}';
}

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _MyOrdersPage extends State<MyOrdersPage> {
  String language = '';

  static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => const AlertDialog(
        title: Text('WELLSUN FARMER FERTILIZER PVT. LTD.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF777777))),
        content: Text(
          'We are closely associated with our farmers and suppliers across the Country. Our products specifically address the problem related environment and the threat to human life & health which resultant of the chemical farming. Our products are bio-degradable, environment friendly; that protects the crop naturally and at the same time help to increase the crop yield.\n\n Wellsun Farmer Fertilizer Pvt. Ltd is based on direct relationships between our team, our customer and our partners in India. Every process we carefully check and test on a regular basis to achieve consistency in providing excellent quality and assurance of our products. Wherever necessary, full audits of each process are carried out by our professional representative. Testing of regimes and sample is done by our bio fertilizer lab as per international standards.\n\nOur services start with the desire and requirements of a farmer from fertilizer manufacturer. These values guided us throughout every business activity done with our suppliers, our customers, and within the communities; we call home. Our results are earned by fairness, loyalty, honesty and courtesy towards our customers, employees, and society at large. We are reputed organic fertilizer manufacturer kindly give us chance to serve for you.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF777777)),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    language = widget.language;
    var storage = GetStorage();
    isLogin =
        storage.read("is_login") == null ? false : storage.read("is_login");

    Future getAllOrders(BuildContext context) async {
      var client = http.Client();
      try {
        dynamic data = {
          'EnrollNo': widget.username,
        };
        print("post: " + jsonEncode(data));
        var uriResponse = await client.post(
            Uri.parse(
                "http://app.wellsunebusiness.online/WellSunWS.svc/GetUserSales"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
            body: jsonEncode(data));
        var result = jsonDecode(uriResponse.body)["GetUserSalesResult"];
        print(result.toString());

        var HasError = result["HasError"];
        if (HasError) {
          var ErrorCode = result["ErrorCode"];
          var Message = result["Messages"];
          showAlertDialog(context, Message[0].toString());
        } else {
          lstOrders = result["lstMaterial"];
          setState(() {});
        }
      } finally {
        client.close();
      }
    }

    Container getSingleProduct(dynamic item) {
      return Container(
          child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (position) => DetailPage(
                //               title: item['cName'],
                //               ProductID: item['nCode'],
                //             )));
              },
              child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - 40,
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
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  // color:data.color,
                  child: Column(
                    children: [
                      FadeInImage.assetNetwork(
                        placeholder: "assets/icon/product1.png",
                        image: "http://wellsunebusiness.online/" +
                            item['cPath'].toString().replaceAll("~", ""),
                        width: MediaQuery.of(context).size.width * 0.24,
                        height: MediaQuery.of(context).size.width * 0.24,
                      ),
                      SizedBox(height: 5),
                      Center(
                          child: Text(item['cName'],
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 14,
                                  color: Colors.black),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 4),
                      Container(
                          child: Center(
                              child: Text(wellsun(language),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 10,
                                      color: Colors.black),
                                  textAlign: TextAlign.center)))
                    ],
                  ))));
    }

    Container getProductListItem(int index) {
      if (index == 0) {
        return Container(
            child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Text(marketingAndSupply(language),
              style: TextStyle(fontFamily: getAmatic(), fontSize: 42),
              textAlign: TextAlign.center),
        ]));
      } else if (index == 1) {
        return Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(children: [
              Text(organicFertilizer(language),
                  style: TextStyle(fontFamily: getProximaNova(), fontSize: 16),
                  textAlign: TextAlign.center),
            ]));
      } else {
        int offset = index - 2;
        var item = lstProducts[offset * 2];
        var item2 = lstProducts[(offset * 2) + 1];

        return Container(
            child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Row(children: [
            getSingleProduct(item),
            SizedBox.fromSize(size: Size(40, 40)),
            getSingleProduct(item2),
          ]),
        ));
      }
    }

    Column getRegistrationItem(BuildContext context, int index) {
      if (lstMyUsers == null) {
        return Column(children: []);
      } else {
        var mData = lstMyUsers[index];
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                      child: Center(
                          child: Image.asset(
                        "assets/icon/ic_profile.png",
                        fit: BoxFit.cover,
                        height: 60,
                      )),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(mData['cName'].split(" ")[0],
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start),
                          Text(mData['cType'] + " " + mData['cEnrollNo'],
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start),
                          Text('+91 99999 87654',
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start),
                        ]))
              ]),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Image.asset(
                      "assets/icon/ic_arrow_down.png",
                      height: 8,
                    )),
              )
            ]),
            getDividerOnly(1)
          ],
        );
      }
    }

    Column getCompanyProfileItem(BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Center(
              child: Image.asset(
            "assets/icon/ic_logo.png",
            fit: BoxFit.cover,
            height: 120,
          )),
          SizedBox(height: 20),
          Text(about(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          Text(aboutDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(qualityPolicy(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          Text(qualityPolicyDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(ourQualityObjectives(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          Text(ourQualityObjectivesDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(ourVision(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          Text(ourVisionDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(ourMission(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          Text(ourMissionDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(useOfBarbanIsraelSoilCarbon(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          Text(useOfBarbanIsraelSoilCarbonDetail(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.start),
          SizedBox(height: 20),
          Text(certificate(language),
              style: TextStyle(
                  fontFamily: getProximaNova(),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.start),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert3.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert4.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert5.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert6.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Image.asset(
              "assets/icon/cert7.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }

    Column getOrdersItem(BuildContext context, int index) {
      dynamic item = lstOrders[index];
      if (index % 2 != 0) {
        return Column(children: [
          SizedBox.fromSize(size: Size(20, 20)),
          Text(
            item['strDate'],
            style: TextStyle(
                color: Color(0xFF777777),
                fontFamily: getProximaNova(),
                fontSize: 12,
                fontWeight: FontWeight.w700),
          )
        ]);
      } else {
        return Column(
          children: [
            Row(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Container(
                    child: Center(
                        child: Image.asset(
                      "assets/icon/product1.png",
                      fit: BoxFit.cover,
                      height: 60,
                    )),
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                    item['lstSalesDetail'][0]['cName'] +
                        "\n\nMRP:" +
                        item['lstSalesDetail'][0]['nMRP'].toString() +
                        "\n\nGross:" +
                        item['lstSalesDetail'][0]['nGross'].toString(),
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text('Qty ${item['lstSalesDetail'][0]['nQty']}',
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        color: getMyAppColor(),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start),
              )
            ]),
            getDividerOnly(1)
          ],
        );
      }
    }

    Positioned getBottomMenu(BuildContext context) {
      return Positioned(
          child: Align(
        alignment: Alignment.topCenter,
        child: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
            height: 55,
            width: double.infinity,
            child: Stack(children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/icon/ic_back.png",
                      height: 18,
                    ),
                  )),
              Container(
                child: Center(
                    child: Text(
                  "Orders",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: getProximaNova(),
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )),
              )
            ]),
            decoration: BoxDecoration(
              color: Colors.white,
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
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          FutureBuilder<GetUserSalesModel>(
            future: DioProvider().getAllOrders(widget.username),
            builder: (BuildContext context,
                AsyncSnapshot<GetUserSalesModel> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return ListView.builder(
                      itemCount:
                          snapshot.data.getUserSalesResult.lstMaterial.length,
                      padding: EdgeInsets.fromLTRB(25, 115, 25, 25),
                      itemBuilder: (BuildContext context, int index) =>
                          getOrdersItem(context, index),
                    );
              }
            },
          ),
          getBottomMenu(context)
        ],
      ),
    );
  }
}

String getProduct() {
  var list = ['1.png', '2.png', '3.jpeg'];
  final _random = new Random();
  var element = list[_random.nextInt(list.length)];
  return element;
}

Divider getDividerOnly(int Padding) {
  return Divider(color: getBorderColor());
}

var lstMyUsers;
var lstProducts;
var lstOrders;
