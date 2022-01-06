import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/GetUserSalesModel.dart';
import 'package:untitled/app/modules/login_page_module/login_page_page.dart';
import 'package:untitled/app/modules/stepper_register_user_module/stepper_register_user_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/screens/OrdersPage.dart';
import 'package:untitled/screens/ProfileScreen.dart';

import '../l10n.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.language}) : super(key: key);

  final String title;
  final String language;

  @override
  _ProductListScreen createState() => _ProductListScreen();
}

bool isLogin = false;

enum Page {
  home,
  orders,
  products,
  settings,
  Registration,
  ContactUs,
  companyProfile
}

Page selectedPage = Page.home;
String pageTitle = welcome(language);
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _ProductListScreen extends State<MyHomePage> {
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
  Widget build(BuildContext context) {
    language = widget.language;
    var storage = GetStorage();
    isLogin =
        storage.read("is_login") == null ? false : storage.read("is_login");

    void getMyUsers(BuildContext context) async {
      var client = http.Client();
      try {
        dynamic data = {
          'EnrollNo': GetStorage().read('Username'),
        };
        print("post: " + jsonEncode(data));
        var uriResponse = await client.post(
            Uri.parse(
                "http://app.wellsunebusiness.online/WellSunWS.svc/GetMyUsers"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
            body: jsonEncode(data));
        var result = jsonDecode(uriResponse.body)["GetMyUsersResult"];
        var HasError = result["HasError"];
        if (HasError) {
          var ErrorCode = result["ErrorCode"];
          var Message = result["Messages"];
          showAlertDialog(context, Message.toString());
        } else {
          lstMyUsers = result["lstMyUsers"];
          setState(() {});
        }
      } finally {
        client.close();
      }
    }

    void getProducts(BuildContext context) async {
      var client = http.Client();
      try {
        dynamic data = {
          'EnrollNo': GetStorage().read('Username'),
        };
        print("post: " + jsonEncode(data));
        var uriResponse = await client.post(
            Uri.parse("http://app.wellsunebusines"
                "s.online/WellSunWS.svc/GetAllProducts"),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
            },
            body: jsonEncode(data));
        var result = jsonDecode(uriResponse.body)["GetAllProductsResult"];
        var HasError = result["HasError"];
        if (HasError) {
          var ErrorCode = result["ErrorCode"];
          var Message = result["Messages"];
          showAlertDialog(context, Message[0].toString());
        } else {
          lstProducts = result["lstProduct"];
          setState(() {});
        }
      } finally {
        client.close();
      }
    }

    void getAllOrders(BuildContext context) async {
      var client = http.Client();
      try {
        dynamic data = {
          'EnrollNo': GetStorage().read('Username'),
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (position) => MyOrdersPage(
                      title: "Orders",
                      language: language,
                      username: mData['cEnrollNo'],
                    ),
                  ),
                );
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                                Text('+91 ' + mData['cMobile'],
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
            ),
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
            GestureDetector(
              onTap: () {},
              child: Row(children: [
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
            ),
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
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      "assets/icon/ic_menu.png",
                      height: 18,
                    ),
                  )),
              Container(
                child: Center(
                    child: Text(
                  pageTitle,
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

    Drawer getDrawerLogin(BuildContext context) {
      return Drawer(
          child: Container(
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(language: widget.language)));
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                      child: Container(
                        child: Center(
                            child: Image.asset(
                          "assets/icon/ic_profile.png",
                          fit: BoxFit.cover,
                          height: 60,
                        )),
                      )),
                  GestureDetector(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(GetStorage().read("Name"),
                                    style: TextStyle(
                                        fontFamily: getProximaNova(),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.left),
                                Text('+91 99999 87654',
                                    style: TextStyle(
                                        fontFamily: getProximaNova(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                Text(edit(language),
                                    style: TextStyle(
                                        fontFamily: getProximaNova(),
                                        fontSize: 14,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left)
                              ])))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.home;
                  pageTitle = welcome(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_home_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(14, 30, 0, 10),
                          child: Text(home(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.products;
                  pageTitle = products(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_product_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(products(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.orders;
                  pageTitle = orders(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_bag_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(orders(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.Registration;
                  pageTitle = registrations(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_user_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(registrations(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            CommonUtility().getDivider(),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.settings;
                  pageTitle = accountSettings(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_settings_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(accountSettings(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.companyProfile;
                  pageTitle = companyProfile(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_info_men.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(companyProfile(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.ContactUs;
                  pageTitle = contactUs(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_settings_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(contactUs(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            CommonUtility().getDivider(),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => LoginPagePage()));
                  });
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_logout_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(logout(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
          ],
        ),
      ));
    }

    Drawer getDrawerNoLogin(BuildContext context) {
      return Drawer(
          child: Container(
        child: ListView(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => LoginPagePage()));
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 70, 0, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Hello, Login Here',
                                style: TextStyle(
                                    fontFamily: getProximaNova(),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.left),
                          ]))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.home;
                  pageTitle = welcome(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 30, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_home_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(14, 30, 0, 10),
                          child: Text(home(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.products;
                  pageTitle = products(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_product_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(products(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.orders;
                  pageTitle = orders(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_bag_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(orders(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            CommonUtility().getDivider(),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.settings;
                  pageTitle = accountSettings(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_settings_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(accountSettings(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.companyProfile;
                  pageTitle = companyProfile(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_info_men.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(companyProfile(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
            GestureDetector(
                onTap: () {
                  selectedPage = Page.ContactUs;
                  pageTitle = contactUs(language);
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Row(children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Image.asset(
                        "assets/icon/ic_settings_menu.png",
                        height: 25,
                      )),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Text(contactUs(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start)))
                ])),
          ],
        ),
      ));
    }

    Scaffold getProductList(context, List<IconTitle> entries) {
      return Scaffold(
          key: _scaffoldKey,
          drawer: isLogin ? getDrawerLogin(context) : getDrawerNoLogin(context),
          body: Stack(children: [
            Container(
              child: ListView.builder(
                itemCount: lstProducts == null
                    ? 2
                    : 2 + (lstProducts.length / 2.0).toInt(),
                padding: EdgeInsets.fromLTRB(20, 85, 20, 25),
                itemBuilder: (BuildContext context, int index) =>
                    getProductListItem(index),
              ),
            ),
            getBottomMenu(context)
          ]));
    }

    Scaffold getRegistrationList(context, List<IconTitle> entries) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
        body: Stack(
          children: [
            Container(
              child: ListView.builder(
                itemCount: lstMyUsers == null ? 0 : lstMyUsers.length,
                padding: EdgeInsets.fromLTRB(25, 115, 25, 25),
                itemBuilder: (BuildContext context, int index) =>
                    getRegistrationItem(context, index),
              ),
            ),
            getBottomMenu(context),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: getMyAppColor(),
                          borderRadius: BorderRadius.circular(13)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextButton(
                          onPressed: () {
                            Get.to(() => StepperRegisterUserPage());
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (_) => RegisterUserPage(
                            //               language: language,
                            //             )));
                          },
                          child: Text(
                            registerUser(language),
                            style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Scaffold getCompanyProfile(context, List<IconTitle> entries) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
        body: Stack(
          children: [
            Container(
              child: ListView.builder(
                itemCount: 1,
                padding: EdgeInsets.fromLTRB(25, 115, 25, 25),
                itemBuilder: (BuildContext context, int index) =>
                    getCompanyProfileItem(context, index),
              ),
            ),
            getBottomMenu(context),
          ],
        ),
      );
    }

    Scaffold getOrdersList(context, List<IconTitle> entries) {
      return Scaffold(
          key: _scaffoldKey,
          drawer:
              (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
          body: Stack(children: [
            FutureBuilder<GetUserSalesModel>(
              future: DioProvider().getAllOrders(GetStorage().read('Username')),
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
          ]));
    }

    Scaffold getContactUsPage(context) {
      return Scaffold(
          key: _scaffoldKey,
          drawer:
              (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
          body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.fromSize(size: Size(20, 120)),
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: Text(
                      'WELLSUN E-BUSINESS',
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                          color: Colors.black),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 5),
                    child: Text(
                      'Address : 2nd Floor, Radha Swami Sumir, Lambhvel Rd, near Zydus Hospital, Purushottam Nagar, Anand, Gujarat 388001',
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(40, 5, 40, 20),
                    child: Text(
                      'Phone : 02692 297 910',
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Colors.black),
                    )),
              ],
            ),
            getBottomMenu(context)
          ]));
    }

    Scaffold getHomePage(BuildContext context) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
        body: Stack(
          children: [
            ListView(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/icon/home_info.png",
                        height: 250, width: double.infinity, fit: BoxFit.cover),
                    Positioned(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(
                              left: 30, top: 150, right: 30, bottom: 30),
                          height: 180,
                          width: 180,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                      child: Image.asset(
                                    "assets/icon/ic_splash.png",
                                    height: 120,
                                  )),
                                ),
                              ]),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: getBorderColor()),
                            borderRadius: BorderRadius.circular(28),
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
                    ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(wellsunFullName(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(), fontSize: 12),
                              textAlign: TextAlign.center)),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                              getCapitalizeString(
                                  str: wellcomeToWellsun(language)),
                              style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontFamily: getAmatic(),
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center)),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                              "Wellsun Farmer fertilizer established in 2013; our corporate office situated in Anand, Gujarat. We are one of the emerging leaders of organic fertilizer, bio pesticides and bio products in central Gujarat. We are quality assured we have ISO 9001:2008 Certificate. We provide services right from the beginning of farming which help the farmer to get their finished products on time. We offer a dynamic range of organic products for sustainable agriculture & horticulture. We just wanted to bring out the revolution in hygienic food & eco-friendly agri-products.",
                              style: TextStyle(
                                  fontFamily: getProximaNova(), fontSize: 18),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      Center(
                          child: Text(wellsunFullName(language),
                              style: TextStyle(
                                  color: Color(0xFF777777),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: getProximaNova(),
                                  fontSize: 18),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      Center(
                          child: Text(
                              "We are closely associated with our farmers and suppliers across the Country. Our products specifically address the problem related environment and the threat to human life & health which resultant of the chemical farming. Our products are bio-degradable, environment friendly; that protects the crop naturally and at the same time help to increase the crop yield.\n\nWellsun Farmer Fertilizer Pvt. Ltd is based on direct relationships between our team, our customer and our partners in India. Every process we carefully check and test on a regular basis to achieve consistency in providing excellent quality and assurance of our products. Wherever necessary, full audits of each process are carried out by our professional representative. Testing of regimes and sample is done by our bio fertilizer lab as per international standards.\n\nOur services start with the desire and requirements of a farmer from fertilizer manufacturer. These values guided us throughout every business activity done with our suppliers, our customers, and within the communities; we call home. Our results are earned by fairness, loyalty, honesty and courtesy towards our customers, employees, and society at large. We are reputed organic fertilizer manufacturer kindly give us chance to serve for you.",
                              style: TextStyle(
                                  fontFamily: getProximaNova(), fontSize: 18),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .restorablePush(_dialogBuilder);
                          },
                          child: Center(
                              child: Text(readMore(language),
                                  style: TextStyle(
                                      fontFamily: getProximaNova(),
                                      fontSize: 20,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center))),
                      CommonUtility().getDivider(),
                      Text(getCapitalizeString(str: ourMission(language)),
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontFamily: getAmatic(),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "We imagined ourselves towards healthier India. Our mission is “Poison free farming & Disease free India.”\n| विषमुक्त खेती, रोग मुक्त भारत |",
                          style: TextStyle(
                              fontFamily: getProximaNova(),
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                          textAlign: TextAlign.start),
                      CommonUtility().getDivider(),
                      Text(getCapitalizeString(str: ourVision(language)),
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontFamily: getAmatic(),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "To be a leader in agri segment that provides best agro solutions that empowers farming community and add prosperity to their lives by creating awareness.",
                          style: TextStyle(
                              fontFamily: getProximaNova(),
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start),
                      CommonUtility().getDivider(),
                      Text(getCapitalizeString(str: certificate(language)),
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontFamily: getAmatic(),
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        child: Text("Quality Management System ISO 9001:2015",
                            style: TextStyle(
                                fontFamily: getProximaNova(),
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start),
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (_) => CommonUtility.imageDialog());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            getBottomMenu(context)
          ],
        ),
      );
    }

    Scaffold getSettingsPage(BuildContext context, List<IconTitle> entries) {
      return Scaffold(
          key: _scaffoldKey,
          drawer:
              (isLogin) ? getDrawerLogin(context) : getDrawerNoLogin(context),
          body: Stack(children: [
            ListView(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            changePassword(language),
                            style: GoogleFonts.lato(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ))
                    ])),
                Divider(color: getBorderColor()),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(
                            changeLanguage(language),
                            style: GoogleFonts.lato(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ))
                    ])),
                Divider(color: getBorderColor()),
              ],
            ),
            getBottomMenu(context),
          ]));
    }

    final List<IconTitle> entries = <IconTitle>[
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
      IconTitle('', ''),
    ];
    if (selectedPage == Page.home) {
      return getHomePage(context);
    } else if (selectedPage == Page.settings) {
      return getSettingsPage(context, entries);
    } else if (selectedPage == Page.Registration) {
      if (lstMyUsers == null) getMyUsers(context);
      return getRegistrationList(context, entries);
    } else if (selectedPage == Page.companyProfile) {
      return getCompanyProfile(context, entries);
    } else if (selectedPage == Page.orders) {
      if (lstOrders == null) getAllOrders(context);
      return getOrdersList(context, entries);
    } else if (selectedPage == Page.ContactUs) {
      return getContactUsPage(context);
    } else {
      //Product
      if (lstProducts == null) getProducts(context);
      return getProductList(context, entries);
    }
  }
}

String getProduct() {
  var list = ['1.png', '2.png', '3.jpeg'];
  final _random = new Random();
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
    print('Messages : ' + Message.toString());
  } else {
    var lstSubject = result["lstSubject"];
    var firstItem = lstSubject[0];
    // GetChapters(context, firstItem['nCode'], firstItem['nCode']);
  }
}

var lstMyUsers;
var lstProducts;
var lstOrders;
