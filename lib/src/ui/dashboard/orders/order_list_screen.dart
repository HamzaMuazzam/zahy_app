import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:musan_client/FCM.dart';
import 'package:musan_client/OrderOfferScreen.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart' as offer;
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart' as order;
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytics.logScreenView(
        screenName: "OrderScreen", screenClass: "OrderScreen");
    getOffersAndOderAtOnce();
  }
var orderProvider=Provider.of<OrderScreenProvider>(Get.context,listen: false);
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderScreenProvider>(builder: (builder, data, child) {
      return Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: null,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "My Orders".tr,
              style: TextStyle(color: Colors.black),
            ),
          ),
          body:

              data.isInprogressCompletedOrderDataLoaded
                  ||
              data.isFreshOrderDataLoaded?
              SingleChildScrollView(
            child:

            Column(
              children: [
                data.isFreshOrderDataLoaded
                    ? Column(
                        children: List.generate(
                            data.getFreshOrderByUserIdReponse.result.length,
                            (index) => offerItem(offer:data.getFreshOrderByUserIdReponse.result[index])),
                      )
                    : Container(),
                data.isInprogressCompletedOrderDataLoaded
                    ? Column(
                        children: List.generate(
                            data.completedOrInProgressOrderByUserIdFromJson
                                .result.length,
                            (index) => orderItem(
                                order: data
                                    .completedOrInProgressOrderByUserIdFromJson
                                    .result[index])),
                      )
                    : Container()
              ],
            )

          )
              :
              Center(child: CircularProgressIndicator(color: Colors.blue,),)

      );
    });
  }

  Widget orderItem({order.Result order}) {
    return InkWell(
      onTap: (){
        orderProvider.isSingleOrderDataLoaded=false;
        Get.to(OrderTracking(null,true,order.orderId));
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(color: greyShade.withOpacity(0.1),borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: order.displayImage==null
                                ?
                            AssetImage("assets/logo.png"):
                            NetworkImage("https://muapi.deeps.info/${order.displayImage}")
                        )),
                  ),
                  Expanded(
                      child: Container(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(order.workshopName.name ?? "",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                              Spacer(),
                              Text("${double.parse(order.totalCost.toString()).toInt()} ${"SAR".tr}",style: TextStyle(color: blue,
                              fontWeight: FontWeight.w600,fontSize: 17),),
                            ],
                          ),
                          Text(_getStepsName(order),
                          style: TextStyle(color: _getStepsName(order).contains("Completed") ? green:orangeYellow,fontSize: 16),
                          ),
                          SizedBox(height: 5,),
                          Text(order.creationDate.replaceAll("T00:00:00", ""),style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )),
      ),
    );
  }


  Widget offerItem({offer.Result offer}) {
    return InkWell(
      onTap: (){
        Get.to(()=> OrderOfferScreen(offer.orderId.toString()));
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          decoration: BoxDecoration(color: greyShade.withOpacity(0.1),borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/logo.png"))),
                  ),
                  Expanded(
                      child: Container(

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  offer.carName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              Text("${getAveragePrice(offer)} ${"SAR".tr}",style: TextStyle(color: blue,
                              fontWeight: FontWeight.w600,fontSize: 17),),
                            ],
                          ),
                          Text("${offer.offers.length} ${"Offers Received".tr}",
                          style: TextStyle(color:orangeYellow,fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5,),
                          Text(offer.creationDate.replaceAll("T00:00:00", ""),style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )),
      ),
    );
  }

  String _getStepsName(order.Result result) {
    try {
      if (!result.isCarPickupOrdered && !result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[0].orderStepStatus.toString() == "1" &&
            result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Fixing".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "1" &&
            result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Deliver".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "1") {
          return "Completed".tr;
        }
      } else if (result.isCarPickupOrdered && !result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "On the way".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Picking up".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[3].orderStepStatus.toString() == "0") {
          return "Fixing".tr;
        } else if (result.orderSteps[4].orderStepStatus.toString() == "0") {
          return "Deliver".tr;
        }
      } else if (result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Checking".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Report Deliver".tr;
        }
      }
    } catch (e) {
      print(e);
    }

    return "".tr;
  }
}


