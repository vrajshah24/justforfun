import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/routes/app_pages.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/translations/app_translations.dart';

// flutter build apk --release

String language;
void main() async {
  await GetStorage.init().then((value) => runApp(MyApp()));
}

showAlertDialog(BuildContext context, String value) {
  AlertDialog alert;
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () => Navigator.pop(context),
  );

  // set up the AlertDialog
  alert = AlertDialog(
    title: Text("Wellsun Fertilizer"),
    content: Text(value),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      fallbackLocale: AppTranslation.fallbackLocale,
      translations: AppTranslation(),
      title: 'Wellsun',
      getPages: AppPages.pages,
      initialRoute:
          GetStorageProvider().isUserLogin() ? Routes.HOME : Routes.LOGIN_PAGE,
      // initialRoute: Routes.HOME,
      theme: ThemeData(
        primarySwatch: createMaterialColor(getMyAppColor()),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginPage(title: 'Wellsun'),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   LoginPage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// var _tapPosition;
// var lstBranch;
// var selectedBranch;
//
// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     bool _saving = false;
//     TextEditingController emailController =
//         new TextEditingController(text: 'web10002');
//     TextEditingController passwordController =
//         new TextEditingController(text: '123');
//
//     void _saveUser(int Code, String Mobile, String Name, String Username,
//         int StudentId, int UserType) async {
//       var storage = GetStorage();
//       storage.write('Branch', selectedBranch.toString());
//       if (Code != null) storage.write('Code', Code);
//       if (Mobile != null) storage.write('Mobile', Mobile);
//       if (Name != null) storage.write('Name', Name);
//       if (Username != null) storage.write('Username', Username);
//       if (StudentId != null) storage.write('StudentId', StudentId);
//       if (UserType != null) storage.write('UserType', UserType);
//       storage.write('is_login', true);
//     }
//
//     Future _getLanguage() async {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
//       String temp_language = prefs.getString('Language');
//
//       if (temp_language == "Hindi") {
//         language = 'हिंदी';
//       } else if (temp_language == "Gujarati") {
//         language = 'ગુજરાતી';
//       } else {
//         language = 'English';
//       }
//
//       setState(() {});
//     }
//
//     void _changeLanguage(String Language) async {
//       GetStorage().write('Language', Language);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('Language', Language);
//       _getLanguage();
//     }
//
//     if (language == '') _getLanguage();
//
//     _tapPosition = Offset(0.0, 0.0);
//
//     _showPopupMenu() async {
//       final RenderBox overlay = Overlay.of(context).context.findRenderObject();
//       await showMenu(
//         context: context,
//         position: RelativeRect.fromRect(
//             _tapPosition & Size(40, 40), Offset.zero & overlay.size),
//         items: [
//           PopupMenuItem(child: Text("English")),
//           PopupMenuItem(child: Text("हिंदी")),
//           PopupMenuItem(child: Text("ગુજરાતી")),
//         ],
//         elevation: 8.0,
//       );
//     }
//
//     void _storePosition(TapDownDetails details) {
//       _tapPosition = details.globalPosition;
//     }
//
//     void loginUser(BuildContext context, String username, String password,
//         String branch) async {
//       var client = http.Client();
//       try {
//         dynamic data = {
//           'Username': username,
//           'Password': password,
//           'BranchName': branch,
//         };
//         print("post: " + jsonEncode(data));
//         var uriResponse = await client.post(
//             Uri.parse("http://app.wellsunebusiness.online/WellSunWS.svc/Login"),
//             headers: {
//               HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
//             },
//             body: jsonEncode(data));
//         var result = jsonDecode(uriResponse.body)["LoginResult"];
//         var HasError = result["HasError"];
//         if (HasError) {
//           var ErrorCode = result["ErrorCode"];
//           var Message = result["Messages"][0];
//           showAlertDialog(context, Message.toString());
//         } else {
//           var objUser = result["objUser"];
//           int Code = objUser['Code'];
//           String Mobile = objUser['Mobile'];
//           String Name = objUser['Name'];
//           String Username = objUser['Username'];
//           int StudentId = objUser['StudentID'];
//           int UserType = objUser['UserType'];
//
//           print("user Login Success : " + objUser.toString());
//
//           _saveUser(Code, Mobile, Name, Username, StudentId, UserType);
//
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (_) => MyHomePage(
//                 language: language,
//               ),
//             ),
//           );
//         }
//       } finally {
//         client.close();
//       }
//     }
//
//     Future<String> getAllBranch(BuildContext context) async {
//       var client = http.Client();
//       try {
//         dynamic data = {};
//         var uriResponse = await client.post(
//             Uri.parse(
//                 "http://app.wellsunebusiness.online/WellSunWS.svc/GetAllBranch"),
//             headers: {
//               HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
//             },
//             body: jsonEncode(data));
//         var result = jsonDecode(uriResponse.body)["GetAllBranchResult"];
//         var HasError = result["HasError"];
//         if (HasError) {
//           var ErrorCode = result["ErrorCode"];
//           var Message = result["Messages"];
//         } else {
//           var list = List<dynamic>();
//           list = result["lstBranch"];
//           lstBranch = List<String>();
//
//           list.forEach((element) {
//             lstBranch.add(element['BranchName'].toString());
//           });
//           setState(() {});
//         }
//       } finally {
//         client.close();
//       }
//     }
//
//     if (lstBranch == null) getAllBranch(context);
//
//     return Scaffold(
//       body: Container(
//           decoration: new BoxDecoration(color: Colors.white),
//           child: ModalProgressHUD(
//             child: ListView(children: [
//               Stack(children: [
//                 GestureDetector(
//                     onTapDown: _storePosition,
//                     onTap: () {
//                       _showPopupMenu();
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(20, 20, 30, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                               child: Text(
//                             language == null ? 'English' : language,
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 fontFamily: getProximaNova(),
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF777777)),
//                           )),
//                           Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Image.asset(
//                                 "assets/icon/ic_arrow_down.png",
//                                 height: 8,
//                               )),
//                         ],
//                       ),
//                     )),
//                 GestureDetector(
//                     onTap: () {
//                       GetStorage()
//                           .erase()
//                           .then((value) => Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (_) => MyHomePage(
//                                         language: language,
//                                       ))));
//                     },
//                     child: Container(
//                         padding: EdgeInsets.fromLTRB(10, 20, 30, 0),
//                         alignment: Alignment.topRight,
//                         child: Text(
//                           skip(language),
//                           style: TextStyle(
//                               fontSize: 16,
//                               fontFamily: getProximaNova(),
//                               fontWeight: FontWeight.w700,
//                               color: getMyAppColor()),
//                         ))),
//               ]),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                         padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
//                         child: Image.asset(
//                           "assets/icon/wellsun_ebusiness.png",
//                           height: 120,
//                         )),
//                     TextButton(
//                       onPressed: () {},
//                       child: Container(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                               padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
//                               child: Text(
//                                 gettingStarted(language),
//                                 style: TextStyle(
//                                     fontFamily: getProximaNova(),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                     color: Colors.black),
//                               ))),
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                             height: 3,
//                             width: 25,
//                             child: Padding(
//                                 padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                                 child: Text(
//                                   '',
//                                 ))),
//                         Container(
//                           height: 3,
//                           width: 20,
//                           color: getLineColor(),
//                           child: Padding(
//                             padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                             child: Text(
//                               '',
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     getTextField(username(language), emailController,
//                         "assets/icon/ic_email.png"),
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Color(0xFFEEF1F8),
//                             borderRadius: BorderRadius.circular(13)),
//                         child: Row(children: [
//                           Container(
//                             width: 16,
//                           ),
//                           Image.asset(
//                             "assets/icon/ic_password.png",
//                             width: 25,
//                           ),
//                           Container(
//                             height: 25,
//                             margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
//                             color: Color(0xFF979797),
//                             width: 1,
//                           ),
//                           Expanded(
//                               child: Container(
//                                   width: double.infinity,
//                                   child: TextFormField(
//                                       style: TextStyle(
//                                         fontFamily: getProximaNova(),
//                                         fontSize: 16,
//                                       ),
//                                       controller: passwordController,
//                                       decoration: InputDecoration(
//                                           hintText: password(language),
//                                           filled: true,
//                                           fillColor: Color(0xFFEEF1F8),
//                                           focusColor: Color(0xFFEEF1F8),
//                                           enabledBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                               borderSide: new BorderSide(
//                                                   color: Color(0xFFEEF1F8))),
//                                           focusedBorder: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                               borderSide: new BorderSide(
//                                                   color: Color(0xFFEEF1F8))),
//                                           border: OutlineInputBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                               borderSide: new BorderSide(
//                                                   color: Color(0xFFEEF1F8)))))))
//                         ]),
//                       ),
//                     ),
//                     getPopupButton(selectBranch(language), selectedBranch,
//                         lstBranch == null ? [''] : lstBranch, (value) {
//                       selectedBranch = value;
//                       setState(() {});
//                       return value;
//                     }),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) =>
//                                     ForgotPasswordPage(language: language)));
//                       },
//                       child: Container(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                               padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
//                               child: Text(
//                                 forgotPwd(language),
//                                 style: TextStyle(
//                                     fontFamily: getProximaNova(),
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 16,
//                                     color: Color(0xFF777777)),
//                               ))),
//                     ),
//                     Container(
//                       height: 50,
//                       width: 200,
//                       decoration: BoxDecoration(
//                           color: getMyAppColor(),
//                           borderRadius: BorderRadius.circular(13)),
//                       child: TextButton(
//                         onPressed: () {
//                           loginUser(context, emailController.text,
//                               passwordController.text, selectedBranch);
//                         },
//                         child: Text(
//                           login(language),
//                           style: TextStyle(
//                               fontFamily: getProximaNova(),
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => RegistrationPage(
//                                       language: language,
//                                     )));
//                       },
//                       child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               notAUser(language) + ' ',
//                               style: TextStyle(
//                                   fontFamily: getProximaNova(),
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16,
//                                   color: Colors.black),
//                             ),
//                             Text(
//                               registerNow(language),
//                               style: TextStyle(
//                                   fontFamily: getProximaNova(),
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 15,
//                                   color: getMyAppColor()),
//                             )
//                           ]),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//             inAsyncCall: _saving,
//           )),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   HomePage({Key key, this.title, this.language}) : super(key: key);
//
//   final String title;
//   final String language;
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }

class IconTitle {
  String title;
  String icon;

  IconTitle(String title, String icon) {
    this.title = title;
    this.icon = icon;
  }
}

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     void choiceAction(String choice) {
//       if (choice == Constants.fund) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => ProfileScreen(
//               title: "My Profile",
//             ),
//           ),
//         );
//       } else if (choice == Constants.notification) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HomePage(
//               title: "Notifications",
//             ),
//           ),
//         );
//       } else if (choice == Constants.SignOut) {
//         // Navigator.pushReplacement(
//         //     context, MaterialPageRoute(builder: (_) => LoginPage()));
//       }
//     }
//
//     final List<IconTitle> entries = <IconTitle>[];
//
//     return Scaffold(
//         appBar: AppBar(
//             automaticallyImplyLeading: false,
//             // Here we take the value from the MyHomePage object that was created by
//             // the App.build method, and use it to set our appbar title.
//             title: Text("Home", style: GoogleFonts.andika()),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: choiceAction,
//                 itemBuilder: (BuildContext context) {
//                   return Constants.choices.map((String choice) {
//                     return PopupMenuItem<String>(
//                       value: choice,
//                       child: Text(
//                         choice,
//                         style: GoogleFonts.lato(),
//                       ),
//                     );
//                   }).toList();
//                 },
//               )
//             ]),
//         body: Stack(children: [
//           Container(
//               height: double.infinity,
//               width: double.infinity,
//               child: Image.asset(
//                 'assets/icon/school_building.jpg',
//                 fit: BoxFit.cover,
//               )),
//           Container(
//             height: double.infinity,
//             width: double.infinity,
//             color: Colors.white60,
//           ),
//           Container(
//             decoration: BoxDecoration(color: Colors.white24),
//             child: GridView.count(
//               crossAxisCount: 3,
//               childAspectRatio: (1 / 1),
//               crossAxisSpacing: 25,
//               mainAxisSpacing: 25,
//               //physics:BouncingScrollPhysics(),
//               padding: EdgeInsets.all(25),
//               children: entries
//                   .map(
//                     (data) => GestureDetector(
//                         onTap: () {
//                           if (data.title == "Query") {
//                             print(data.icon);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => QueryPage(
//                                           title: "Query",
//                                         )));
//                           } else {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (position) =>
//                                         HomePage(title: data.title)));
//                           }
//                         },
//                         child: Container(
//                             padding: const EdgeInsets.fromLTRB(10, 16, 10, 2),
//                             // margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                             // color:data.color,
//                             color: getMyAppColor(),
//                             child: Column(
//                               children: [
//                                 Image.asset(
//                                   "assets/icon/" + data.icon + ".png",
//                                   width: 30,
//                                   color: Colors.white,
//                                 ),
//                                 Expanded(
//                                     child: Center(
//                                         child: Text(data.title,
//                                             style: GoogleFonts.lato(
//                                                 fontSize: 12,
//                                                 color: Colors.white),
//                                             textAlign: TextAlign.center)))
//                               ],
//                             ))),
//                   )
//                   .toList(),
//             ),
//           )
//         ]));
//   }
// }
