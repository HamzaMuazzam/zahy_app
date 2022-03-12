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
     // ApiServices.getAllPaymentMethods(provider.userID,null,null,isShowBottomSheets: false);
     ApiServices.getPaymentHistory();
     if (widget.isShowAddCardNeeded) {
        // provider.showBottomPayment(null, null, null);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder,data,child){
// TOASTS("Something happening");
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
           /* Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .04,
              ),
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
                  Text(
                    'Payment Method'.tr,
                    style: TextStyle(
                      color: headingTextColor,
                      fontSize: Get.height * .02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  data.userAllPaymentMethodFromJson==null
                      ?
                  Center(child: CircularProgressIndicator(color: blue,),)
                      :
                  Column(
                            children: List.generate(
                                data.userAllPaymentMethodFromJson.result
                                    .length,
                                (index) => paymentMethodSelectionWidget(
                                    data.userAllPaymentMethodFromJson
                                        .result[index].isDefault,
                                    '${data.userAllPaymentMethodFromJson.result[index].company} ${data.userAllPaymentMethodFromJson.result[index].number}'
                                    ,data.userID,data.userAllPaymentMethodFromJson.result[index].userCardInfoId)),
                          ),
                  ],
              ),
            ),*/
  /*          Text(
              'Payments History'.tr,
              style: TextStyle(
                color: headingTextColor,
                fontSize: Get.height * .022,
                fontWeight: FontWeight.w400,
              ),
            ),*/
            // Container(
            //   width: Get.width,
            //   height: Get.height * .065,
            //   margin: EdgeInsets.symmetric(vertical: Get.height * .02),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color(0xff000000).withOpacity(.13),
            //         spreadRadius: .08,
            //         blurRadius: 1,
            //       ),
            //     ],
            //   ),
            //   child: TabBar(
            //     indicatorColor: themeColor,
            //     indicatorSize: TabBarIndicatorSize.tab,
            //     isScrollable: false,
            //     controller: _tabController,
            //     tabs: List.generate(
            //       2,
            //           (index) {
            //         return Text(
            //           index == 0 ? "Spent".tr : 'Pending'.tr,
            //           style: TextStyle(
            //             color:
            //             tabIndex == index ? headingTextColor : textColor,
            //             fontSize: Get.height * .02,
            //             fontWeight: FontWeight.w600,
            //           ),
            //         );
            //       },
            //     ),
            //     onTap: (index) {
            //       setState(() {
            //         tabIndex = index;
            //       });
            //     },
            //   ),
            // ),
            // tabIndex ==  1 ? _paymentHistoryPendingWidget(data) : _paymentHistorySpentWidget(data),
            _paymentHistorySpentWidget(data)

            // _addPaymentButton(),

            // TabBarView(
            //   physics: NeverScrollableScrollPhysics(),
            //   controller: _tabController,
            //   children: <Widget>[
            //     _paymentHistoryWidget(),
            //     _paymentHistoryWidget(),
            //   ],
            // ),
          ],
        ),
      ),
    );

    });
  }

/*  _paymentHistoryPendingWidget(DashboardProvider data) {
    return  data.isPaymentHistoryLoaded ? Expanded(
      child: ListView.builder(itemCount: data.paymentHistoryResponseFromJson.result.pending.length,itemBuilder: (context,index){
        var pending = data.paymentHistoryResponseFromJson.result.pending[index];
        return Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            vertical: Get.height * .02,
            horizontal: Get.width * .06,
          ),
          margin: EdgeInsets.symmetric(vertical: Get.height * .02),
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
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order number'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '${pending.orderId.toString()}',
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
                        'Order date'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '${pending.orderDate}',
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
            SizedBox(height: Get.height * .03),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Car name'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '${pending.carName}',
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
                        'Total cost'.tr,
                        style: TextStyle(
                          color: Color(0xff1E1E1E).withOpacity(.70),
                          fontSize: Get.height * .018,
                        ),
                      ),
                      SizedBox(height: Get.height * .01),
                      Text(
                        '\$${pending.totalCost.toString()}',
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
            InkWell(
              onTap: (){

                var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
                dashboardProvider.setPartIdAndORderId(partID:null,orderId:pending.orderId);
                Get.dialog(Center(child: CircularProgressIndicator(),));
                ApiServices.getDefaultPaymentMethods(data.userID,pending.totalCost.toString(),
                    pending.orderId.toString(),
                    pending.workshopId.toString(),
                    paymentType:"Final Bill".tr);


              },
              child: Container(
                width: Get.width,
                height: Get.height * .065,
                margin: EdgeInsets.only(
                  bottom: Get.height * .02,
                  top: Get.height * .04,
                  left: Get.width * .05,
                  right: Get.width * .05,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: themeColor, width: 1),
                ),
                child: Text(
                  'Pay now'.tr,
                  style: TextStyle(
                    color: themeColor,
                    fontSize: Get.height * .02,
                  ),
                ),
              ),
            ),
          ],
      ),
        );
      }),
    ):Center(child: CircularProgressIndicator(color: blue,),);
  }*/

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

/*
  _addPaymentButton() {
    return GestureDetector(
      onTap: (){
        provider.showBottomPayment(null,null,null);

      },
      child: Container(
        width: Get.width,
        height: Get.height * .07,
        margin: EdgeInsets.symmetric(vertical: Get.height * .03),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Text(
          'Add a payment method'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }
*/
/*
  paymentMethodSelectionWidget(bool isDefaultPAyment, name, String userID, int userCardInfoId) {
    return InkWell(
      onTap: () {
        if (isDefaultPAyment) {
          TOASTS("Already default payment method".tr);
          return;
        }
        TOASTS("Setting default payment method".tr);

        ApiServices.setDefaultPaymentMethod(userID,userCardInfoId);

      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 25,
                height: 25,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: isDefaultPAyment
                        ? themeColor
                        : Color(0xff6F7D95),
                    width: 1,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDefaultPAyment
                          ? themeColor
                          : Colors.transparent),
                ),
              ),
              SizedBox(width: 10),
              Text(
                name,
                style: TextStyle(
                  color: Color(0xff1E1E1E).withOpacity(.70),
                  fontSize: Get.height * .02,
                ),
              ),
            ],
          ),
          SizedBox(height: Get.height * .017),
        ],
      ),
    );
  }

  addPaymentMethodBottomSheet() {
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
                  thickness: 6,
                  color: Color(0xffF1F1F1),
                ),
              ),
              SizedBox(height: Get.height * .01),
              Text('Workshop service'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .022,
                  color: headingTextColor,
                ),
              ),
              SizedBox(height: Get.height * .01),

              SizedBox(height: Get.height * .01),
              Text(
                'your order is placed'.tr
                ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .019,
                  color: headingTextColor.withOpacity(.50),
                ),
              ),
              GestureDetector(
                onTap: () {

                  Get.back();
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * .065,
                  margin: EdgeInsets.only(
                    top: Get.height * .03,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(.13),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * .02,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  void showPayment() {

    showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text("Special Discount Offer Coming Soon!"),
            // content: Text( ""),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")
              ),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text("OK")
              ),
            ],
          );
        });
  }*/

}
