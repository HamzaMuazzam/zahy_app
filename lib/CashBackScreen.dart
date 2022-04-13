//@dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    getData();

  }
  RefreshController _refreshController =

  RefreshController(initialRefresh: false);

  getData(){
    Future.delayed(Duration.zero, () async {
      provider.setCashback(false,null);
      isOK = await ApiServices.getCashBack();
      if (!isOK) {
        isOK = false;
        setState(() {});
      }
      provider.setPaymentHistory(false, null);
      ApiServices.getPaymentHistory();
    });
  }
  void _onRefresh() async{
      getData();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    _refreshController.loadComplete();
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
            return  SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Column(
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
                            Text(data.isCashBackLoaded
                                ?"${data.promotionCashBackFromJson.result.amount}":"0",
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
                        data.isPaymentHistoryLoaded && data.paymentHistoryResponseFromJson.result.spent.isNotEmpty
                            ?
                        Expanded(
                          child: ListView.builder(
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
                    ),
                        )
                            :
                        Container(child: Text("No Transactions Found".tr),)
                      ],
                    ),
            );
          }),
        ),
      ),
    );
  }
}
