import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/l10n.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.title, this.language}) : super(key: key);
  final String title;
  final String language;

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final List<IconTitle> entries = <IconTitle>[
      IconTitle('', ''),
      IconTitle(fullName(widget.language), 'Sonia A Gandhi'),
      IconTitle(referenceId(widget.language), 'WEB001'),
      IconTitle(
          address(widget.language), 'House No. 1773,\nStreet 2003,\nGermany'),
      IconTitle(gender(widget.language), 'Female'),
      IconTitle(fieldSupportId(widget.language), 'WEB001'),
      IconTitle(city(widget.language), 'Berlin'),
      IconTitle(joinDate(widget.language), '08/02/2021'),
      IconTitle(aadharNo(widget.language), '1183 3323 4499'),
      IconTitle(pincode(widget.language), '837492'),
      IconTitle(designation(widget.language), 'Distributor'),
      IconTitle(PANNo(widget.language), 'FNDPS7384J'),
      IconTitle(taluka(widget.language), 'N/A'),
      IconTitle(district(widget.language), 'N/A'),
      IconTitle(state(widget.language), 'Berlin A.'),
      IconTitle(birthDate(widget.language), '08/03/2001'),
      IconTitle(nominee(widget.language), 'Rahul S Gandhi'),
      IconTitle(mobileNo(widget.language), '92 3445 72434'),
      IconTitle(branchName(widget.language), 'Germany'),
      IconTitle(nomineeRelation(widget.language), 'Mother'),
      IconTitle(whatsappNo(widget.language), '89 3422 29451'),
      IconTitle(AcNo(widget.language), '8344229240'),
      IconTitle(emailId(widget.language), 'sonia1399@gmail.com'),
      IconTitle(ifsc(widget.language), 'IFIFI4022R'),
      IconTitle(kit(widget.language), 'Test Item 01'),
      IconTitle(PaymentDate(widget.language), '12/01/2021'),
      IconTitle(Note(widget.language), 'CHQ Recd.'),
      IconTitle(KitPrice(widget.language), '32,000'),
      IconTitle(PaymentType(widget.language), 'CHEQUE'),
    ];

    return Scaffold(
        body: Container(
      child: ModalProgressHUD(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                                padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                                child: Image.asset(
                                  "assets/icon/ic_profile.png",
                                  height: 100,
                                ));
                          } else {
                            return getItem(
                                entries[index], widget.title, context);
                          }
                        }),
                  ),
                ],
              ),
            ),
            getBottomMenu(context)
          ],
        ),
        inAsyncCall: _saving,
      ),
    ));
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
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/icon/ic_back.png",
                  height: 20,
                ),
              )),
          Container(
            child: Center(
                child: Text(
              profile(language),
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

Container getItem(IconTitle data, String type, BuildContext context) {
  if (data.title == "Guardian's photo") {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(children: [
        Row(
          children: [
            Container(
                child: Text(data.title,
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 14,
                        color: getMyAppColor(),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start)),
          ],
        ),
      ]),
    );
  } else {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 16, 32, 4),
      child: Column(children: [
        Row(
          children: [
            Container(
                child: Text(data.title,
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 14,
                        color: getMyAppColor(),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start)),
          ],
        ),
        Row(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                child: Text(data.icon,
                    style: TextStyle(
                        fontFamily: getProximaNova(),
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.start)),
          ],
        ),
      ]),
    );
  }
}

class MyData {
  String name;
  String url;

  MyData(String name, String url) {
    this.name = name;
    this.url = url;
  }

  MyData.fromJson(Map<String, dynamic> json)
      : name = json['Username'],
        url = json['Password'];

  Map<String, dynamic> toJson() {
    return {
      'Username': name,
      'Password': url,
    };
  }
}

class LoginResult {
  int ErrorCode;
  bool HasError;

  LoginResult(int ErrorCode, bool HasError) {
    this.ErrorCode = ErrorCode;
    this.HasError = HasError;
  }

  LoginResult.fromJson(Map<String, dynamic> json)
      : ErrorCode = json['ErrorCode'],
        HasError = json['HasError'];

  Map<String, dynamic> toJson() {
    return {
      'ErrorCode': ErrorCode,
      'HasError': HasError,
    };
  }
}
