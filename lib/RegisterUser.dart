// // import 'package:flutter/material.dart';

// // class RegisterUserPage extends StatefulWidget {
// //   const RegisterUserPage({@required key}) : super(key: key);

// //   @override
// //   _RegisterUserPageState createState() => _RegisterUserPageState();
// // }

// // class _RegisterUserPageState extends State<RegisterUserPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: TextFormField(
// //         decoration: const InputDecoration(
// //           icon: Icon(Icons.person),
// //           hintText: "Name *",
// //           labelText: "name *",
// //           labelStyle: TextStyle(color: Color(0xffff0000)),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/route_manager.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:untitled/app/data/provider/DioProvider.dart';
// import 'package:untitled/app/data/provider/GetStorage.dart';
// import 'package:untitled/app/data/repository/registerResponseModel.dart';
// import 'package:untitled/app/theme/app_colors.dart';
// import 'package:untitled/app/utils/CommonUtility.dart';
// import 'package:untitled/generated/assets.dart';
// import 'package:untitled/main.dart';
// import 'package:untitled/registration.dart';

// import 'app/utils/strings.dart';
// import 'l10n.dart';

// class RegisterUserPage extends StatefulWidget {
//   RegisterUserPage({Key key, this.title, this.language}) : super(key: key);

//   final String title;
//   final String language;

//   @override
//   _RegisterUserPageState createState() => _RegisterUserPageState();
// }

// class _RegisterUserPageState extends State<RegisterUserPage> {
//   static Route<Object> _dialogBuilder(BuildContext context, Object arguments) {
//     return DialogRoute<void>(
//       context: context,
//       builder: (BuildContext context) => const AlertDialog(
//           title: Text('WELLSUB EBUSINESS'),
//           content: Text(
//               'Congratulations, New user has been added under your contribution.')),
//     );
//   }

//   TextEditingController photoUploadController =
//       new TextEditingController(text: "Photo");
//   TextEditingController phoneNoController = new TextEditingController();
//   TextEditingController aadharCardUploadController =
//       new TextEditingController();
//   TextEditingController fullnameController = new TextEditingController();
//   TextEditingController referenceIdController = new TextEditingController(
//       text: GetStorageProvider().getDataByName(GetStorageProvider.USER_NAME));
//   TextEditingController addressController = new TextEditingController();
//   TextEditingController genderController = new TextEditingController();
//   TextEditingController fieldSupportController = new TextEditingController();
//   TextEditingController cityController = new TextEditingController();
//   TextEditingController joinDateController =
//       new TextEditingController(text: dateTimeToString(DateTime.now()));
//   TextEditingController aadharNoController = new TextEditingController();
//   TextEditingController panNoController = new TextEditingController();
//   TextEditingController pinCodeController = new TextEditingController();
//   // TextEditingController designationController = new TextEditingController();
//   TextEditingController talukaController = new TextEditingController();
//   TextEditingController districtController = new TextEditingController();
//   TextEditingController stateController = new TextEditingController();
//   TextEditingController birthDateController = new TextEditingController();
//   TextEditingController bankNameController = new TextEditingController();
//   TextEditingController nomineeController = new TextEditingController();
//   TextEditingController mobileNoController = new TextEditingController();
//   TextEditingController branchNameController = new TextEditingController();
//   TextEditingController nomineeRelationController = new TextEditingController();
//   TextEditingController whatsAppController = new TextEditingController();
//   TextEditingController acNoController = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();
//   TextEditingController IFSCconroller = new TextEditingController();
//   TextEditingController kitController = new TextEditingController();
//   TextEditingController paymentDateController =
//       new TextEditingController(text: dateTimeToString(DateTime.now()));
//   TextEditingController noteController = new TextEditingController();
//   TextEditingController kitPriceController = new TextEditingController();
//   TextEditingController paymentTypeController = new TextEditingController();
//   TextEditingController paymentReceiptController = new TextEditingController();

//   void loginUser(BuildContext context) async {
//     if (fullnameController.text.isEmpty) {
//       showAlertDialog(context, "* Ac No. required.");
//     } else if (addressController.text.isEmpty) {
//       showAlertDialog(context, "* Address required.");
//     } else if (genderController.text.isEmpty) {
//       showAlertDialog(context, "* Gender required.");
//     } else if (cityController.text.isEmpty) {
//       showAlertDialog(context, "* Address required.");
//     } else if (joinDateController.text.isEmpty) {
//       showAlertDialog(context, "* Join Date required.");
//     } else if (aadharNoController.text.isEmpty) {
//       showAlertDialog(context, "* Aadhar No. required.");
//     } else if (pinCodeController.text.isEmpty) {
//       showAlertDialog(context, "* Pincode required.");
//     } else if (panNoController.text.isEmpty) {
//       showAlertDialog(context, "* PAN No required.");
//     } else if (talukaController.text.isEmpty) {
//       showAlertDialog(context, "* Taluka required.");
//     } else if (stateController.text.isEmpty) {
//       showAlertDialog(context, "* State required.");
//     } else if (birthDateController.text.isEmpty) {
//       showAlertDialog(context, "* Birth date required.");
//     } else if (whatsAppController.text.isEmpty) {
//       showAlertDialog(context, "* WhatsApp number is required.");
//     } else if (mobileNoController.text.isEmpty) {
//       showAlertDialog(context, "* mobileNo is required.");
//     } else {
//       var data = {
//         'nCode': 0,
//         'nBranchId': 1,
//         'dEntDate': "nCode",
//         'dJoiningDate': joinDateController.text,
//         'nEnrollNo': null,
//         'cEnrollNo': null,
//         'nIntroEnrollNo': null,
//         'nSrZoEnrollNo': null,
//         'cSoDoWoName': null,
//         'cAdharNo': aadharNoController.text,
//         'cPanNo': panNoController.text,
//         'dDOB': birthDateController.text,
//         'cAdd': addressController.text,
//         'cName': fullnameController.text,
//         'reference': null,
//         'Address': addressController.text,
//         'Gender': genderController.text,
//         'nFieldSupportNo': fieldSupportController.text,
//         'cCity': cityController.text,
//         'cPincode': pinCodeController.text,
//         'cPhNo': phoneNoController.text,
//         'cMobile': mobileNoController.text,
//         'cWhatsapp': whatsAppController.text,
//         'cEmail': emailController.text,
//         'cBankName': bankNameController.text,
//         'cAcNo': acNoController.text,
//         'cBranch': branchNameController.text,
//         'cIFSC': IFSCconroller.text,
//         'cNominee': nomineeController.text,
//         'cRelation': nomineeRelationController.text,
//         'dNomineeDOB': null,
//         'cPhoto': photoUploadController.text,
//         'nCompCode': null,
//         'nRankCode': 1,
//         'nItemId': 1,
//         'nActive': 1,
//         'Em': 1,
//         'cTaluka': talukaController.text,
//         'cDistrict': districtController.text,
//         'nApprovalStatus': 0,
//         'cAadharcard': aadharNoController.text,
//         'cPassword': "",
//         'nPrice': kitPriceController.text,
//         'cNote': noteController.text,
//       };

//       RegisterResponseModel registerResponseModel =
//           await DioProvider().registerUser(data);
//       await DioProvider()
//           .uploadImage(FTP_ADHAR_CARD_URL, addressController.text);
//       await DioProvider()
//           .uploadImage(FTP_PHOTO_URL, photoUploadController.text);
//       await DioProvider()
//           .uploadImage(FTP_PHOTO_URL, paymentReceiptController.text);

//       if (registerResponseModel != null) {
//         if (registerResponseModel.registerAgencyResult.hasError) {
//           showAlertDialog(
//               context,
//               registerResponseModel.registerAgencyResult.messages[0]
//                   .toString());
//         } else {
//           Navigator.of(context).restorablePush(_dialogBuilder);
//         }
//       } else {
//         showAlertDialog(context, "something went wrong please try again");
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           ListView(children: [
//             Padding(
//               padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   TextButton(
//                     onPressed: () {},
//                     child: Container(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
//                         child: Text(
//                           registerUser(
//                             widget.language,
//                           ),
//                           style: TextStyle(
//                             fontFamily: getProximaNova(),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         height: 2,
//                         width: 25,
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
//                           child: Text(
//                             '',
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 2,
//                         width: 20,
//                         color: getLineColor(),
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//                           child: Text(
//                             '',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   //fullName
//                   getTextField(
//                     fullName(widget.language),
//                     fullnameController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //refId
//                   getTextField(
//                     referenceId(widget.language),
//                     referenceIdController,
//                     "assets/icon/ic_fullname.png",
//                     isReadOnlyVal: true,
//                   ),
//                   //Address
//                   getTextField(
//                     address(widget.language),
//                     addressController,
//                     "assets/icon/ic_fullname.png",
//                     maxLines: 3,
//                     minLines: 3,
//                   ),
//                   //Gender
//                   getPopupButton(gender(widget.language), genderController, [
//                     'Male',
//                     'Female',
//                   ], (value) {
//                     genderController.text = value;
//                     setState(() {
//                       genderController.text = value;
//                     });
//                     return value;
//                   }),
//                   //fieldSupportId
//                   getTextField(
//                     fieldSupportId(widget.language),
//                     fieldSupportController,
//                     "assets/icon/ic_fullname.png",
//                     onChangedData: (String value) {
//                       print("object$value");
//                     },
//                   ),
//                   //City
//                   getTextField(
//                     city(widget.language),
//                     cityController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //JoinDate
//                   getDatePicker(
//                     this,
//                     joinDate(widget.language),
//                     joinDateController,
//                   ),
//                   //AdaharCard
//                   getTextField(
//                     aadharNo(widget.language),
//                     aadharNoController,
//                     "assets/icon/ic_fullname.png",
//                     maxLength: 12,
//                     keyboardType: TextInputType.number,
//                   ),
//                   //Pincode
//                   getTextField(
//                     pincode(widget.language),
//                     pinCodeController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   // //Destination
//                   // getTextField(
//                   //   designation(widget.language),
//                   //   designationController,
//                   //   "assets/icon/ic_fullname.png",
//                   // ),
//                   //Pancard
//                   getTextField(
//                     PANNo(widget.language),
//                     panNoController,
//                     "assets/icon/ic_fullname.png",
//                     maxLength: 10,
//                   ),
//                   //Taluka
//                   getTextField(
//                     taluka(widget.language),
//                     talukaController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //district
//                   getTextField(
//                     district(widget.language),
//                     districtController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //state
//                   getTextField(
//                     state(widget.language),
//                     stateController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   SizedBox.fromSize(
//                     size: Size(
//                       20,
//                       20,
//                     ),
//                   ),
//                   //OtherDetails
//                   Text(
//                     CommonUtility().getCapitalizeString(
//                         str: otherDetails(widget.language)),
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF777777),
//                     ),
//                   ),
//                   //BirthDate
//                   getDatePicker(
//                     this,
//                     birthDate(widget.language),
//                     birthDateController,
//                   ),
//                   //BankName
//                   getTextField(
//                     bankName(widget.language),
//                     bankNameController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //nominee
//                   getTextField(
//                     nominee(widget.language),
//                     nomineeController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //mobileno
//                   getTextField(
//                     mobileNo(widget.language),
//                     mobileNoController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //branchNO
//                   getTextField(
//                     branchName(widget.language),
//                     branchNameController,
//                     "assets/icon/ic_fullname.png",
//                   ),
//                   //nominee
//                   getPopupButton(nomineeRelation(widget.language),
//                       nomineeRelationController, [
//                     'Brother',
//                     'Daughter',
//                     'Father',
//                     'Grand Daughter',
//                     'Grand Father',
//                     'Grand Mother',
//                     'Grand Son',
//                     'Husband',
//                     'Mother',
//                     'Sister',
//                     'Son',
//                     'Wife',
//                   ], (value) {
//                     // selectedBranch = value;
//                     setState(() {});
//                     return value;
//                   }),
//                   //whatsAppno
//                   getTextField(
//                     whatsappNo(widget.language),
//                     whatsAppController,
//                     '',
//                     maxLength: 10,
//                   ),
//                   //accountNumber
//                   getTextField(
//                     AcNo(widget.language),
//                     acNoController,
//                     '',
//                   ),
//                   //Photo
//                   getImagePicker(
//                     photoUpload(widget.language),
//                     photoUploadController,
//                     'Photo',
//                     () {},
//                   ),
//                   //EMail
//                   getTextField(
//                     email(widget.language),
//                     emailController,
//                     '',
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   getTextField(
//                     ifsc(widget.language),
//                     IFSCconroller,
//                     '',
//                   ),
//                   getImagePicker(aadharCardUpload(widget.language),
//                       aadharCardUploadController, '', () {
//                     setState(() {});
//                   }),
//                   getPopupButton(selectKit(widget.language), kitController, [
//                     'Soil Carbon',
//                     'Test Item 1',
//                     'Test Item 4',
//                     'Test Item 6'
//                   ], (value) {
//                     //selectedBranch = value;
//                     setState(() {});
//                     return value;
//                   }),
//                   getDatePicker(
//                     this,
//                     PaymentDate(widget.language),
//                     paymentDateController,
//                   ),
//                   getTextField(
//                     Note(widget.language),
//                     noteController,
//                     '',
//                     maxLines: 3,
//                     minLines: 3,
//                   ),
//                   getTextField(
//                     KitPrice(widget.language),
//                     kitPriceController,
//                     '',
//                   ),
//                   getPopupButton(
//                       PaymentType(widget.language),
//                       paymentTypeController,
//                       ['By Cheque', 'By Bank Transfer', 'By UPI'], (value) {
//                     //selectedBranch = value;
//                     setState(() {});
//                     return value;
//                   }),
//                   //paymentReceipt
//                   getImagePicker(
//                     photoUpload(widget.language),
//                     paymentReceiptController,
//                     'Photo',
//                     () => setState(() {}),
//                   ),
//                   getTextField(ViewUpiDetails(widget.language), null, '',
//                       tap: () => showDialog(
//                             context: context,
//                             builder: (_) => CommonUtility.imageDialog(
//                                 url: Assets.assetsUpi),
//                           ),
//                       isReadOnlyVal: true),
//                   Padding(
//                     padding: EdgeInsets.all(30),
//                     child: Container(
//                       height: 50,
//                       width: 200,
//                       decoration: BoxDecoration(
//                           color: getMyAppColor(),
//                           borderRadius: BorderRadius.circular(13)),
//                       child: TextButton(
//                         onPressed: () {
//                           /*Navigator.of(context).restorablePush(_dialogBuilder);*/
//                           loginUser(context);
//                         },
//                         child: Text(
//                           save(widget.language),
//                           style: TextStyle(
//                               fontFamily: getProximaNova(),
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                               color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(padding: EdgeInsets.all(10))
//                 ],
//               ),
//             ),
//           ]),
//           Container(
//             height: 100,
//             color: Colors.white,
//             width: double.infinity,
//           ),
//           Container(
//             margin: EdgeInsets.only(left: 30, top: 50, right: 30, bottom: 30),
//             height: 55,
//             width: double.infinity,
//             child: Stack(
//               children: [
//                 Container(
//                     child: GestureDetector(
//                       onTap: () => Get.back(),
//                       child: Image.asset(
//                         "assets/icon/ic_back.png",
//                         width: 20,
//                       ),
//                     ),
//                     padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                     alignment: Alignment.centerLeft),
//                 Center(
//                   child: Text(
//                     registerUser(widget.language),
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontFamily: getProximaNova(),
//                         fontWeight: FontWeight.w700,
//                         fontSize: 20,
//                         color: Colors.black),
//                   ),
//                 )
//               ],
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(13),
//               border: Border.all(color: getBorderColor()),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.2),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Padding getTextField(String hint, var controller, String icon,
//     {GestureTapCallback tap,
//     bool isReadOnlyVal = false,
//     TextInputType keyboardType,
//     int minLines = 1,
//     int maxLines = 1,
//     var maxLength,
//     ValueChanged<String> onChangedData}) {
//   return Padding(
//     padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//     child: Container(
//       decoration: BoxDecoration(
//           color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(13)),
//       child: Row(
//         children: [
//           Container(
//             width: 16,
//           ),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               child: TextFormField(
//                 onTap: tap,
//                 onChanged: onChangedData,
//                 maxLines: maxLines,
//                 minLines: minLines,
//                 maxLength: maxLength,
//                 keyboardType: keyboardType,
//                 buildCounter: (BuildContext context,
//                         {int currentLength, int maxLength, bool isFocused}) =>
//                     null,
//                 readOnly: isReadOnlyVal,
//                 style: TextStyle(
//                   fontFamily: getProximaNova(),
//                   fontSize: 16,
//                 ),
//                 controller: controller,
//                 decoration: InputDecoration(
//                   labelText: "* " + hint,
//                   hintText: hint,
//                   filled: true,
//                   fillColor: Color(0xFFEEF1F8),
//                   focusColor: Color(0xFFEEF1F8),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(13),
//                     borderSide: new BorderSide(
//                       color: Color(
//                         0xFFEEF1F8,
//                       ),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(13),
//                     borderSide: new BorderSide(
//                       color: Color(
//                         0xFFEEF1F8,
//                       ),
//                     ),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(
//                       13,
//                     ),
//                     borderSide: new BorderSide(
//                       color: Color(
//                         0xFFEEF1F8,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }

// Padding getImagePicker(String hint, var controller, String icon,
//     final VoidCallback myVoidCallback) {
//   final ImagePicker _picker = ImagePicker();

//   void pickImage() async {
//     print('waiting');
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     // controller.text = pickedFile.name;
//     controller.text = pickedFile.path;
//     myVoidCallback();
//   }

//   return Padding(
//       padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//       child: GestureDetector(
//         onTap: () {
//           pickImage();
//         },
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xFFEEF1F8),
//               borderRadius: BorderRadius.circular(13)),
//           child: Row(children: [
//             Container(
//               width: 16,
//             ),
//             Expanded(
//                 child: Container(
//                     width: double.infinity,
//                     child: Padding(
//                       child: Text(
//                         controller.text,
//                         style: TextStyle(
//                           fontFamily: getProximaNova(),
//                           fontSize: 16,
//                         ),
//                         // controller: controller,
//                         /*decoration: InputDecoration(
//                             hintText: hint,
//                             filled: true,
//                             fillColor: Color(0xFFEEF1F8),
//                             focusColor: Color(0xFFEEF1F8),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(13),
//                                 borderSide:
//                                     new BorderSide(color: Color(0xFFEEF1F8))),
//                             focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(13),
//                                 borderSide:
//                                     new BorderSide(color: Color(0xFFEEF1F8))),
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(13),
//                                 borderSide: new BorderSide(
//                                     color: Color(0xFFEEF1F8))))*/
//                       ),
//                       padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
//                     )))
//           ]),
//         ),
//       ));
// }

// Padding getPopupButton(String hint, var controller, Iterable<String> items1,
//     StringValue callback) {
//   print("controller" + controller.toString());

//   return Padding(
//     padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//     child: Container(
//       decoration: BoxDecoration(
//           color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(13)),
//       child: Row(children: [
//         SizedBox(width: 16),
//         Expanded(
//             child: Container(
//                 width: double.infinity,
//                 child: DropdownButton<String>(
//                   value: controller.text == '' ? null : controller.text,
//                   // borderRadius: BorderRadius.zero,
//                   isExpanded: true,
//                   icon: SizedBox(width: 0),
//                   underline: SizedBox(height: 0),
//                   hint: new Text(
//                     hint,
//                     style: TextStyle(
//                       fontFamily: getProximaNova(),
//                       fontSize: 16,
//                     ),
//                   ),
//                   style: TextStyle(
//                       fontFamily: getProximaNova(),
//                       fontSize: 16,
//                       color: Colors.black),
//                   items: items1.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: new Text(
//                         value,
//                         style: TextStyle(
//                           fontFamily: getProximaNova(),
//                           fontSize: 16,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (selected) {
//                     controller.text = selected;
//                     callback(selected.toString());
//                   },
//                 ))),
//         Image.asset(
//           "assets/icon/ic_arrow_down.png",
//           height: 8,
//         ),
//         SizedBox(width: 20),
//       ]),
//     ),
//   );
// }

// String dateTimeToString(DateTime dateTime) {
//   String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
//   return formattedDate;
// }

// DateTime startDate = DateTime(1950);
// DateTime endDate = DateTime(2050);

// GestureDetector getDatePicker(
//     _RegisterUserPageState state, String hint, var controller) {
//   _selectedDate(BuildContext context, DateTime selectedTime) async {
//     var datetime = await showDatePicker(
//         context: context,
//         initialDate: selectedTime,
//         firstDate: startDate,
//         lastDate: endDate);
//     controller.text = dateTimeToString(datetime);
//   }

//   return GestureDetector(
//       onTap: () {
//         _selectedDate(state.context, DateTime.now());
//       },
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//         child: Container(
//           decoration: BoxDecoration(
//               color: Color(0xFFEEF1F8),
//               borderRadius: BorderRadius.circular(13)),
//           child: Row(children: [
//             SizedBox(width: 16),
//             Expanded(
//                 child: Container(
//               width: double.infinity,
//               child: TextFormField(
//                   enabled: false,
//                   style: TextStyle(
//                     fontFamily: getProximaNova(),
//                     fontSize: 16,
//                   ),
//                   controller: controller,
//                   decoration: InputDecoration(
//                       hintText: hint,
//                       filled: true,
//                       fillColor: Color(0xFFEEF1F8),
//                       focusColor: Color(0xFFEEF1F8),
//                       disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(13),
//                           borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(13),
//                           borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
//                       focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(13),
//                           borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(13),
//                           borderSide:
//                               new BorderSide(color: Color(0xFFEEF1F8))))),
//             )),
//             Image.asset(
//               "assets/icon/ic_arrow_down.png",
//               height: 8,
//             ),
//             SizedBox(width: 20),
//           ]),
//         ),
//       ));
// }
