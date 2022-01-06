import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/data/repository/GetAllProductsResultModel.dart';
import 'package:untitled/app/data/repository/SearchFieldSupportIDModel.dart';
import 'package:untitled/app/data/repository/registerResponseModel.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/app/utils/strings.dart';

class StepperRegisterUserController extends GetxController {
  var _currentStep = 0.obs;
  var _gender = 'Male'.obs;
  var _isLoadingApi = false.obs;
  var _nomineeRelation = 'Brother'.obs;
  var _productKitString = ''.obs;
  var _paymentTypeString = CommonUtility.paymentTypeList[0].obs;
  var _supportIdData = "".obs;
  DateTime startDate = DateTime(1950);
  DateTime endDate = DateTime(2050);
  ImagePicker _picker = ImagePicker();
  File _photoFile;
  File _aadharCardFile;
  File _paymentFile;
  //Model
  GetAllProductsResultModel _getAllProductsResultModel;
  SearchFieldSupportIdModel searchFieldSupportIdModel;
  //
  TextEditingController photoUploadController = new TextEditingController();
  TextEditingController phoneNoController = new TextEditingController();
  TextEditingController aadharCardUploadController =
      new TextEditingController();
  TextEditingController fullnameController = new TextEditingController();
  TextEditingController referenceIdController = new TextEditingController(
      text: GetStorageProvider().getDataByName(GetStorageProvider.USER_NAME));
  TextEditingController addressController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController fieldSupportController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController joinDateController = new TextEditingController(
    text: CommonUtility().dateTimeToString(
      DateTime.now(),
    ),
  );
  TextEditingController aadharNoController = new TextEditingController();
  TextEditingController panNoController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  // TextEditingController designationController = new TextEditingController();
  TextEditingController talukaController = new TextEditingController();
  TextEditingController districtController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController birthDateController = new TextEditingController();
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController nomineeController = new TextEditingController();
  TextEditingController mobileNoController = new TextEditingController();
  TextEditingController branchNameController = new TextEditingController();
  TextEditingController nomineeRelationController = new TextEditingController();
  TextEditingController whatsAppController = new TextEditingController();
  TextEditingController acNoController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController IFSCconroller = new TextEditingController();
  TextEditingController kitController = new TextEditingController();
  TextEditingController paymentDateController = new TextEditingController(
    text: CommonUtility().dateTimeToString(
      DateTime.now(),
    ),
  );
  TextEditingController noteController = new TextEditingController();
  TextEditingController kitPriceController = new TextEditingController();
  TextEditingController paymentTypeController = new TextEditingController();
  TextEditingController paymentReceiptController = new TextEditingController();

  get currentStep => _currentStep;
  get gender => _gender;
  get nomineeRelation => _nomineeRelation;
  get productKitString => _productKitString;
  get isLoadingApi => _isLoadingApi;
  GetAllProductsResultModel get getAllProductsResultModel =>
      _getAllProductsResultModel;
  set getAllProductsResultModel(GetAllProductsResultModel value) =>
      _getAllProductsResultModel = value;
  set isLoadingApi(value) => _isLoadingApi = value;
  set productKitString(value) => _productKitString = value;
  set gender(value) => _gender = value;
  File get aadharCardFile => _aadharCardFile;

  set aadharCardFile(File value) => _aadharCardFile = value;

  File get paymentFile => _paymentFile;

  set paymentFile(File value) => _paymentFile = value;
  File get photoFile => _photoFile;

  set photoFile(File value) {
    _photoFile = value;
  }

  get paymentTypeString => _paymentTypeString;
  set paymentTypeString(value) => _paymentTypeString = value;
  set currentStep(value) => _currentStep = value;
  set nomineeRelation(value) => _nomineeRelation = value;

  @override
  void onInit() {
    _getAllProductKit();
    super.onInit();
  }

  Padding getTextField(String hint, var controller, String icon,
      {GestureTapCallback tap,
      bool isReadOnlyVal = false,
      TextInputType keyboardType,
      int minLines = 1,
      int maxLines = 1,
      var maxLength,
      ValueChanged<String> onChangedData}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFEEF1F8), borderRadius: BorderRadius.circular(13)),
        child: Row(
          children: [
            Container(
              width: 16,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  onTap: tap,
                  onChanged: onChangedData,
                  maxLines: maxLines,
                  minLines: minLines,
                  maxLength: maxLength,
                  keyboardType: keyboardType,
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                  readOnly: isReadOnlyVal,
                  style: TextStyle(
                    fontFamily: getProximaNova(),
                    fontSize: 16,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Color(0xFFEEF1F8),
                    focusColor: Color(0xFFEEF1F8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(
                          0xFFEEF1F8,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(
                          0xFFEEF1F8,
                        ),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        13,
                      ),
                      borderSide: new BorderSide(
                        color: Color(
                          0xFFEEF1F8,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRegisterValidated() {
    bool validation = true;
    if (cityController.text.trim().isEmpty) {
      showAlertDialog("City is Required");
      validation = false;
    } else if (aadharNoController.text.trim().isEmpty) {
      showAlertDialog("Aadhar No. required.");
      validation = false;
    } else if (panNoController.text.trim().isEmpty) {
      showAlertDialog("PAN No required.");
      validation = false;
    }
    return validation;
  }

  bool isOtherDetailValid() {
    bool validation = true;
    if (mobileNoController.text.trim().isEmpty ||
        mobileNoController.text.length != 10) {
      showAlertDialog("mobileNo is required.");
      validation = false;
    } else if (whatsAppController.text.trim().isEmpty ||
        mobileNoController.text.length != 10) {
      showAlertDialog("whatsAppNo is required.");
      validation = false;
    }
    return validation;
  }

  showAlertDialog(String value) {
    return Get.dialog(
      AlertDialog(
        // title: Text("INFO"),
        content: Text("$value"),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Get.back(),
          )
        ],
      ),
    );
  }

  bool isSupprotIdPresent(String supportId) {
    return searchFieldSupportIdModel
        .searchFieldSupportIdResult.lstFieldSupportId
        .contains(supportId);
  }

  void loginUser(BuildContext context) async {
    if (fullnameController.text.isEmpty) {
      showAlertDialog("Ac No. required.");
    } else if (addressController.text.isEmpty) {
      showAlertDialog("Address required.");
    } else if (genderController.text.isEmpty) {
      showAlertDialog("Gender required.");
    } else if (cityController.text.isEmpty) {
      showAlertDialog("Address required.");
    } else if (joinDateController.text.isEmpty) {
      showAlertDialog("Join Date required.");
    } else if (aadharNoController.text.isEmpty) {
      showAlertDialog("Aadhar No. required.");
    } else if (pinCodeController.text.isEmpty) {
      showAlertDialog("Pincode required.");
    } else if (panNoController.text.isEmpty) {
      showAlertDialog("PAN No required.");
    } else if (talukaController.text.isEmpty) {
      showAlertDialog("Taluka required.");
    } else if (stateController.text.isEmpty) {
      showAlertDialog("State required.");
    } else if (birthDateController.text.isEmpty) {
      showAlertDialog("Birth date required.");
    } else if (whatsAppController.text.isEmpty) {
      showAlertDialog("WhatsApp number is required.");
    } else if (mobileNoController.text.isEmpty) {
      showAlertDialog("mobileNo is required.");
    } else if (supportIdData.value.toString().isEmpty) {
      showAlertDialog("Filed SupportId is required.");
    } else if (isSupprotIdPresent(supportIdData) == false) {
      showAlertDialog("Please verify your Filed SupportId is Correct.");
    } else {
      isLoadingApi(true);
      var data = {
        'nCode': 0,
        'nBranchId': 1,
        'dEntDate': "nCode",
        'dJoiningDate': joinDateController.text,
        'nEnrollNo': null,
        'cEnrollNo': null,
        'nIntroEnrollNo': null,
        'nSrZoEnrollNo': null,
        'cSoDoWoName': null,
        'cAdharNo': aadharNoController.text,
        'cPanNo': panNoController.text,
        'dDOB': birthDateController.text,
        'cAdd': addressController.text,
        'cName': fullnameController.text,
        'reference': referenceIdController.text,
        'Address': addressController.text,
        'Gender': genderController.text,
        'nFieldSupportNo': fieldSupportController.text,
        'cCity': cityController.text,
        'cPincode': pinCodeController.text,
        'cPhNo': phoneNoController.text,
        'cMobile': mobileNoController.text,
        'cWhatsapp': whatsAppController.text,
        'cEmail': emailController.text,
        'cBankName': bankNameController.text,
        'cAcNo': acNoController.text,
        'cBranch': branchNameController.text,
        'cIFSC': IFSCconroller.text,
        'cNominee': nomineeController.text,
        'cRelation': nomineeRelationController.text,
        'dNomineeDOB': null,
        'cPhoto': photoUploadController.text,
        'nCompCode': null,
        'nRankCode': 1,
        'nItemId': 1,
        'nActive': 1,
        'Em': 1,
        'cTaluka': talukaController.text,
        'cDistrict': districtController.text,
        'nApprovalStatus': 0,
        'cAadharcard': aadharNoController.text,
        'cPassword': "",
        'nPrice': kitPriceController.text,
        'cNote': noteController.text,
      };

      RegisterResponseModel registerResponseModel =
          await DioProvider().registerUser(data);
      if (!aadharCardFile.path.isNullOrBlank) {
        await DioProvider()
            .uploadImage(FTP_ADHAR_CARD_URL, aadharCardFile.path);
      }
      if (!photoFile.path.isNullOrBlank) {
        await DioProvider().uploadImage(FTP_PHOTO_URL, photoFile.path);
      }
      if (!paymentFile.path.isNullOrBlank) {
        await DioProvider().uploadImage(FTP_PHOTO_URL, paymentFile.path);
      }

      if (registerResponseModel != null) {
        if (registerResponseModel.registerAgencyResult.hasError) {
          showAlertDialog(registerResponseModel.registerAgencyResult.messages[0]
              .toString());
        } else {
          Get.back();
        }
      } else {
        showAlertDialog("something went wrong please try again");
      }
      isLoadingApi(false);
    }
  }

  GestureDetector getDatePicker(
      BuildContext context, String hint, var controller) {
    _selectedDate(BuildContext context, DateTime selectedTime) async {
      var datetime = await showDatePicker(
          context: context,
          initialDate: selectedTime,
          firstDate: startDate,
          lastDate: endDate);
      controller.text = CommonUtility().dateTimeToString(datetime);
    }

    return GestureDetector(
      onTap: () => _selectedDate(context, DateTime.now()),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFEEF1F8),
              borderRadius: BorderRadius.circular(13)),
          child: Row(children: [
            SizedBox(width: 16),
            Expanded(
                child: Container(
              width: double.infinity,
              child: TextFormField(
                  enabled: false,
                  style: TextStyle(
                    fontFamily: getProximaNova(),
                    fontSize: 16,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: hint,
                      filled: true,
                      fillColor: Color(0xFFEEF1F8),
                      focusColor: Color(0xFFEEF1F8),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide:
                              new BorderSide(color: Color(0xFFEEF1F8))))),
            )),
            Image.asset(
              "assets/icon/ic_arrow_down.png",
              height: 8,
            ),
            SizedBox(width: 20),
          ]),
        ),
      ),
    );
  }

  selectPhoto(var controller, File file) async {
    await Permission.storage.request().isGranted;
    await Permission.storage.request();
    var status = await Permission.storage.status;
    switch (status) {
      case PermissionStatus.granted:
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        file = File(pickedFile.path);
        controller.text = pickedFile.name;
        break;
      case PermissionStatus.denied:
        Get.snackbar(
          "Storage Permission required",
          "This app needs camera access to take pictures for upload  photo",
        );

        break;
      case PermissionStatus.restricted:
        Get.dialog(
          AlertDialog(
            title: Text('Storage Permission'),
            content: Text(
                'This app needs Storage access to take pictures for upload  photo'),
            actions: [
              CupertinoDialogAction(
                child: Text('Deny'),
                onPressed: () => Get.back(),
              ),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        );
        break;
      case PermissionStatus.limited:
        Get.dialog(
          AlertDialog(
            title: Text('Storage Permission'),
            content: Text(
                'This app needs Storage access to take pictures for upload  photo'),
            actions: [
              CupertinoDialogAction(
                child: Text('Deny'),
                onPressed: () => Get.back(),
              ),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        );
        break;
      case PermissionStatus.permanentlyDenied:
        Get.dialog(
          AlertDialog(
            title: Text('Storage Permission'),
            content: Text(
                'This app needs Storage access to take pictures for upload  photo'),
            actions: [
              CupertinoDialogAction(
                child: Text('Deny'),
                onPressed: () => Get.back(),
              ),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        );
        break;
      default:
        throw UnimplementedError();
    }
  }

  _getAllProductKit() async {
    isLoadingApi(true);
    dynamic data = {
      'EnrollNo': GetStorage().read('Username'),
    };
    getAllProductsResultModel = await DioProvider().getProduct(data);
    productKitString(
        getAllProductsResultModel.getAllProductsResult.lstProduct[0].cName);
    isLoadingApi(false);
  }

  findSupportID(String data) async {
    supportIdData(data);
    searchFieldSupportIdModel = await DioProvider().searchFieldSupportID(data);
  }

  get supportIdData => _supportIdData;

  set supportIdData(value) {
    _supportIdData = value;
  }
}
