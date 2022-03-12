import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../ColumnCard.dart';

class MyCarsOrderDetails extends StatelessWidget {
  OrderHistory orderHistory;
  MyCarsOrderDetails(this.orderHistory);



  // OrderScreenProvider data;
  // int index=0;
  // OrderDetailsCompleted(this.data,this.index);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        backgroundColor: screenBgColor,
        appBar: AppBar(
          backgroundColor: screenBgColor,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          title: Text(
            'Order details'.tr,
            style: TextStyle(
              color: headingTextColor,
              fontSize: Get.height * .026,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02,
                  horizontal: Get.width * .05,
                ),
                margin: EdgeInsets.all(Get.height * .02),
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
                    Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: true
                            ? Color(0xff17CE3F).withOpacity(.30)
                            : Color(0xffFFD037).withOpacity(.28),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          true ? 'Completed'.tr : 'In progress'.tr,
                          style: TextStyle(
                            color: true
                                ? Color(0xff004910)
                                : Color(0xffea480c),
                            fontSize: Get.height * .017,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${orderHistory.workshopName.toString()}",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {},
                                        starCount: 5,
                                        rating: orderHistory.workshopRating ==null ? 0.0 : orderHistory.workshopRating,
                                        size: 20.0,
                                        isReadOnly: true,
                                        // fullRatedIconData: Icons.blur_off,
                                        // halfRatedIconData: Icons.blur_on,
                                        color: Color(0xFFFAB002),
                                        borderColor: Color(0xFFFAB002),
                                        spacing: 0.0),
                                    Text(
                                      orderHistory.workshopRating == null ?  "0" : orderHistory.workshopRating.toString(),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFFAB002),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFFE0DCDC),
                                        offset: Offset(0.5, 0.5),
                                        blurRadius: 0.5,
                                        spreadRadius: 0.5)
                                  ],
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image:
                                  DecorationImage(image: AssetImage("assets/images/carlogo.png"))),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: _issueDetail(orderHistory) ,
                    ),


                  ],
                ),
              ),
            ),
            // _orderNowButton()
          ],
        ),
      ),
    );
  }
  Widget _issueDetail(OrderHistory orderHistory){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                    'Order number'.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Get.height * .017,
                    ),
                  )),
              Expanded(
                  child: Text('Order date'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Get.height * .017,
                      ))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      '${orderHistory.orderId}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: Get.height * .02,
                          fontWeight: FontWeight.bold),
                    )),
                Expanded(
                    child: Text('${orderHistory.creationDate}'.replaceAll("T00:00:00",''),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: Get.height * .02,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          Text(
            'Issue'.tr,
            style: TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(getAllissue2(orderHistory.issues),
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.height * .023,
                    fontWeight: FontWeight.bold)),
          ),
          Text(
            'Cost'.tr,
            style: TextStyle(color: Colors.grey),
          ),
          Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Invoices'.tr,
                      style: TextStyle(color: grey),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VAT'.tr),
                    Text(
                      '${"SR".tr} ${double.parse(orderHistory.vatValue.toString()).toInt()}',
                      style: TextStyle(color: blue, fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),    Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Musan fee'.tr),
                    Text(
                      '${"SR".tr} ${double.parse(orderHistory.musanFee.toString()).toInt()}',
                      style: TextStyle(color: blue, fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Work cost'.tr),
                    Text(
                      '${"SR".tr} ${double.parse(orderHistory.workCost.toString()).toInt()}',
                      style: TextStyle(color: blue, fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              // Container(
              //   height: orderHistory.orderParts.length!=0? MediaQuery.of(Get.context).size.width * 0.35 : 0,
              //   child: Scrollbar(
              //     child: SingleChildScrollView(
              //       child: Column(
              //         children: List.generate(result.orderParts.length, (index) => Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Text(result.orderParts[index].partName,style: TextStyle(fontSize: 15),),
              //                     ],
              //                   ),
              //                   Text(
              //                     'SR ${result.orderParts[index].partCost}',
              //                     style: TextStyle(color: blue, fontSize: 13, fontWeight: FontWeight.bold),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 Expanded(
              //                     flex: 2,
              //                     child: Align(
              //                         alignment: Alignment.centerLeft,
              //                         child: ApprovalChip(
              //                           isCompleted: result.orderParts[index].isApproved ? "Accepted" :
              //                           result.orderParts[index].pendingApproval ? "Waiting Approval" :
              //                           !result.orderParts[index].pendingApproval  &&  !result.orderParts[index].isApproved ?
              //                           "Rejected": "Rejected"
              //                           ,
              //                         ))
              //                 ),
              //                 Spacer(
              //                   flex: 2,
              //                 ),
              //                 Expanded(
              //                     child: TileButton(
              //                       onTap: () {},
              //                       title: 'PDF',
              //                       isOutlined: true,
              //                       height: 25,
              //                     ))
              //               ],
              //             ),
              //           ],
              //         )),
              //       ),
              //     ),
              //   ),
              // ),
              Divider(
                color: grey,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total cost'.tr),
                    Text(
                      '${"SR".tr} ${double.parse(orderHistory.totalCost.toString()).toInt().toString()}',
                      style: TextStyle(color: blue, fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Timing'),
              //       Text(
              //         '${orderHistory.timeInDays} Days',
              //         style: TextStyle(color: blue, fontSize: 17, fontWeight: FontWeight.bold),
              //       )
              //     ],
              //   ),
              // ),

            ],
          ),

          /*  Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Part Name',
                  style: TextStyle(
                    fontSize: Get.height * .023,
                  ),
                ),
                Text(
                  'SR 500',
                  style: TextStyle(
                    fontSize: Get.height * .023,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fixing',
                  style: TextStyle(
                    fontSize: Get.height * .023,
                  ),
                ),
                Text(
                  'SR 500',
                  style: TextStyle(
                    fontSize: Get.height * .023,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fees',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.height * .023,
                  ),
                ),
                Text(
                  'SR 100',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.height * .023,
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _orderNowButton() {
    return GestureDetector(
      onTap: () {
        // Get.bottomSheet(OrderNowBottomSheet());
      },
      child: Container(
        width: Get.width * .88,
        height: Get.height * .07,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20),
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
          'Order Now'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  String getAllissue2(List<Issue> issues){
    var faults =issues;
    List<String> data=[];
    for(int i=0;i<faults.length;i++){
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

}
