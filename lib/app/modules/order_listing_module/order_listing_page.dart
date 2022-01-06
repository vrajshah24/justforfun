import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/order_listing_module/order_listing_controller.dart';
import 'package:untitled/app/modules/side_drawer_module/side_drawer_page.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/l10n.dart';
import 'package:untitled/main.dart';

class OrderListingPage extends GetView<OrderListingController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  OrderListingController controller = Get.put(OrderListingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: sideDrawerPage(context),
      body: Stack(children: [
        Obx(
          () => Container(
            child: controller.isLoading.value == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.getUserSalesModel.getUserSalesResult.lstMaterial
                        .isEmpty
                    ? Center(child: Text("no data"))
                    : ListView.builder(
                        // separatorBuilder: (context, index) =>
                        //     CommonUtility().getDividerOnly(1),
                        itemCount: controller.getUserSalesModel
                            .getUserSalesResult.lstMaterial.length,
                        padding: EdgeInsets.only(
                          top: 120,
                          left: 8,
                          right: 8,
                          bottom: 8,
                        ),
                        itemBuilder: (BuildContext context, int index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.getUserSalesModel.getUserSalesResult.lstMaterial[index].lstSalesDetail[0].cName.trim()}",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      Card(
                                        child: FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/icon/product1.png",
                                          image:
                                              "http://wellsunebusiness.online/" +
                                                  controller
                                                      .getUserSalesModel
                                                      .getUserSalesResult
                                                      .lstMaterial[index]
                                                      .lstSalesDetail[0]
                                                      .cPath
                                                      .trim()
                                                      .toString()
                                                      .replaceAll("~", ""),
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.24,
                                        ),
                                      ),
                                      //
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "MRP :".trim(),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "GROSS :",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${controller.getUserSalesModel.getUserSalesResult.lstMaterial[index].lstSalesDetail[0].nMrp} X ${controller.getUserSalesModel.getUserSalesResult.lstMaterial[index].lstSalesDetail[0].nQty}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${controller.getUserSalesModel.getUserSalesResult.lstMaterial[index].nGross}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller
                                                  .getUserSalesModel
                                                  .getUserSalesResult
                                                  .lstMaterial[index]
                                                  .nStatus ==
                                              0
                                          ? Expanded(
                                              child: IconButton(
                                                // onPressed: () => controller
                                                //     .cancelOrder(controller
                                                //         .getUserSalesModel
                                                //         .getUserSalesResult
                                                //         .lstMaterial[index]
                                                //         .nStatus),
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {},
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
          ),
        ),
        CommonUtility().getBottomMenu(context, orders(language), _scaffoldKey)
      ]),
    );
  }
}
