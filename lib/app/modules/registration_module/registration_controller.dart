import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled/app/data/provider/DioProvider.dart';
import 'package:untitled/app/data/repository/GetMyUsersModel.dart';

class RegistrationController extends GetxController {
  var isLoading = false.obs;
  GetMyUsersModel getMyUsersModel;

  @override
  void onInit() {
    _callApi();
    super.onInit();
  }

  _callApi() async {
    isLoading(true);
    dynamic data = {
      'EnrollNo': GetStorage().read('Username'),
    };
    getMyUsersModel = await DioProvider().getUserList(data);
    isLoading(false);
  }
}
