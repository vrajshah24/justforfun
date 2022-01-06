import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/PlaceOrderModel.dart';
import 'package:untitled/app/utils/strings.dart';

class OrderPageController extends GetxController {
  TextEditingController billTotalController;
  TextEditingController paymentDateController;
  TextEditingController paymentCopyController;
  TextEditingController noteController;
  DateTime selectedDate;
  String EnrollNo;
  var paymentType = "0".obs;
  var placeOrderValue = false.obs;
  ImagePicker _picker;
  File file;
  String BillTotal = "";
  String MRP = "";
  String QTY = "";
  String productId = "";
  @override
  void onInit() {
    var one = Get.arguments;
    BillTotal = one[0];
    MRP = one[1];
    QTY = one[2];
    productId = one[3];

    EnrollNo = GetStorage().read('Username');
    billTotalController = new TextEditingController(text: BillTotal);
    paymentDateController = new TextEditingController();
    paymentCopyController = new TextEditingController();
    noteController = new TextEditingController();
    _picker = ImagePicker();
    super.onInit();
  }

  //Method for showing the date picker
  void pickDateDialog(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate = pickedDate;

      paymentDateController.text = selectedDate.day.toString() +
          "/" +
          selectedDate.month.toString() +
          "/" +
          selectedDate.year.toString();
    });
  }

  changeDropDownValue(String value) {
    paymentType(value);
  }

  placeOrder() async {
    if (GetUtils.isNullOrBlank(billTotalController.text.trim())) {
      Get.snackbar("require", "billing total required");
      return;
    } else if (GetUtils.isNullOrBlank(paymentDateController.text.trim())) {
      Get.snackbar("require", "paymentDate  required");
      return;
    } else if (GetUtils.isNullOrBlank(paymentType.value.trim())) {
      Get.snackbar("require", "payment type required");
      return;
    } else if (GetUtils.isNullOrBlank(paymentCopyController.text.trim())) {
      Get.snackbar("require", "payment copy required");
      return;
    } else if (GetUtils.isNullOrBlank(noteController.text.trim())) {
      Get.snackbar("require", "note required");
      return;
    } else {
      placeOrderValue(true);
      var data = {
        "EnrollNo": EnrollNo,
        "ProductID": productId,
        "BranchID": GetStorage().read(BranchID),
        "BillTotal": BillTotal,
        "nFieldSupportNo": EnrollNo,
        "PaymentCopy":
            "/PayReceipt/${paymentCopyController.text.trim().toString()}",
        "PaymentType": paymentType.value,
        "Note": noteController.text,
        "PaymentDate": "/Date(${selectedDate.millisecondsSinceEpoch})/",
        "Qty": QTY,
        "MRP": MRP,
        "ItemID": productId,
      };
      printInfo(info: "$data");
      await DioProvider().uploadImage(FTP_PAY_RECEIPT_URL, file.path);
      PlaceOrderModel placeOrderModel = await DioProvider().placeOrder(data);
      placeOrderValue(false);
      if (placeOrderModel != null &&
          placeOrderModel.placeOrderResult.hasError == false) {
        Get.dialog(
          AlertDialog(
            title: Text("INFO"),
            content: Text("Order Placed.."),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  BillTotal = "";
                  paymentDateController.text = "";
                  paymentCopyController.text = "";
                  noteController.text = "";
                  Get.back();
                  // Get.to(() => ProductsPage());
                },
              ),
            ],
          ),
        );
      } else {
        Get.dialog(
          AlertDialog(
            title: Text("INFO"),
            content: Text("${placeOrderModel.placeOrderResult.messages[0]}"),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back();
                  // Get.to(() => ProductsPage());
                },
              ),
            ],
          ),
        );
      }
    }
  }

  requestPermissons() async {
    await Permission.storage.request().isGranted;
    await Permission.storage.request();
    var status = await Permission.storage.status;
    switch (status) {
      case PermissionStatus.granted:
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        file = File(pickedFile.path);
        paymentCopyController.text = pickedFile.name;
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
