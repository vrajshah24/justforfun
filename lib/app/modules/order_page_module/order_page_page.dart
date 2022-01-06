import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled/app/modules/order_page_module/order_page_controller.dart';
import 'package:untitled/app/theme/app_colors.dart';
import 'package:untitled/app/utils/CommonUtility.dart';
import 'package:untitled/generated/assets.dart';
import 'package:untitled/l10n.dart';

import '../../../main.dart';

class OrderPagePage extends GetView<OrderPageController> {
  OrderPageController controller = Get.put(OrderPageController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(8.0),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),

              getTextField("Bill Total", controller.billTotalController,
                  Assets.icon4014672BillContractCostDocumentMobileIcon,
                  isReadOnlyVal: true),
              //
              getTextField(
                "Payment Date",
                controller.paymentDateController,
                Assets.assets115762CalendarDateEventMonthIcon,
                isReadOnlyVal: true,
                tap: () => controller.pickDateDialog(context),
              ),
              //
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF1F8),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 16,
                      ),
                      Icon(
                        Icons.payment,
                        size: 25,
                      ),
                      Container(
                        height: 25,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        color: Color(0xFF979797),
                        width: 1,
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Obx(() {
                            return DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: DropdownButton<String>(
                                  value: controller.paymentType.value,
                                  hint: Text("Payment Type"),
                                  isDense: true,
                                  style: TextStyle(
                                    fontFamily: getProximaNova(),
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(13),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("Cash"), value: "0"),
                                    DropdownMenuItem(
                                        child: Text("Cheque"), value: "1"),
                                    DropdownMenuItem(
                                        child: Text("Online"), value: "2"),
                                  ],
                                  onChanged: (newValue) => controller
                                      .changeDropDownValue(newValue.toString()),
                                ),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //
              getTextField(
                "Payment Copy",
                controller.paymentCopyController,
                Assets.assetsNote,
                isReadOnlyVal: true,
                tap: () => controller.requestPermissons(),
              ),
              //
              getTextField(
                "Note",
                controller.noteController,
                Assets.assetsNote,
              ),
            ],
          ),
          CommonUtility().getBottomMenu(
            context,
            billingDetails(language),
            _scaffoldKey,
            showBack: true,
          )
        ],
      ),
      bottomNavigationBar: Obx(
        () => controller.placeOrderValue.value == true
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () => controller.placeOrder(),
                    child: Text("SAVE"),
                  ),
                ),
              ),
      ),
    );
  }

  Padding getTextField(
    String hint,
    var controller,
    String icon, {
    bool isReadOnlyVal = false,
    GestureTapCallback tap,
  }) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFEEF1F8),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
            ),
            Image.asset(
              icon,
              width: 25,
            ),
            Container(
              height: 25,
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              color: Color(0xFF979797),
              width: 1,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: TextFormField(
                  style: TextStyle(
                    fontFamily: getProximaNova(),
                    fontSize: 16,
                  ),
                  controller: controller,
                  readOnly: isReadOnlyVal,
                  onTap: tap,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Color(0xFFEEF1F8),
                    focusColor: Color(0xFFEEF1F8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(0xFFEEF1F8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(0xFFEEF1F8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: new BorderSide(
                        color: Color(0xFFEEF1F8),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
