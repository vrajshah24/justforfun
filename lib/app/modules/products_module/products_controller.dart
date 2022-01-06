import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/GetAllProductsResultModel.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class ProductsController extends GetxController {
  GetAllProductsResultModel getAllProductsResultModel;
  var isLoading = false.obs;
  @override
  void onInit() {
    _getAllProduct();
    super.onInit();
  }

  _getAllProduct() async {
    isLoading(true);
    dynamic data = {
      'EnrollNo': GetStorage().read('Username'),
    };
    getAllProductsResultModel = await DioProvider().getProduct(data);
    isLoading(false);
  }
}
