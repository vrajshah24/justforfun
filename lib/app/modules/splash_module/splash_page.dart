import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/splash_module/splash_controller.dart';

class SplashPage extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Center(
          child: Image.asset('assets/ic_splash.png'),
        ),
      ),
    );
  }
}
