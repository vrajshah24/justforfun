import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:untitled/app/theme/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    bool _saving = false;
    TextEditingController emailController = new TextEditingController();

    return Scaffold(
      body: ModalProgressHUD(
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Image.asset(
                      "assets/icon/banner.png",
                      height: 120,
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    style: GoogleFonts.lato(),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: getMyAppColor())),
                        enabledBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: getMyAppColor())),
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(color: getMyAppColor())),
                        labelText: 'Mobile No.',
                        hintText: 'Enter Mobile No.'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: getMyAppColor(),
                      borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      /*Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => HomePage()));*/
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
        inAsyncCall: _saving,
      ),
    );
  }
}
