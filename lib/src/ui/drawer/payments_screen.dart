import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
class PaymentsScreen extends StatefulWidget {
  bool isShowAddCardNeeded;
  PaymentsScreen({this.isShowAddCardNeeded=false});

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen>
    with TickerProviderStateMixin {
  int paymentSelection;
  var tabIndex = 0;
  TabController _tabController;
  var provider = Provider.of<DashboardProvider>(Get.context,listen: false);

  @override
  void initState() {
    analytics.logScreenView(screenName: "PaymentsScreen",screenClass:"PaymentsScreen");

    tabIndex = 0;
    _tabController = TabController(vsync: this, length: 2);
   Future.delayed(Duration.zero,(){
     provider.setPaymentHistory(false, null);
     ApiServices.getPaymentHistory();
     if (widget.isShowAddCardNeeded) {
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder,data,child){
      return Scaffold(
      backgroundColor: screenBgColor,
      appBar: AppBar(
        backgroundColor: screenBgColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          'Payments History'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Get.width * .06,
          right: Get.width * .06,
          bottom: Get.height * .02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _paymentHistorySpentWidget(data)
          ],
        ),
      ),
    );

    });
  }



  _paymentHistorySpentWidget(DashboardProvider data) {
    return  data.isPaymentHistoryLoaded ? Expanded(
      child: ListView.builder(itemCount: data.paymentHistoryResponseFromJson.result.spent.length,itemBuilder: (context,index){
        var spent = data.paymentHistoryResponseFromJson.result.spent[index];
        return Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            vertical: Get.height * .02,
            horizontal: Get.width * .06,
          ),
          margin: EdgeInsets.symmetric(vertical: Get.height * .009),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(.13),
                spreadRadius: .08,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '${spent.totalCost.toString()} ${"SR".tr}',
                        style: TextStyle(
                          color: themeColor,
                          fontSize: Get.height * .022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date & Time'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '${DateFormat('yyyy-MM-dd').parse(spent.orderDate.toString())}'.replaceAll("00:00:00.000", ''),
                        style: TextStyle(
                          color: themeColor,
                          fontSize: Get.height * .022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * .015),
            InkWell(onTap: (){
              Get.dialog(Center(child: CircularProgressIndicator(color: blue,),));
              ApiServices.getSignleOrderByUserIDForPaymentHistory(spent.orderId.toString());
            },child: Text("View description".tr,style: TextStyle(fontSize: 20,color: blue),))


          ],
      ),
        );
      }),
    ):Center(child: CircularProgressIndicator(color: blue,),);
  }



}
