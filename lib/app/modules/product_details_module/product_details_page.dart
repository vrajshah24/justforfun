import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/app/data/provider/GetStorage.dart';
import 'package:untitled/app/modules/order_page_module/order_page_page.dart';
import 'package:untitled/app/modules/product_details_module/product_details_controller.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class ProductDetailsPage extends GetView<ProductDetailsController> {
  ProductDetailsController controller = Get.put(ProductDetailsController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: getBgColor(),
      body: Stack(
        children: [
          Obx(
            () => controller.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    padding:
                        EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 120),
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: 30, top: 120, right: 30, bottom: 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Image.network(
                                      GetUtils.isNullOrBlank(controller
                                              .productDetailsModel
                                              .getProductDetailsResult
                                              .mProduct
                                              .cPath)
                                          ? "https://wellsunebusiness.online/assets/images/item/Vejita.jpg"
                                          : "http://wellsunebusiness.online/" +
                                              controller
                                                  .productDetailsModel
                                                  .getProductDetailsResult
                                                  .mProduct
                                                  .cPath
                                                  .toString()
                                                  .replaceAll("~", ""),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: getBorderColor()),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                    0,
                                    3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox.fromSize(
                        size: Size(
                          10,
                          10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                controller.productTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            //
                            ListTile(
                              title: Text(
                                description(language),
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  controller
                                              .productDetailsModel
                                              .getProductDetailsResult
                                              .mProduct
                                              .cMfg ==
                                          null
                                      ? ""
                                      : controller
                                          .productDetailsModel
                                          .getProductDetailsResult
                                          .mProduct
                                          .cMfg,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            //
                            ListTile(
                              title: Text(
                                dealerPrice(language),
                                textAlign: TextAlign.start,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${controller.productDetailsModel.getProductDetailsResult.mProduct.nDp}",
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () => controller.requestPermissons(),
                              title: Text(
                                "Download ${controller.productTitle} brochure",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
          ),
          GetStorageProvider().isUserLogin() == true
              ? GetBuilder<ProductDetailsController>(
                  builder: (logic) => Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            margin: EdgeInsets.only(
                                left: 30, top: 50, right: 30, bottom: 30),
                            height: 60,
                            width: double.infinity,
                            child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  GestureDetector(
                                    onTap: () => logic.decrementItem(),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 0, top: 0, right: 0, bottom: 0),
                                      height: 50,
                                      width:
                                          ((MediaQuery.of(context).size.width) /
                                              4.5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '-',
                                          style: GoogleFonts.lato(
                                              color: getMyAppColor(),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => logic.incrementItem(),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: ((MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              4.5),
                                          top: 0,
                                          right: 0,
                                          bottom: 0),
                                      height: 50,
                                      width:
                                          ((MediaQuery.of(context).size.width) /
                                              4.5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+',
                                          style: GoogleFonts.lato(
                                              color: getMyAppColor(),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 5,
                                              top: 0,
                                              right: 0,
                                              bottom: 0),
                                          height: 50,
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  75) *
                                              0.5),
                                          child: Center(
                                            child: Text(
                                              '${logic.counter}',
                                              style: GoogleFonts.lato(
                                                  color: getMyAppColor(),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 0,
                                              top: 0,
                                              right: 5,
                                              bottom: 0),
                                          height: 50,
                                          width: ((MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  75) *
                                              0.5),
                                          decoration: BoxDecoration(
                                            color: getMyAppColor(),
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              var total = controller.counter *
                                                  controller
                                                      .productDetailsModel
                                                      .getProductDetailsResult
                                                      .mProduct
                                                      .nMrp;
                                              Get.to(() => OrderPagePage(),
                                                  arguments: [
                                                    //orderTotal
                                                    total.toString(),
                                                    //MRP
                                                    controller
                                                        .productDetailsModel
                                                        .getProductDetailsResult
                                                        .mProduct
                                                        .nMrp
                                                        .toString(),
                                                    //qty
                                                    controller.counter
                                                        .toString(),
                                                    //ProductId
                                                    controller.productId
                                                        .toString(),
                                                  ]);
                                            },
                                            child: Text(
                                              'ORDER',
                                              style: GoogleFonts.lato(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ])
                                ]),
                            decoration: BoxDecoration(
                              color: getBgColor(),
                              border: Border.all(color: getBorderColor()),
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            )),
                      ))
              : SizedBox(),
          CommonUtility().getBottomMenu(
              context, controller.productTitle, _scaffoldKey,
              showBack: true),
        ],
      ),
    );
  }
}
