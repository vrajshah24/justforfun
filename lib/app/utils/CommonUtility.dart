import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:untitled/app/theme/app_colors.dart';

class CommonUtility {
  String getCapitalizeString({String str}) {
    if (str.length <= 1) {
      return str.toUpperCase();
    }
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  Padding getDivider() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Divider(color: getBorderColor()));
  }

  String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }

  Divider getDividerOnly(int Padding) {
    return Divider(color: getBorderColor());
  }

  Positioned getBottomMenu(BuildContext context, String pageTitle,
      GlobalKey<ScaffoldState> _scaffoldKey,
      {bool showBack = false}) {
    return Positioned(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
          height: 55,
          width: double.infinity,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  showBack
                      ? Get.back()
                      : _scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(16, 10, 10, 10),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    showBack
                        ? "assets/icon/ic_back.png"
                        : "assets/icon/ic_menu.png",
                    height: 18,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    pageTitle,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: getProximaNova(),
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ),
              )
            ],
          ),
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
          ),
        ),
      ),
    );
  }

  static const List<String> nomineeRelationList = [
    'Brother',
    'Daughter',
    'Father',
    'Grand Daughter',
    'Grand Father',
    'Grand Mother',
    'Grand Son',
    'Husband',
    'Mother',
    'Sister',
    'Son',
    'Wife',
  ];
  static const List<String> paymentTypeList = [
    'By Cheque',
    'By Bank Transfer',
    'By UPI',
  ];
  static Dialog imageDialog({url}) {
    return Dialog(
      child: Container(
        color: Colors.white,
        child: Image.asset("$url"),
      ),
    );
  }
}
