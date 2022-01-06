import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/home_module/home_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';

import '../../../main.dart';

class HomePage extends GetView<HomeController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(
        children: [
          ListView(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/icon/home_info.png",
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(
                          left: 30,
                          top: 150,
                          right: 30,
                          bottom: 30,
                        ),
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
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: getBorderColor()),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        wellsunFullName(language),
                        style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                          CommonUtility().getCapitalizeString(
                              str: wellcomeToWellsun(language)),
                          style: TextStyle(
                              letterSpacing: 2.0,
                              fontFamily: getAmatic(),
                              fontSize: 32,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(wellSunIntroOne(language),
                          style: TextStyle(
                            fontFamily: getProximaNova(),
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(wellsunFullName(language),
                          style: TextStyle(
                              color: Color(0xFF777777),
                              fontWeight: FontWeight.w700,
                              fontFamily: getProximaNova(),
                              fontSize: 18),
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        wellSunIntroTwo(language),
                        style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).restorablePush(_dialogBuilder);
                      },
                      child: Center(
                        child: Text(
                          readMore(language),
                          style: TextStyle(
                              fontFamily: getProximaNova(),
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    CommonUtility().getDivider(),
                    Text(
                      CommonUtility().getCapitalizeString(
                        str: ourMission(language),
                      ),
                      style: TextStyle(
                          letterSpacing: 2.0,
                          fontFamily: getAmatic(),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ourMissionDetails(language),
                      style: TextStyle(
                          fontFamily: getProximaNova(),
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    CommonUtility().getDivider(),
                    Text(
                        CommonUtility()
                            .getCapitalizeString(str: ourVision(language)),
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
                    Text(
                        CommonUtility()
                            .getCapitalizeString(str: certificate(language)),
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
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => CommonUtility.imageDialog(
                            url: "assets/icon/certificate.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CommonUtility()
              .getBottomMenu(context, welcome(language), _scaffoldKey)
        ],
      ),
    );
  }
}
