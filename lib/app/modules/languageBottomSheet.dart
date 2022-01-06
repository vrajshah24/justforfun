import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/modules/splash_module/splash_page.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({Key key}) : super(key: key);

  @override
  _LanguageBottomSheetState createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String _groupValue = 'en';
  String langValue = GetStorageProvider().getLanguageCode();

  _readLocalStorage() {
    if (langValue == 'en') {
      _groupValue = "en";
    } else if (langValue == 'hi') {
      _groupValue = 'hi';
    } else {
      _groupValue = 'gu';
    }
  }

  @override
  void initState() {
    _readLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.1,
                  color: Colors.black38,
                  child: Align(alignment: Alignment.center, child: Text(""))),
            ),
          ),
          Container(height: MediaQuery.of(context).size.height * 0.02),
          Center(
            child: Text(
              changeLanguage(language),
              textAlign: TextAlign.center,
              style:
                  new TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0),
            ),
          ),
          //
          Container(height: MediaQuery.of(context).size.height * 0.02),
          //
          RadioListTile(
            value: 'en',
            groupValue: _groupValue,
            title: Text("English"),
            onChanged: (newValue) {
              _groupValue = newValue;
              setState(() {});
            },
            selected: false,
          ),
          //
          RadioListTile(
            value: 'hi',
            groupValue: _groupValue,
            title: Text("हिंदी"),
            onChanged: (newValue) {
              _groupValue = newValue;
              setState(() {});
            },
            selected: false,
          ),
          //
          RadioListTile(
            value: 'gu',
            groupValue: _groupValue,
            title: Text("ગુજરાતી"),
            onChanged: (newValue) {
              _groupValue = newValue;
              setState(() {});
            },
            selected: false,
          ),
          //
          ListTile(
            title: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text(save(language)),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(2),
                ),
                onPressed: () {
                  // progressDialogue(context);
                  GetStorageProvider().setLanguage(_groupValue);
                  // Get.resetRootNavigator();
                  Get.offAll(() => SplashPage());
                  Get.clearRouteTree();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  progressDialogue(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
