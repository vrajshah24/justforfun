import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/GetProductDetailsModel.dart';

class ProductDetailsController extends GetxController {
  var isLoading = false.obs;
  String productId = "";
  String productTitle = "";
  GetProductDetailsModel productDetailsModel;
  var counter = 1;
  @override
  void onInit() {
    _callApi();
    super.onInit();
  }

  incrementItem() {
    counter++;
    update();
  }

  decrementItem() {
    if (counter > 0) counter--;
    update();
  }

  _callApi() async {
    var one = Get.arguments;
    productTitle = one[0];
    productId = one[1];
    isLoading(true);

    productDetailsModel = await DioProvider().GetProductDetails(productId);
    isLoading(false);
  }

  requestPermissons() async {
    await Permission.storage.request().isGranted;
    await Permission.storage.request();
    var status = await Permission.storage.status;
    switch (status) {
      case PermissionStatus.granted:
        DioProvider().download2(
            GetUtils.isNullOrBlank(productDetailsModel
                    .getProductDetailsResult.mProduct.cBrouPath)
                ? "https://wellsunebusiness.online/assets/images/item/Vejita.jpg"
                : "http://wellsunebusiness.online/" +
                    productDetailsModel
                        .getProductDetailsResult.mProduct.cBrouPath
                        .toString()
                        .replaceAll("~", ""),
            productTitle);
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
}
