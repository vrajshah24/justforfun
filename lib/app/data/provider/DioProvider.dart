import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/route_manager.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/data/repository/CancelOrderModel.dart';
import 'package:untitled/app/data/repository/ChangePasswordModel.dart';
import 'package:untitled/app/data/repository/GetAllBranchModel.dart';
import 'package:untitled/app/data/repository/GetAllProductsResultModel.dart';
import 'package:untitled/app/data/repository/GetMyUsersModel.dart';
import 'package:untitled/app/data/repository/GetProductDetailsModel.dart';
import 'package:untitled/app/data/repository/GetUserSalesModel.dart';
import 'package:untitled/app/data/repository/LoginModel.dart';
import 'package:untitled/app/data/repository/PlaceOrderModel.dart';
import 'package:untitled/app/data/repository/SearchFieldSupportIDModel.dart';
import 'package:untitled/app/data/repository/registerResponseModel.dart';

class DioProvider {
  static Dio getDio() {
    Dio _dio;
    if (_dio == null) {
      return _dio = new Dio(
        BaseOptions(
          baseUrl: "http://app.wellsunebusiness.online/WellSunWS.svc",
          headers: {"content-type": "application/json; charset=UTF-8"},
        ),
      );
    } else {
      return _dio;
    }
  }

  Future<RegisterResponseModel> registerUser(formData) async {
    final response =
        await getDio().post('/RegisterAgency', data: jsonEncode(formData));
    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<GetUserSalesModel> getAllOrders(String userName) async {
    dynamic data = {'EnrollNo': userName};
    final response =
        await getDio().post('/GetUserSales', data: jsonEncode(data));
    return GetUserSalesModel.fromJson(response.data);
  }

  Future<bool> uploadImage(String dir, String file) async {
    FTPConnect ftpConnect = FTPConnect(
      '172.107.166.110',
      user: 'wellsun',
      pass: 'Abcd@1234',
    );
    File fileToUpload = File(file);
    await ftpConnect.connect();
    await ftpConnect.changeDirectory(dir);
    bool res = await ftpConnect.uploadFile(fileToUpload);
    // String newName = file.replaceAll("image_picker", "".trim());
    // print("-->new Filename--->$newName");
    // await ftpConnect.rename(file, newName);
    await ftpConnect.disconnect();
    print("imageUpload --->$res");
    return res;
  }

  Future<GetProductDetailsModel> GetProductDetails(String productId) async {
    dynamic data = {'ProductID': productId};
    print("$data");
    final response =
        await getDio().post('/GetProductDetails', data: jsonEncode(data));
    return GetProductDetailsModel.fromJson(response.data);
  }

  Future<PlaceOrderModel> placeOrder(dynamic data) async {
    final response = await getDio().post('/PlaceOrder', data: jsonEncode(data));
    if (response.statusCode == 200) {
      return PlaceOrderModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<GetAllBranchModel> getAllBranch() async {
    final response = await getDio().post('/GetAllBranch');
    return GetAllBranchModel.fromJson(response.data);
  }

  Future<LoginModel> postLogin(data) async {
    final response = await getDio().post('/Login', data: jsonEncode(data));
    return LoginModel.fromJson(response.data);
  }

  Future<GetAllProductsResultModel> getProduct(data) async {
    print("getProduct--->$data");
    final response =
        await getDio().post('/GetAllProducts', data: jsonEncode(data));
    return GetAllProductsResultModel.fromJson(response.data);
  }

  Future<GetMyUsersModel> getUserList(data) async {
    final response = await getDio().post('/GetMyUsers', data: jsonEncode(data));
    return GetMyUsersModel.fromJson(response.data);
  }

  Future<SearchFieldSupportIdModel> searchFieldSupportID(qry) async {
    dynamic data = {"Query": "$qry"};
    final response = await getDio()
        .post('/GeSearchFieldSupportIDtMyUsers', data: jsonEncode(data));
    return SearchFieldSupportIdModel.fromJson(response.data);
  }

  Future<CancelOrderModel> cancelOrderByID({String orderId}) async {
    dynamic data = {"OrderID": "$orderId"};
    final response =
        await getDio().post('/CancelOrder', data: jsonEncode(data));
    return CancelOrderModel.fromJson(response.data);
  }

  Future<ChangePasswordModel> changePassword({
    String oldPassword,
    String password,
  }) async {
    dynamic data = {
      "OldPassword": "$oldPassword",
      "NewPassword": "$password",
      "UserID": GetStorageProvider().getDataByIntName("Code").toString(),
    };
    final response =
        await getDio().post('/ChangePassword', data: jsonEncode(data));
    return ChangePasswordModel.fromJson(response.data);
  }

  //DownloadFile
  Future download2(String url, String filename) async {
    Get.dialog(
      AlertDialog(
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
      ),
    );
    try {
      Response response = await getDio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );

      String fullPath = "/storage/emulated/0/$filename.jpg";

      File file = File(fullPath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);

      await raf.close();
      Get.back();
      Get.snackbar("Done", "Download Done");
    } catch (e) {
      print(e);
    }
  }
}
