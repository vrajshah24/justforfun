import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/data/repository/GetAllProductsResultModel.dart';
import 'package:untitled/app/data/repository/LoginModel.dart';
import 'package:untitled/screens/ApiTrial.dart';
import 'package:untitled/app/modules/login_page_module/login_page_controller.dart';
import 'package:untitled/screens/ProfileScreen.dart';
import 'package:select_form_field/select_form_field.dart';

class StepperRegisterUserPage extends StatefulWidget {
  String uname;
  StepperRegisterUserPage({this.uname});
  @override
  _StepperRegisterUserPageState createState() =>
      _StepperRegisterUserPageState();
}

class _StepperRegisterUserPageState extends State<StepperRegisterUserPage> {
  GetStorage r = GetStorage();
  InputDecoration i = InputDecoration();
  //for storing the saved user in order to pass the response to the api
  String userlogin;
  //choice is for the price item
  String choice;
  var _formkey = GlobalKey<FormState>();
  final GetStorage letsee = GetStorage();
  DateTime selecteddate = DateTime.now();
  TextEditingController _addresscontroller = TextEditingController();
  TextEditingController _citycontroller = TextEditingController();
  TextEditingController _pincodecontroller = TextEditingController();
  TextEditingController _phnocontroller = TextEditingController();
  TextEditingController _whatsappcontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _ifsccontroller = TextEditingController();
  TextEditingController _nomineecontroller = TextEditingController();
  TextEditingController _talukacontroller = TextEditingController();
  TextEditingController _districtcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _aadharcontroller = TextEditingController();
  TextEditingController _pannocontroller = TextEditingController();
  TextEditingController _fieldsupportid = TextEditingController();
  TextEditingController _statecontroller = TextEditingController();
  Future<void> _pickdate(BuildContext context) async {
    final DateTime selectdate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2050));
    if (selectdate != null && selectdate != selecteddate)
      setState(() {
        selecteddate = selectdate;
      });
  }

  String dropdownvalue = "";
  final List<Map<String, dynamic>> items = [
    {'value': 'Brother'},
    {'value': 'Daughter'},
    {'value': 'Father'},
    {'value': 'Grand Daughter'},
    {'value': 'Grand Father'},
    {'value': 'Grand Mother'},
    {'value': 'Grand Son'},
    {'value': 'Husband'},
    {'value': 'Mother'},
    {'value': 'Sister'},
    {'value': 'Son'},
    {'value': 'Wife'},
  ];
  var _postjson;
  Future<List<dynamic>> getdata() async {
    final url =
        "http://app.wellsunebusiness.online//WellSunWS.svc/GetAllProducts";
    final res = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8'
      },
    );
    var jsondata = jsonDecode(res.body);
    print(jsondata);
    _postjson = jsondata;
    print(_postjson['GetAllProductsResult']['lstProduct'][0]['cName']);
    return _postjson['GetAllProductsResult']['lstProduct'];
  }

  Future<List<DropdownMenuItem>> getArray() async {
    var content = await getdata();

    print(content);

    List<DropdownMenuItem> widgets;

    content.map((e) {
      widgets.add(new DropdownMenuItem(child: Text(e['cName'])));
    });

    //print(widgets.length);

    return widgets;
  }
  // final getAllProductsResultModel = getAllProductsResultModelFromJson(data););

  postdata() async {
    try {
      var response = await http.post(
          Uri.parse(
              "http://app.wellsunebusiness.online//WellSunWS.svc/RegisterAgency"),
          headers: {
            "Content-Type": "application/json",
          },
          //content-type:application/json,
          body: jsonEncode({
            "EnrollNo": "WEB10001",
            "values": [
              {"Key": "nCode", "Value": "1"},
              {"Key": "nBranchId", "Value": "2"},
              {"Key": "dEntDate", "Value": "/Date(1198908717056)/"},
              {"Key": "dJoiningDate", "Value": "/Date(1198908717056)/"},
              {"Key": "nEnrollNo", "Value": "0"},
              {"Key": "cEnrollNo", "Value": userlogin},
              {"Key": "nIntroEnrollNo", "Value": userlogin},
              {"Key": "nSrZoEnrollNo", "Value": "1"},
              {"Key": "nFieldSupportNo", "Value": userlogin},
              {"Key": "cName", "Value": _namecontroller.text},
              {"Key": "cSoDoWoName", "Value": "Mihir Shah"},
              {"Key": "cAdharNo", "Value": _aadharcontroller.text},
              {"Key": "cPanNo", "Value": _pannocontroller.text},
              {"Key": "dDOB", "Value": "/Date(1198908717056)/"},
              {"Key": "cAdd", "Value": _addresscontroller.text},
              {"Key": "cCity", "Value": _citycontroller.text},
              {"Key": "cPincode", "Value": _pincodecontroller.text},
              {"Key": "cPhNo", "Value": "07925472288"},
              {"Key": "cMobile", "Value": _phnocontroller.text},
              {"Key": "cWhatsapp", "Value": _whatsappcontroller.text},
              {"Key": "cEmail", "Value": _emailcontroller.text},
              {"Key": "cBankName", "Value": "HDFC BANK"},
              {"Key": "cAcNo", "Value": "128493890555"},
              {"Key": "cBranch", "Value": "Bapunagar"},
              {"Key": "cIFSC", "Value": "ICICI1110"},
              {"Key": "cNominee", "Value": "Pinakin Shah"},
              {"Key": "cRelation", "Value": "Brother"},
              {"Key": "dNomineeDOB", "Value": "/Date(1198908717056)/"},
              {"Key": "cPhoto", "Value": "mihir.png"},
              {"Key": "nCompCode", "Value": "1"},
              {"Key": "nItemId", "Value": "0"},
              {"Key": "nActive", "Value": "1"},
              {"Key": "cTaluka", "Value": _talukacontroller.text},
              {"Key": "cDistrict", "Value": _districtcontroller.text},
              {"Key": "cAadharcard", "Value": "aadhar.png"},
              {"Key": "cPassword", "Value": "Dummy@123"},
              {"Key": "nPrice", "Value": 0},
              {"Key": "cNote", "Value": "Notes."}
            ]
          }));
      print(response.body);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdata();
    getArray();
    userlogin = r.read('Username');
    print(userlogin);
    print('dropdown value : ' + dropdownvalue);
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          //shadowColor: Colors.transparent,
          elevation: 10,
          title: Text(
            "Registration Form",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formkey,
          child: Column(
            children: [
              FutureBuilder(
                future: getArray(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  print(snapshot.data);

                  return DropdownButton(items: snapshot.data);
                },
              ),
              TextFormField(
                controller: _namecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.person),
                  hintText: "Name *",
                  labelText: "name *",
                  //   labelStyle: TextStyle(color: Colors.green[900]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Name";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _addresscontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.location_on),
                  hintText: "Address *",
                  labelText: "Address *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phnocontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.location_on),
                  hintText: "Phone No *",
                  labelText: "Phone No *",
                  labelStyle: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Phone No";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text('Your relation with the nominee'),
              SelectFormField(
                type: SelectFormFieldType.dropdown,
                initialValue: null,
                icon: Icon(Icons.arrow_drop_down_circle_rounded),
                labelText: 'Relationship',
                items: items,
                onChanged: (val) => dropdownvalue = val,
                onSaved: (val) => dropdownvalue = val,
              ),
              SizedBox(
                height: 20,
              ),
              // DropdownButton(
              //   items: _postjson
              //       .map((e) => DropdownMenuItem(
              //             child: Text(e['cName']),
              //           ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       choice = value;
              //     });
              //   },
              //   value: choice,
              // ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _whatsappcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.location_on),
                  hintText: "Whatsapp No *",
                  labelText: "Whatsapp No *",
                  labelStyle: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your WhatsApp No";
                  } else
                    return null;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.filter_vintage_outlined),
              //     hintText: "Field Support ID*",
              //     labelText: "Field Support ID*",
              //     labelStyle: TextStyle(color: Colors.green[900]),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Enter your Field Support ID";
              //     } else
              //       return null;
              //   },
              // ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _citycontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  //icon: Icon(Icons.location_city),
                  prefixIcon: Icon(Icons.location_city),
                  hintText: "City*",
                  labelText: "City*",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your City";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _aadharcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  prefixIcon: Icon(Icons.cases_rounded),
                  hintText: "Aadhar No*",
                  labelText: "Aadhar No*",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Aadhar No";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () => _pickdate(context),
                  child: Text('Pick Date')),
              //Text(selecteddate.toString()),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _pincodecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  prefixIcon: Icon(Icons.contact_mail_rounded),
                  hintText: "Pincode *",
                  labelText: "Pincode *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  prefixIcon: Icon(Icons.contact_mail_rounded),
                  hintText: "Email *",
                  labelText: "Email *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _pannocontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  prefixIcon: Icon(Icons.account_balance_rounded),
                  hintText: "Pan No *",
                  labelText: "Pan No *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Pan No";
                  } else
                    return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _talukacontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  prefixIcon: Icon(Icons.reduce_capacity_outlined),
                  hintText: "Taluka *",
                  labelText: "Taluka *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _districtcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.two_wheeler_outlined),
                  hintText: "District *",
                  labelText: "District *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _statecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                  focusColor: Colors.green[900],
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          BorderSide(color: Colors.green[900], width: 3)),
                  icon: Icon(Icons.scatter_plot_sharp),
                  hintText: "State *",
                  labelText: "State *",
                  labelStyle: TextStyle(color: Colors.green[900]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_formkey.currentState.validate()) {
                      postdata();
                    }
                  });
                },
                child: Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:untitled/app/modules/stepper_register_user_module/stepper_register_user_controller.dart';
// import 'package:untitled/app/theme/app_colors.dart';
// import 'package:untitled/app/utils/CommonUtility.dart';
// import 'package:untitled/generated/assets.dart';
// import 'package:untitled/l10n.dart';
// import 'package:untitled/main.dart';

// class StepperRegisterUserPage extends GetView<StepperRegisterUserController> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   StepperRegisterUserController controller =
//       Get.put(StepperRegisterUserController());
//   TextEditingController photoUploadController =
//       new TextEditingController(text: "Photo");
//   TextEditingController phoneNoController = new TextEditingController();
//   TextEditingController aadharCardUploadController =
//       new TextEditingController();
//   TextEditingController fullnameController = new TextEditingController();
//   // TextEditingController referenceIdController = new TextEditingController(
//   //     text: GetStorageProvider().getDataByName(GetStorageProvider.USER_NAME));
//   TextEditingController addressController = new TextEditingController();
//   TextEditingController genderController = new TextEditingController();
//   TextEditingController fieldSupportController = new TextEditingController();
//   TextEditingController cityController = new TextEditingController();
//   // TextEditingController joinDateController =
//   //     new TextEditingController(text: dateTimeToString(DateTime.now()));
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
//   // TextEditingController paymentDateController =
//   //     new TextEditingController(text: dateTimeToString(DateTime.now()));
//   TextEditingController noteController = new TextEditingController();
//   TextEditingController kitPriceController = new TextEditingController();
//   TextEditingController paymentTypeController = new TextEditingController();
//   TextEditingController paymentReceiptController = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Obx(
//           () => controller.isLoadingApi.value == true
//               ? Center(child: CircularProgressIndicator())
//               : controller.getAllProductsResultModel.isNullOrBlank
//                   ? Center(
//                       child: Text("Some thing went wrong"),
//                     )
//                   : Stack(
//                       children: [
//                         Column(
//                           children: [
//                             Container(
//                               height: 120,
//                               color: Colors.white,
//                               width: double.infinity,
//                             ),
//                             Expanded(
//                               child: Stepper(
//                                 currentStep: controller.currentStep.value,
//                                 elevation: 0,
//                                 type: StepperType.vertical,
//                                 onStepTapped: (int a) {
//                                   if (controller.isRegisterValidated()) {
//                                     controller.currentStep(a);
//                                   } else {
//                                     controller.loginUser(context);
//                                   }
//                                 },
//                                 onStepContinue: () {
//                                   if (controller.currentStep.value == 0 &&
//                                       controller.isRegisterValidated()) {
//                                     controller.currentStep(
//                                         controller.currentStep.value + 1);
//                                   } else if (controller.isRegisterValidated() &&
//                                       controller.isOtherDetailValid()) {
//                                     controller.loginUser(context);
//                                   }
//                                 },
//                                 onStepCancel: () => Get.back(),
//                                 steps: [
//                                   //Step1
//                                   Step(
//                                     title: Text(registerUser(language)),
//                                     content: Column(
//                                       children: [
//                                         //fullName
//                                         controller.getTextField(
//                                           fullName(language),
//                                           controller.fullnameController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         controller.getTextField(
//                                           referenceId(language),
//                                           controller.referenceIdController,
//                                           "",
//                                           isReadOnlyVal: true,
//                                         ),
//                                         //Address
//                                         controller.getTextField(
//                                           address(language),
//                                           controller.addressController,
//                                           "assets/icon/ic_fullname.png",
//                                           maxLines: 3,
//                                           minLines: 3,
//                                         ),
//                                         // Gender
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               20, 20, 20, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xFFEEF1F8),
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                             ),
//                                             child: DropdownButtonHideUnderline(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(18.0),
//                                                 child: DropdownButton<String>(
//                                                   value:
//                                                       controller.gender.value,
//                                                   hint: Text(gender(language)),
//                                                   isDense: true,
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         getProximaNova(),
//                                                     fontSize: 16,
//                                                     color: Colors.black,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(13),
//                                                   isExpanded: true,
//                                                   items: [
//                                                     DropdownMenuItem(
//                                                       child: Text("Male"),
//                                                       value: "Male",
//                                                     ),
//                                                     DropdownMenuItem(
//                                                       child: Text("Female"),
//                                                       value: "Female",
//                                                     ),
//                                                   ],
//                                                   onChanged: (newValue) =>
//                                                       controller
//                                                           .gender(newValue),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                         //fieldSupportId
//                                         controller.getTextField(
//                                           fieldSupportId(language),
//                                           controller.fieldSupportController,
//                                           "assets/icon/ic_fullname.png",
//                                           onChangedData: (String value) {
//                                             if (value.length >= 3) {
//                                               controller.findSupportID(value);
//                                             }
//                                           },
//                                         ),

//                                         //City
//                                         controller.getTextField(
//                                           city(language),
//                                           controller.cityController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         // JoinDate
//                                         controller.getDatePicker(
//                                           context,
//                                           joinDate(language),
//                                           controller.joinDateController,
//                                         ),
//                                         //AdaharCard
//                                         controller.getTextField(
//                                           aadharNo(language),
//                                           controller.aadharNoController,
//                                           "assets/icon/ic_fullname.png",
//                                           maxLength: 12,
//                                           keyboardType: TextInputType.number,
//                                         ),
//                                         //Pincode
//                                         controller.getTextField(
//                                           pincode(language),
//                                           controller.pinCodeController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         // //Destination
//                                         // getTextField(
//                                         //   designation(widget.language),
//                                         //   designationController,
//                                         //   "assets/icon/ic_fullname.png",
//                                         // ),
//                                         //Pancard
//                                         controller.getTextField(
//                                           PANNo(language),
//                                           controller.panNoController,
//                                           "assets/icon/ic_fullname.png",
//                                           maxLength: 10,
//                                         ),
//                                         //Taluka
//                                         controller.getTextField(
//                                           taluka(language),
//                                           controller.talukaController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         //district
//                                         controller.getTextField(
//                                           district(language),
//                                           controller.districtController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         //state
//                                         controller.getTextField(
//                                           state(language),
//                                           controller.stateController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                       ],
//                                     ),
//                                     isActive: controller.currentStep.value == 0,
//                                     state: controller.currentStep.value == 0
//                                         ? StepState.editing
//                                         : StepState.complete,
//                                   ),
//                                   //Step2
//                                   Step(
//                                     isActive: controller.currentStep.value == 1,
//                                     title: Text(otherDetails(language)),
//                                     content: Column(
//                                       children: [
//                                         controller.getDatePicker(
//                                           context,
//                                           birthDate(language),
//                                           controller.birthDateController,
//                                         ),
//                                         //BankName
//                                         controller.getTextField(
//                                           bankName(language),
//                                           controller.bankNameController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         //nominee
//                                         controller.getTextField(
//                                           nominee(language),
//                                           controller.nomineeController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         //mobileno
//                                         controller.getTextField(
//                                           mobileNo(language),
//                                           controller.mobileNoController,
//                                           "assets/icon/ic_fullname.png",
//                                           keyboardType: TextInputType.number,
//                                           maxLength: 10,
//                                         ),
//                                         //branchNO
//                                         controller.getTextField(
//                                           branchName(language),
//                                           controller.branchNameController,
//                                           "assets/icon/ic_fullname.png",
//                                         ),
//                                         //nominee
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               20, 20, 20, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xFFEEF1F8),
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                             ),
//                                             child: DropdownButtonHideUnderline(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(18.0),
//                                                 child: DropdownButton<String>(
//                                                   value: controller
//                                                       .nomineeRelation.value,
//                                                   hint: Text(gender(language)),
//                                                   isDense: true,
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         getProximaNova(),
//                                                     fontSize: 16,
//                                                     color: Colors.black,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(13),
//                                                   isExpanded: true,
//                                                   items: CommonUtility
//                                                       .nomineeRelationList
//                                                       .map<
//                                                           DropdownMenuItem<
//                                                               String>>(
//                                                         (s) => DropdownMenuItem(
//                                                           child: Text(s),
//                                                           value: "$s",
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                                   onChanged: (newValue) =>
//                                                       controller
//                                                           .nomineeRelation(
//                                                               newValue),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                         //whatsAppno
//                                         controller.getTextField(
//                                           whatsappNo(language),
//                                           controller.whatsAppController,
//                                           '',
//                                           maxLength: 10,
//                                           keyboardType: TextInputType.number,
//                                         ),
//                                         //accountNumber
//                                         controller.getTextField(
//                                           AcNo(language),
//                                           controller.acNoController,
//                                           '',
//                                         ),
//                                         //Photo
//                                         controller.getTextField(
//                                           photoUpload(language),
//                                           controller.photoUploadController,
//                                           '',
//                                           tap: () => controller.selectPhoto(
//                                               controller.photoUploadController,
//                                               controller.photoFile),
//                                           isReadOnlyVal: true,
//                                         ),
//                                         // EMail
//                                         controller.getTextField(
//                                           email(language),
//                                           controller.emailController,
//                                           '',
//                                           keyboardType:
//                                               TextInputType.emailAddress,
//                                         ),
//                                         //IFSC
//                                         controller.getTextField(
//                                           ifsc(language),
//                                           controller.IFSCconroller,
//                                           '',
//                                         ),
//                                         //aadharCard
//                                         controller.getTextField(
//                                           aadharCardUpload(language),
//                                           controller.aadharCardUploadController,
//                                           '',
//                                           tap: () => controller.selectPhoto(
//                                               controller
//                                                   .aadharCardUploadController,
//                                               controller.aadharCardFile),
//                                           isReadOnlyVal: true,
//                                         ),

//                                         //SelectKit
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               20, 20, 20, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xFFEEF1F8),
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                             ),
//                                             child: DropdownButtonHideUnderline(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(18.0),
//                                                 child: DropdownButton<String>(
//                                                   value: controller
//                                                       .productKitString.value,
//                                                   hint: Text(gender(language)),
//                                                   isDense: true,
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         getProximaNova(),
//                                                     fontSize: 16,
//                                                     color: Colors.black,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(13),
//                                                   isExpanded: true,
//                                                   items: controller
//                                                       .getAllProductsResultModel
//                                                       .getAllProductsResult
//                                                       .lstProduct
//                                                       .map<
//                                                           DropdownMenuItem<
//                                                               String>>(
//                                                         (s) => DropdownMenuItem(
//                                                           child: Text(
//                                                               "${s.cName}"),
//                                                           value: "${s.cName}",
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                                   onChanged: (newValue) =>
//                                                       controller
//                                                           .productKitString(
//                                                               newValue),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                         //paymentDate
//                                         controller.getDatePicker(
//                                           context,
//                                           PaymentDate(language),
//                                           controller.paymentDateController,
//                                         ),
//                                         controller.getTextField(
//                                           Note(language),
//                                           controller.noteController,
//                                           '',
//                                           maxLines: 3,
//                                           minLines: 3,
//                                         ),
//                                         controller.getTextField(
//                                           KitPrice(language),
//                                           controller.kitPriceController,
//                                           '',
//                                         ),
//                                         //PaymentType
//                                         Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               20, 20, 20, 0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Color(0xFFEEF1F8),
//                                               borderRadius:
//                                                   BorderRadius.circular(13),
//                                             ),
//                                             child: DropdownButtonHideUnderline(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(18.0),
//                                                 child: DropdownButton<String>(
//                                                   value: controller
//                                                       .paymentTypeString.value,
//                                                   hint: Text(gender(language)),
//                                                   isDense: true,
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         getProximaNova(),
//                                                     fontSize: 16,
//                                                     color: Colors.black,
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(13),
//                                                   isExpanded: true,
//                                                   items: CommonUtility
//                                                       .paymentTypeList
//                                                       .map<
//                                                           DropdownMenuItem<
//                                                               String>>(
//                                                         (data) =>
//                                                             DropdownMenuItem(
//                                                           child:
//                                                               Text("${data}"),
//                                                           value: "${data}",
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                                   onChanged: (newValue) =>
//                                                       controller
//                                                           .paymentTypeString(
//                                                               newValue),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                         // paymentReceipt
//                                         controller.getTextField(
//                                           PaymentType(language),
//                                           controller.paymentReceiptController,
//                                           '',
//                                           tap: () => controller.selectPhoto(
//                                               controller
//                                                   .paymentReceiptController,
//                                               controller.paymentFile),
//                                           isReadOnlyVal: true,
//                                         ),
//                                         //
//                                         controller.getTextField(
//                                             ViewUpiDetails(language), null, '',
//                                             tap: () => showDialog(
//                                                   context: context,
//                                                   builder: (_) =>
//                                                       CommonUtility.imageDialog(
//                                                           url:
//                                                               Assets.assetsUpi),
//                                                 ),
//                                             isReadOnlyVal: true),
//                                       ],
//                                     ),
//                                     state: controller.currentStep.value == 1
//                                         ? StepState.editing
//                                         : StepState.complete,
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         //
//                         CommonUtility().getBottomMenu(
//                           context,
//                           registerUser(language),
//                           _scaffoldKey,
//                           showBack: true,
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
// }
