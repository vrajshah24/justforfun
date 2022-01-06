import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/Build.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/data/repository/GetAllBranchModel.dart';
import 'package:untitled/app/data/repository/LoginModel.dart';
import 'package:untitled/app/modules/home_module/home_page.dart';
import 'package:untitled/app/utils/strings.dart';
import 'package:untitled/app/vraj/infoclass.dart';

class LoginPageController extends GetxController {
  String user;
  var isBranchLoading = false.obs;
  var isLoginLoading = false.obs;
  GetAllBranchModel branchModel;
  LstBranch lstBranch;
  TextEditingController emailController;
  TextEditingController passwordController;
  String selectedLanguage = "en";

  @override
  void onReady() {
    emailController =
        new TextEditingController(text: Build.isDebugMode ? 'web10002' : "");
    passwordController =
        new TextEditingController(text: Build.isDebugMode ? '123' : "");
    super.onReady();
  }

  @override
  void onInit() {
    getAllBranch();
    selectedLanguage = GetStorageProvider().getLanguageCode();
    super.onInit();
  }

  getAllBranch() async {
    isBranchLoading(true);
    branchModel = await DioProvider().getAllBranch();
    lstBranch = branchModel.getAllBranchResult.lstBranch[0];
    isBranchLoading(false);
  }

  refreshDropDown(branch) {
    lstBranch = branch;
    update();
  }

  changeSelectedLanguage(BuildContext context, language) {
    final LoginPageController c = Get.find();
    selectedLanguage = language;
    GetStorageProvider().setLanguage(language);
    GetStorageProvider().getLanguage();

    c.onInit();
  }

  loginUser() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar("Required", "Please enter UserName");
    } else if (passwordController.text.trim().isEmpty) {
      Get.snackbar("Required", "Please enter Password");
    } else if (lstBranch.branchName.trim().isEmpty) {
      Get.snackbar("Required", "Please Select branch");
    } else {
      isLoginLoading(true);

      var data = {
        'Username': emailController.text.toString(),
        'Password': passwordController.text.toString(),
        'BranchName': lstBranch.branchName.toString(),
      };

      LoginModel loginModel = await DioProvider().postLogin(data);

      if (loginModel.loginResult.hasError) {
        isLoginLoading(false);
        Get.dialog(
          AlertDialog(
            title: Text("Wellsun Fertilizer"),
            content: Text(loginModel.loginResult.messages[0]),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Get.back(),
              )
            ],
          ),
        );
      } else {
        _saveUser(
          loginModel.loginResult.objUser.code,
          loginModel.loginResult.objUser.mobile,
          loginModel.loginResult.objUser.name,
          user = loginModel.loginResult.objUser.username,
          loginModel.loginResult.objUser.studentId,
          loginModel.loginResult.objUser.userType,
        );
        isLoginLoading(false);

        // Get.offAll(
        // MyHomePage(
        //   language: "",
        //   title: "",
        // ),
        // );
        Get.offAll(HomePage());
        print(loginModel.loginResult.objUser.username);
      }
    }
  }

  void _saveUser(int Code, String Mobile, String Name, String Username,
      int StudentId, int UserType) async {
    var storage = GetStorage();
    storage.write(BranchID, lstBranch.branchId.toString());
    if (Code != null) storage.write('Code', Code);
    if (Mobile != null) storage.write('Mobile', Mobile);
    if (Name != null) storage.write('Name', Name);
    if (Username != null) storage.write('Username', Username);
    if (StudentId != null) storage.write('StudentId', StudentId);
    if (UserType != null) storage.write('UserType', UserType);
    storage.write('is_login', true);
  }
}
