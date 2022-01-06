import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/company_profile_module/company_profile_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class CompanyProfilePage extends GetView<CompanyProfileController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(
        children: [
          Container(
            child: ListView(children: [
              Column(
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
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert1.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert2.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert3.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert4.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert5.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert6.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    child: Image.asset(
                      "assets/icon/cert7.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ], padding: EdgeInsets.fromLTRB(25, 115, 25, 25)),
          ),
          CommonUtility()
              .getBottomMenu(context, companyProfile(language), _scaffoldKey),
        ],
      ),
    );
  }
}
