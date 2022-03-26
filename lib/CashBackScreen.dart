import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class CashBackScreen extends StatefulWidget {
  const CashBackScreen({Key key}) : super(key: key);

  @override
  State<CashBackScreen> createState() => _CashBackScreenState();
}

class _CashBackScreenState extends State<CashBackScreen> {
  Color barColor = const Color(0xffF0F2F5);
  List selectionList = ["Week", "Month", "Year"];
  int selectionIndex = 0;
  bool isOK = true;
  var provider = Provider.of<DashboardProvider>(Get.context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      isOK = await ApiServices.getCashBack();
      if (!isOK) {
        isOK = false;
        setState(() {});
      }
      provider.setPaymentHistory(false, null);
      ApiServices.getPaymentHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cashback".tr,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SizedBox(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Consumer<DashboardProvider>(builder: (context, data, child) {
            return data.isCashBackLoaded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Your Wallet'.tr,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SAR".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.height * 0.04)),
                          const SizedBox(width: 5),
                          Text(
                              "${data.promotionCashBackFromJson.result.amount}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Get.height * .08,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Transactions".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.height * 0.025),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      data.isPaymentHistoryLoaded
                          ?
                      ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.paymentHistoryResponseFromJson.result.spent.length,
                    itemBuilder: (BuildContext context, int index) {
                      var spent = data.paymentHistoryResponseFromJson.result.spent[index];
                      return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${spent.carName}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17)),
                              Text("${spent.orderDate.replaceAll("T00:00:00", "")}",
                                  style:
                                  TextStyle(color: Colors.grey.withOpacity(.5)))
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("${spent.totalCost} ${"SAR".tr}",
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17)),
                              Text("${"Order #".tr} ${spent.orderId}",
                                  style:
                                  TextStyle(color: Colors.grey.withOpacity(.5)))
                            ],
                          ),
                        ],
                      ),
                    );
                    },
                  )
                          :
                          Container()
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:musan_client/api_services/ApiServices.dart';
// import 'package:musan_client/src/ui/auth/SignUp.dart';
// import 'package:provider/provider.dart';
//
// import 'src/provider/dashboard_provider.dart';
//
// class CashBackScreen extends StatefulWidget {
//   const CashBackScreen({Key key}) : super(key: key);
//
//   @override
//   _CashBackScreenState createState() => _CashBackScreenState();
// }
//
// class _CashBackScreenState extends State<CashBackScreen> {
//   bool isOK =true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration.zero,()async{
//       isOK = await ApiServices.getCashBack();
//       if(!isOK){
//         isOK =false;
//         setState(() {
//
//         });
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DashboardProvider>(
//       builder: (context,data,child) {
//         return Scaffold(
//           appBar: AppBar(title: Text("Cashback".tr),),
//           body:
//           data.isCashBackLoaded? Container(
//             width: Get.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         "You have Cashback of: ".tr,
//                         style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text("SR".tr+" ${data.promotionCashBackFromJson.result.amount}".tr,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: blue),),
//                     ),
//
//                   ],
//                 ),
//           )
//             :
//           isOK ?
//           Center(
//                 child: CircularProgressIndicator(),
//               ):Container(),
//       );
//     });
//   }
// }
