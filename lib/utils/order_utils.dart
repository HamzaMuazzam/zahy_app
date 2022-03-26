import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
var dashboard = Provider.of<DashboardProvider>(Get.context, listen: false);

orderCancelBottomSheet(Result result) {
  Get.bottomSheet(Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
    ),
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .06,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: Get.width * .2,
              child: Divider(
                thickness: 5,
                color: Color(0xffF1F1F1),
              ),
            ),
            SizedBox(height: Get.height * .02),
            Text(
              "Cancel order".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Get.height * .022,
                color: headingTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.height * .02),
            Text(
              "Are you sure you want to\ncancel this order?".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Get.height * .02,
                fontWeight: FontWeight.w600,
                color: headingTextColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.back();
                Get.dialog(Center(
                  child: CircularProgressIndicator(),
                ));
                ApiServices.cancelOrder(
                    result.orderId.toString(), result.workshopId.toString());
              },
              child: Container(
                width: Get.width,
                height: Get.height * .065,
                margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff000000).withOpacity(.13),
                      spreadRadius: .08,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Yes'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * .02,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                'No'.tr,
                style: TextStyle(
                  color: themeColor,
                  fontSize: Get.height * .02,
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    )));
}
bottomSheetForDawnPayment(Result result) async {
  if (Get.isBottomSheetOpen) {
    return;
  }
  bool isCashBack = await ApiServices.getCashBack();

  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "Pay down payment".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "you are requested to pay down payment before staring work!"
                        .tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .02,
                      fontWeight: FontWeight.w600,
                      color: headingTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      var dashboardProvider = Provider.of<DashboardProvider>(
                          Get.context,
                          listen: false);

                      Get.back();

                      // Get.dialog(Center(
                      //   child: CircularProgressIndicator(),
                      // ));

                      dashboardProvider.setPartIdAndORderId(
                          partID: null,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());
                      dashboardProvider.startPayingPayment(
                          "DownPayment".tr, result.downPayment.toString());

                      // ApiServices.getDefaultPaymentMethods(data.userID,
                      //     result.downPayment.toString(), result.orderId,
                      //     result.workshopId.toString(),
                      //     paymentType: "DownPayment".tr);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${"Pay SAR".tr} ${double.parse(result.downPayment.toString()).toInt()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  isCashBack &&
                      double.parse(result.downPayment.toString()) <
                          double.parse(dashboard
                              .promotionCashBackFromJson.result.amount
                              .toString())
                      ? GestureDetector(
                    onTap: () async {
                      var dashboardProvider =
                      Provider.of<DashboardProvider>(Get.context,
                          listen: false);
                      Get.back();

                      dashboardProvider.setPartIdAndORderId(
                          partID: null,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());
                      // dashboardProvider.startPayingPayment("DownPayment".tr, result.downPayment.toString());
                      var bool = await ApiServices.acceptAndPayDownPayment(
                          result.orderId.toString(),
                          isCashback: true);
                      if (bool == true) {
                        dashboardProvider.hitWorkshopForOrderProgressed(
                            result.workshopId.toString() ?? "0",
                            result.orderId.toString() ?? "0");
                      }
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin:
                      EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${"Pay from wallet".tr} ${"SAR".tr} ${double.parse(result.downPayment.toString()).toInt()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      ApiServices.rejectDownPayment(
                          result.orderId.toString(), result.workshopId);
                    },
                    child: Text(
                      'Reject'.tr,
                      style: TextStyle(
                        color: themeColor,
                        fontSize: Get.height * .02,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}
bottomSheetForEditTimeAndCost(Result result) {
  if (Get.isBottomSheetOpen) {
    return;
  }
  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "${"Order number".tr} ${result.orderId}\n${"Time and cost changes".tr}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Column(
                                children: [
                                  Text("Timing".tr, style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${result.pendingEditedDays} ${"Days".tr}",
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                      Expanded(
                          child: Center(
                              child: Column(
                                children: [
                                  Text("Work Price".tr, style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${"SR".tr} ${double.parse(result.pendingEditedCost.toString()).toInt()}",
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      var dashboardProvider = Provider.of<DashboardProvider>(
                          Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                          partID: null, orderId: result.orderId);
                      Get.back();
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));
                      // ApiServices.getDefaultPaymentMethods(data.userID,result.pendingEditedCost.toString().toString(),
                      //     result.orderId,paymentType:"EditTimeAndCost");

                      ApiServices.acceptEditInTimeAndCost(
                          dashboardProvider.orderId.toString(),
                          result.workshopId.toString());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Accept'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));
                      ApiServices.rejectEditInTimeAndCost(
                          result.orderId.toString(),
                          result.workshopId.toString());
                    },
                    child: Text(
                      'Reject'.tr,
                      style: TextStyle(
                        color: themeColor,
                        fontSize: Get.height * .02,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}

bottomSheetToAcceptOrderParts(
    Result result, List<OrderPart> orderParts) async {
  if (Get.isBottomSheetOpen) {
    return;
  }
  bool isCashBack = await ApiServices.getCashBack();
  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "Order Part".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: List.generate(orderParts[0].pictures.length,
                                      (index) {
                                    print(orderParts[0].pictures.length);
                                    return InkWell(
                                      onTap: () {
                                        openImage(
                                            "https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}");
                                      },
                                      child: Image.network(
                                        orderParts[0].pictures.length == 0
                                            ? "https://tamam.com.pk/logoplaceholder.png"
                                            : "https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}",
                                        height: 80,
                                        width: 60,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  }),
                            ),
                          )),
                      Expanded(
                          child: Center(
                              child: Column(
                                children: [
                                  Text(orderParts[0].partName ?? "",
                                      style: TextStyle(fontSize: 16)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${"SR".tr} ${orderParts[0].partCost}",
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ))),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      var dashboardProvider = Provider.of<DashboardProvider>(
                          Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                          partID: orderParts[0].orderPartId,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());
                      await Get.back();
                      await dashboardProvider.startPayingPayment(
                          "OrderPart".tr, orderParts[0].partCost.toString());

                      // Get.dialog(Center(child: CircularProgressIndicator(),));

                      // ApiServices.getDefaultPaymentMethods(
                      //     data.userID,
                      //     orderParts[0].partCost.toString(), result.orderId,result.workshopId.toString(),
                      //     paymentType: "OrderPart".tr
                      // );
                      // ApiServices.acceptEditInTimeAndCost(
                      //     result.orderId.toString());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .06,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Accept & Pay'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///
                  isCashBack &&
                      double.parse(result.downPayment.toString()) <
                          double.parse(dashboard
                              .promotionCashBackFromJson.result.amount
                              .toString())
                      ? GestureDetector(
                    onTap: () async {
                      var dashboardProvider =
                      Provider.of<DashboardProvider>(Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                          partID: orderParts[0].orderPartId,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());
                      await Get.back();

                      var bool = await ApiServices.acceptPart(
                          isPaid: true,
                          partID: orderParts[0].orderPartId,
                          orderId: result.orderId.toString(),
                          workshopId: result.workshopId.toString(),
                          isCashBack: true);

                      if (bool == true) {
                        dashboardProvider.hitWorkshopForOrderProgressed(
                            result.workshopId.toString() ?? "0",
                            result.orderId.toString() ?? "0");
                        logger.i("DSDDDSDSDSDSD");
                      }


                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .06,
                      margin:
                      EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Accept & Pay by Wallet'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                      : Container(),

                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));

                      ApiServices.acceptPart(
                          isPaid: false,
                          partID: orderParts[0].orderPartId,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .06,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Accept & pay later'.tr,
                          style: TextStyle(
                            color: blue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));
                      ApiServices.rejectOrderParts(orderParts[0].orderPartId,
                          result.orderId, result.workshopId.toString());
                    },
                    child: Text(
                      'Reject'.tr,
                      style: TextStyle(
                        color: themeColor,
                        fontSize: Get.height * .02,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}
void checkAndSeePendingPayments(Result result) async {
  Future.delayed(Duration.zero, () {
    if (result != null) {
      try {
        if (result.isDownPaymentRequested && !result.isDownPaymentCompleted) {
          /// show dialoge for accept down payment here
          print("pay dawn payment");
          bottomSheetForDawnPayment(result);
        } else if (result.editsPending) {
          /// show sheet here to accept edit time and cost
          print('show sheet here to accept edit time and cost');
          bottomSheetForEditTimeAndCost(result);
        } else if (checkAnyPartIsInPendingApproval(result)) {
          /// show sheet to accept parts approval
          print("show sheet to accept parts approval");
          List<OrderPart> orderParts = [];
          for (int i = 0; i < result.orderParts.length; i++) {
            if (result.orderParts[i].pendingApproval &&
                !result.orderParts[i].isApproved) {
              orderParts.add(result.orderParts[i]);
            }
          }
          if (orderParts.length > 0) {
            bottomSheetToAcceptOrderParts(result, orderParts);
          }
        } else if (!result.isFinalPaymentCleared &&
            checkFinalBillIsNeededToShowOrNot(result) == "Completed".tr &&
            !result.isCash) {
          // TOASTS("data");
          bottomSheetToFinalBill(result);
        } else if (result.isCarPickupOrdered &&
            !result.isCarPickupPaid &&
            setOrderStatus(0, result.orderSteps) == "Completed".tr) {
          bottomSheetForCarPickPayment(result);
        }
      } catch (e) {
        print(e);
      }
    }
  });
}

String setOrderStatus(int i, List<OrderStep> orderSteps) {
  try {
    if (i == 0) {
      if (orderSteps[0].orderStepStatus == 0) {
        return "in process".tr;
        print("Gello");
      } else
        return "Completed".tr;
    }
    if (i == 1) {
      if (orderSteps[0].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[1].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    }
    if (i == 2) {
      if (orderSteps[0].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[1].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[2].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    }
    if (i == 3) {
      if (orderSteps[0].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[1].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[2].orderStepStatus == 0) {
        return "";
      }
      if (orderSteps[3].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    }
    if (i == 4) {
      if (orderSteps[0].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[1].orderStepStatus == 0) {
        return " ";
      }
      if (orderSteps[2].orderStepStatus == 0) {
        return "";
      }
      if (orderSteps[3].orderStepStatus == 0) {
        return "";
      }
      if (orderSteps[4].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    }
  } catch (e) {
    return " ";
  }
}

bottomSheetToFinalBill(Result result) async {
  if (Get.isBottomSheetOpen) {
    return;
  }

  bool isCashBack = await ApiServices.getCashBack();

  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "Pay Final Bill".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .005),
                  Text(
                    "${"SR".tr} ${double.parse(result.totalCost.toString()).toStringAsFixed(2)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  GestureDetector(
                    onTap: () async {
                      var dashboardProvider = Provider.of<DashboardProvider>(
                          Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                          partID: null,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());

                      // Final Bill
                      logger.w(result.totalCost.toString());
                      if (Get.isBottomSheetOpen) {
                        Get.back();
                      }
                      await dashboardProvider.startPayingPayment(
                          "Final Bill".tr, result.totalCost.toString());

                      // ApiServices.getDefaultPaymentMethods(data.userID,
                      //     result.totalCost.toString(), result.orderId,
                      //     result.workshopId.toString(),
                      //     paymentType: "Final Bill".tr);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Pay'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  isCashBack &&
                      double.parse(result.downPayment.toString()) <
                          double.parse(dashboard
                              .promotionCashBackFromJson.result.amount
                              .toString())
                      ? GestureDetector(
                    onTap: () async {
                      var dashboardProvider =
                      Provider.of<DashboardProvider>(Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                          partID: null,
                          orderId: result.orderId,
                          workshopId: result.workshopId.toString());

                      // Final Bill
                      logger.w(result.totalCost.toString());
                      if (Get.isBottomSheetOpen) {
                        Get.back();
                      }
                      // await  dashboardProvider.startPayingPayment("Final Bill".tr, result.totalCost.toString());

                      await ApiServices.payFinalBill(result.orderId.toString(),
                          isCash: false, isWallet: true);
                      dashboardProvider.hitWorkshopForOrderProgressed(
                          result.workshopId.toString() ?? "0",
                          result.orderId.toString() ?? "0");

                      // ApiServices.getDefaultPaymentMethods(data.userID,
                      //     result.totalCost.toString(), result.orderId,
                      //     result.workshopId.toString(),
                      //     paymentType: "Final Bill".tr);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin:
                      EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Final Bill via wallet'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                      : Container(),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      showProgress();

                      ApiServices.payFinalBill(result.orderId.toString(),
                          isCash: true);
                      // var provider = Provider.of<DashboardProvider>(context, listen: false);
                      // provider.setPartIdAndORderId(partID:0,orderId:result.orderId,workshopId: result.workshopId.toString());
                      // ApiServices.makeFinalPaymentCOD( provider.userID,result.totalCost.toString(),true,result.orderId.toString());
                      // ApiServices.initPayment(
                      //     provider.userID,
                      //     0,
                      //     "visa".tr,
                      //     (double.parse(result.totalCost.toString()) * 100)
                      //         .toString(),
                      //     "${result.orderId.toString()}",
                      //     isCash: true,
                      //     orderID: result.orderId.toString());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Cash on Delivery'.tr,
                          style: TextStyle(
                              color: themeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}

bool checkAnyPartIsInPendingApproval(Result result) {
  for (int i = 0; i < result.orderParts.length; i++) {
    if (result.orderParts[i].pendingApproval) {
      print("sghghjghjg");

      return true;
    }
  }

  return false;
}

String checkFinalBillIsNeededToShowOrNot(Result result) {
  try {
    if (result.isCarPickupOrdered) {
      /// five steps
      if (result.orderSteps[3].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    } else {
      /// three steps
      if (result.orderSteps[1].orderStepStatus == 0) {
        return "in process".tr;
      } else
        return "Completed".tr;
    }
  } catch (e) {
    return 'in process'.tr;
  }
}

void bottomSheetForCarPickPayment(Result result) {
  // TOASTS("data".tr);

  if (Get.isBottomSheetOpen) {
    return;
  }
  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "Pay Car Pick up Bill".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .005),
                  Text(
                    "${"SR".tr} ${result.carPickupOrderAmount}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  GestureDetector(
                    onTap: () {
                      var dashboardProvider = Provider.of<DashboardProvider>(
                          Get.context,
                          listen: false);
                      dashboardProvider.setPartIdAndORderId(
                        partID: null,
                        orderId: result.orderId,
                      );
                      Get.back();
                      Get.dialog(Center(
                        child: CircularProgressIndicator(),
                      ));

                      // TOASTS( "result.orderId ${result.orderId}");

                      dashboardProvider.setCarPickOrderID(
                        result.carPickupOrderId.toString(),
                        result.carPickUpId.toString(),
                        result.workshopId.toString(),
                      );

                      dashboardProvider.startPayingPayment(
                          "CarPickUp".tr, result.totalCost.toString());

                      // ApiServices.getDefaultPaymentMethods(data.userID,
                      //     result.carPickupOrderAmount.toString(), result.orderId,
                      //     result.workshopId.toString(),
                      //     paymentType: "CarPickUp".tr);
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Pay'.tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      // Get.dialog(Center(
                      //   child: CircularProgressIndicator(),
                      // ));
                      // // ApiServices.payFinalBill(result.orderId.toString(),isCash:true);
                      // var provider =
                      // Provider.of<DashboardProvider>(context, listen: false);
                      // ApiServices.initPayment(
                      //     provider.userID,
                      //     0,
                      //     "visa",
                      //     (double.parse(result.totalCost.toString()) * 100)
                      //         .toString(),
                      //     "${result.orderId.toString()}",
                      //     isCash: true,
                      //     refID: result.orderId.toString());
                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: blue),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(.13),
                            spreadRadius: .08,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Cancel'.tr,
                          style: TextStyle(
                              color: themeColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}


getOrderPart(Result result, int index) {
  List<Widget> list = [
    InkWell(
      onTap: () {
        bottomSheetToAcceptOrderParts(result, result.orderParts);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Container(
            decoration: BoxDecoration(
                color: blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: green,
                  ),
                  Text(
                    'Accept & Pay'.tr,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )),
      ),
    ),
    InkWell(
      onTap: () {
        showProgress();

        ApiServices.rejectOrderParts(result.orderParts[index].orderPartId,
            result.orderId, result.workshopId);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Container(
            decoration: BoxDecoration(
                color: blue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.close,
                    color: red,
                  ),
                  Text(
                    'Reject'.tr,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            )),
      ),
    ),
  ];

  return Get.locale.toString().contains("ar") ? list.reversed.toList() : list;
}


getOrderPart1(Result result, int index, {Color detailColor: black}) {
  List<Widget> list = [
    Row(
      children: [
        Text(
          result.orderParts[index].partName,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(
          width: 5,
        ),
        !result.orderParts[index].pendingApproval &&
            !result.orderParts[index].isApproved
            ? Container(
            decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              child: Text(
                'Rejected'.tr,
                style: TextStyle(color: red),
              ),
            ))
            : result.orderParts[index].isApproved
            ? Container(
            decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4, horizontal: 5),
              child: Text(
                'Accepted'.tr,
                style: TextStyle(color: green),
              ),
            ))
            : Container(
            decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4, horizontal: 5),
              child: Text(
                'New'.tr,
                style: TextStyle(color: yellow),
              ),
            ))
      ],
    ),
    Text(
      '${"SR".tr} ${result.orderParts[index].partCost.toString()}',
      style: TextStyle(
          color: detailColor, fontSize: 13, fontWeight: FontWeight.bold),
    )
  ];

  return Get.locale.toString().contains("ar") ? list.reversed.toList() : list;
}

getPartCost(Result result) {
  double priceOfParts = 0;
  for (int i = 0; i < result.orderParts.length; i++) {
    if (result.orderParts[i].isApproved && !result.orderParts[i].isPaid) {
      priceOfParts = priceOfParts +
          double.parse(result.orderParts[i].partCost.toString());
    }
  }
  return priceOfParts;
}

getTextList(String title, String detail,
    {Color headingColor: black,
      Color detailsColor: black,
      FontWeight detailWeight: FontWeight.w500}) {
  List<Widget> list = [
    Text(title,
        style: TextStyle(
          color: headingColor,
        )),
    Text(
      detail,
      style: TextStyle(
          color: detailsColor, fontSize: 16, fontWeight: detailWeight),
    )
  ];
  // return Get.locale.toString().contains("en") ? list : list.reversed.toList();

  return list;
}

String getAllissue(List<Fault> faults) {
  List<String> data = [];
  for (int i = 0; i < faults.length; i++) {
    data.add(faults[i].name);
  }
  return data.toString().replaceAll("[", "").replaceAll("]", "");
}

String getFualts(Result result) {
  List<String> faults = [];
  result.faults.forEach((element) {
    faults.add(element.name);
  });
  return faults.toString().replaceAll("[", '').replaceAll("]", '');
}

String getLastLocation(Result result) {

  try {
    var split = result.workshopAddress.toString().split("،");
    return split[1]+"،"+split[2];
  } catch (e) {
    return '';
  }
}
Widget workhsopProfileWidget(Result result) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          height: Get.height * 0.07,
          width: Get.width * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
              image: DecorationImage(
                  fit: BoxFit.fill,
  // NetworkImage("https://muapi.deeps.info/${order.displayImage}")
                  image: NetworkImage(
                      result.displayImage==null
                          ?
                      'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'
                          :
                      'https://muapi.deeps.info/${result.displayImage}'
                  ))),
        ),
      ),
      Expanded(
          child: !result.isTechnicianOrder
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                result.workshopName.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height * 0.015,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/save_tick_icon.svg',
                          height: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Verified Shop".tr,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: Get.height * 0.016,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/google.svg',
                          height: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${result.googleRatings??0}/5".tr,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height * 0.016),
                        ),
                        Icon(
                          Icons.star,
                          color: orangeYellow,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/warranty.svg',
                          height: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Offer Warranty".tr,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: Get.height * 0.016),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Expanded(
                    child: result.isElite
                        ? Row(
                      children: [
                        Image.asset(
                          'assets/images/yello_starr_filled.png',
                          height: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6),
                          child: Text(
                            "Elite".tr,
                            style: TextStyle(
                                color: orangeYellow,
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                  ),
                ],
              ),
            ],
          )
              : Container())
    ],
  );
}
