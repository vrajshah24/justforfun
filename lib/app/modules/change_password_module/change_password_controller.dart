import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/ChangePasswordModel.dart';
import 'package:untitled/app/theme/app_colors.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  ChangePasswordModel changePasswordModel;
  var _loadingApi = false.obs;

  get loadingApi => _loadingApi;

  set loadingApi(value) => _loadingApi = value;

  Padding getTextField(String hint, var controller, String icon) {
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
                        borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(13),
                        borderSide: new BorderSide(color: Color(0xFFEEF1F8))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(0xFFEEF1F8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changePasswordApi() async {
    if (oldPasswordController.text.trim().isEmpty) {
      Get.snackbar("Required", "Old Password Required");
    } else if (newPasswordController.text.trim().isEmpty) {
      Get.snackbar("Required", "New Password Required");
    } else {
      loadingApi(true);
      changePasswordModel = await DioProvider().changePassword(
        oldPassword: oldPasswordController.text.trim().toString(),
        password: newPasswordController.text.trim().toString(),
      );
      if (changePasswordModel.cancelOrderResult.hasError == false) {
        Get.dialog(
          AlertDialog(
            title: Text("INFO"),
            content:
                Text("${changePasswordModel.cancelOrderResult.messages[0]}"),
            actions: [
              TextButton(onPressed: () => Get.back(), child: Text("OK"))
            ],
          ),
        );
      }

      loadingApi(false);
    }
  }
}
