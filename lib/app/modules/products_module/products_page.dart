import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/product_details_module/product_details_page.dart';
import 'package:untitled/app/modules/products_module/products_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class ProductsPage extends GetView<ProductsController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(
        children: [
          Container(
            child: Obx(
              () => controller.isLoading.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.getAllProductsResultModel.getAllProductsResult
                          .lstProduct.length.isNullOrBlank
                      ? Center(
                          child: Text("no data"),
                        )
                      : ListView(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Text(
                              marketingAndSupply(language),
                              style: TextStyle(
                                fontFamily: getAmatic(),
                                fontSize: 42,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              organicFertilizer(language),
                              style: TextStyle(
                                  fontFamily: getProximaNova(), fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 2,
                              child: GridView.builder(
                                padding: EdgeInsets.all(8.0),
                                itemCount: controller.getAllProductsResultModel
                                    .getAllProductsResult.lstProduct.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          () => ProductDetailsPage(),
                                          arguments: [
                                            controller
                                                .getAllProductsResultModel
                                                .getAllProductsResult
                                                .lstProduct[index]
                                                .cName
                                                .toString(),
                                            controller
                                                .getAllProductsResultModel
                                                .getAllProductsResult
                                                .lstProduct[index]
                                                .nCode
                                                .toString()
                                          ],
                                        );
                                      },
                                      child: Container(
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          border: Border.all(
                                              color: getBorderColor()),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 2, 5, 2),
                                        child: Column(
                                          children: [
                                            FadeInImage.assetNetwork(
                                              placeholder:
                                                  "assets/icon/product1.png",
                                              image: "http://wellsunebusiness.online/" +
                                                  controller
                                                      .getAllProductsResultModel
                                                      .getAllProductsResult
                                                      .lstProduct[index]
                                                      .cPath
                                                      .toString()
                                                      .replaceAll("~", ""),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.24,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.24,
                                            ),
                                            SizedBox(height: 5),
                                            Center(
                                                child: Text(
                                                    controller
                                                        .getAllProductsResultModel
                                                        .getAllProductsResult
                                                        .lstProduct[index]
                                                        .cName,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            getProximaNova(),
                                                        fontSize: 14,
                                                        color: Colors.black),
                                                    textAlign:
                                                        TextAlign.center)),
                                            SizedBox(height: 4),
                                            Container(
                                              child: Center(
                                                child: Text(wellsun(language),
                                                    style: TextStyle(
                                                        fontFamily:
                                                            getProximaNova(),
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                              ),
                            )
                          ],
                        ),
            ),
          ),
          CommonUtility()
              .getBottomMenu(context, products(language), _scaffoldKey)
        ],
      ),
    );
  }
}
