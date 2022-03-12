import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GetReportsByUserId.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_location_screen.dart';
import 'package:musan_client/utils/colors.dart';

class OrderNowBottomSheet extends StatefulWidget {
  GetReportsByUserId reportsByUserIdFromJson;
  OrderNowBottomSheet(this.reportsByUserIdFromJson);


  @override
  _OrderNowBottomSheetState createState() => _OrderNowBottomSheetState(this.reportsByUserIdFromJson);
}
class _OrderNowBottomSheetState extends State<OrderNowBottomSheet> {
  GetReportsByUserId reportsByUserIdFromJson;
  _OrderNowBottomSheetState(this.reportsByUserIdFromJson);

  @override
  Widget build(BuildContext context) {
    return orderNowBottomSheet();
  }

  orderNowBottomSheet() {
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
              SizedBox(height: Get.height * .02),
              Text(
                "Do you know what's the issue?".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .022,
                  color: headingTextColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                child: Row(
                  children: [
                    Expanded(child: noOrYesButton(0, 'No'.tr)),
                    SizedBox(width: Get.width * .05),
                    Expanded(child: noOrYesButton(1, 'Yes'.tr)),
                  ],
                ),
              ),
              reportsByUserIdFromJson.result.length==0? Container():Text(
                "Call engineer".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .02,
                  color: themeColor,
                ),
              ),
              Divider(
                thickness: 2,
                color: Color(0xffF1F1F1),
              ),
              reportsByUserIdFromJson.result.length==0? Container() : Text(
                "Report List".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .022,
                  color: headingTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * .02),
              Column(children: List.generate(reportsByUserIdFromJson.result.length, (index){
                var result = reportsByUserIdFromJson.result[index];
                return Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(child: reportListWidget("Car Type".tr,result.carType)),
                      Expanded(child: reportListWidget("Date".tr,result.creationDate.toString())),
                      Expanded(child: reportListWidget("Issue Types".tr,getAllissue(result.issues))),
                    ],
                  ),
                  InkWell(onTap: (){
                    ApiServices.orderFromReport(result.reportId.toString());
                  },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                      child: Container(
                        width: Get.width,
                        height: Get.height * .07,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:   Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: themeColor, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(.13),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Text(
                          "Order".tr,
                          style: TextStyle(
                            color:  themeColor,
                            fontSize: Get.height * .02,
                          ),
                        ),
                      ),
                    ),
                  )
                ],);
              }))


            ],
          ),
        ),
      ),
    );
  }

  noOrYesButton(int index, String text) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          Get.back();
          Get.to(CarLocationScreen(isTechnicianOrder: 0));
        } else if (index == 1) {
          Get.back();
          Get.to(CarLocationScreen(isTechnicianOrder: 1));
        } else {
          Get.back();
          // Get.to(OrderFromReportService());
        }
      },
      child: Container(
        width: Get.width,
        height: Get.height * .07,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index == 1 ? themeColor : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: themeColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: index == 1 ? Colors.white : themeColor,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  Widget reportListWidget(String title,String subTitle) {
    return Padding(
      padding: EdgeInsets.only(right: Get.width * .06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title
          ,style: TextStyle(
              color: Color(0xff1E1E1E).withOpacity(.70),
              fontSize: Get.height * .018,
            ),
          ),
          SizedBox(height: Get.height * .007),
          Text(subTitle,style: TextStyle(
              color: themeColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String getAllissue(List<Issue> issues){

    List<String> data=[];
    for(int i=0;i<issues.length;i++){
      data.add(issues[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

}