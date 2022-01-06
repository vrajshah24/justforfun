import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/CancelOrderModel.dart';
import 'package:untitled/app/data/repository/GetUserSalesModel.dart';

class OrderListingController extends GetxController {
  var isLoading = false.obs;
  GetUserSalesModel getUserSalesModel;
  CancelOrderModel cancelOrderModel;

  @override
  void onInit() {
    _callApi();
    super.onInit();
  }

  _callApi() async {
    isLoading(true);
    getUserSalesModel =
        await DioProvider().getAllOrders(GetStorage().read('Username'));
    isLoading(false);
  }

  cancelOrder(String orderId, int position) async {
    cancelOrderModel = await DioProvider().cancelOrderByID(orderId: orderId);
    getUserSalesModel.getUserSalesResult.lstMaterial[position].nStatus == "1";
    update();
    refresh();
  }
}
