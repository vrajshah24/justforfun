import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/contact_us_module/contact_us_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class ContactUsPage extends GetView<ContactUsController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(
        children: [
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
          CommonUtility()
              .getBottomMenu(context, contactUs(language), _scaffoldKey)
        ],
      ),
    );
  }
}
