import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';
import 'package:musan_client/src/ui/dashboard/home/order_from_service.dart';
import 'package:musan_client/src/ui/dashboard/myCars/MyCarsOrderDetails.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'discount_list_screen.dart';

class CarDetailsScreen extends StatefulWidget {
  Result result;
  CarDetailsScreen(this.result, {Key key}) : super(key: key);

  @override
  _CarDetailsScreenState createState() => _CarDetailsScreenState(result);
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {

  Result result;

  _CarDetailsScreenState(this.result);

  int index=0;

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:  Text("Car Details".tr , style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        leading: InkWell(
            onTap: (){

              Get.back();

            },
            child: const Icon(Icons.arrow_back ,color: Colors.black,)),
        actions: const [Padding(
          padding: EdgeInsets.only(right: 8.0,left: 8),
          child: Icon(Icons.edit ,color: Colors.black,),
        ),],

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: blueShade,
        child: Column(
          children: [
            Container(
              height: 0.5,
              color: Colors.grey,
            ),

            /// top

            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// image
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Image.network("https://i.imgur.com/cP53jb6.jpg" ,height:Get.height*0.1,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(children: [
                      Text(
                        result.carName??"",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                      ),
                      // Text(
                      //   result.carType??"",
                      //   style: TextStyle(
                      //       color: Colors.grey.shade500,
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ]),
                  ),

                 SizedBox(
                   height: Get.height*0.03,
                 ),
                  Container(

                    height: 0.5,
                    color: Colors.grey,
                  ),
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceAround,
                    children: [
                      /// model
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 5),
                          child: Column(
                            children: [
                              Text(
                                "Model".tr,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                result.model??"",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),


                      /// color
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey,
                                width: 0.5
                              ),
                              left: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5
                              ),
                            )

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13.0 ,horizontal: 18),
                            child: Column(
                              children: [
                                Text(
                                  "Color".tr,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  result.color??"",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),


                      /// gear
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Column(
                            children: [
                              Text(
                                "Gear transmission".tr,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                result.carTransmission??"",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Expanded(
                  child: InkWell(
                    onTap: (){
                      index=0;
                      setState(() {

                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                     Container(
                       // alignment: Alignment.centerLeft,
                       decoration: BoxDecoration(  color: blueShade,),
                       child:  Padding(
                         padding: EdgeInsets.all(10),
                         child: Text(
                           "Latest orders".tr,
                           style: TextStyle(
                               fontWeight: FontWeight.bold, fontSize: 17),
                         ),
                       ),
                     ),
                       Container(height: 2.5,color:  index==0 ? Colors.white:Colors.transparent,)
               ],),
                  ),
                ),
                    Expanded(
                  child: InkWell(
                    onTap: (){
                      index=1;
                      setState(() {

                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                     Container(
                       // alignment: Alignment.centerLeft,
                       decoration: BoxDecoration(  color: blueShade,),
                       child:  Padding(
                         padding: EdgeInsets.all(10),
                         child: Text(
                           "Reports".tr,
                           style: TextStyle(
                               fontWeight: FontWeight.bold, fontSize: 17),
                         ),
                       ),
                     ),
                       Container(height: 2.5,color: index==1 ? Colors.white:Colors.transparent,)
               ],),
                  ),
                ),


                ],),
              ),
            ),


         index ==0

             ?

         Expanded(
                  child: ListView.builder(
                    itemCount: result.orderHistory.length,
                    itemBuilder: (context, index) {
                      OrderHistory orderHistory = result.orderHistory[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18, bottom: 10),
                        child: InkWell(
                          onTap: (){


                            if(orderHistory.orderStatusId.toString()=="5"){
                              Get.to(()=>MyCarsOrderDetails(orderHistory));
                            }else{
                              // Get.to(()=>OrderTracking(int.parse(orderHistory.orderId.toString())));
                              Get.to(Get.to(OrderTracking(null,true,int.parse(orderHistory.orderId.toString()))));


                            }


                            },
                          child: Container(

                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15))),

                            /// broken windows
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    /// broken windows and in progress
                                    Padding(
                                      padding: const EdgeInsets.all(
                                          13.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                           Text(
                                             getAllissue(orderHistory.issues),
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight
                                                        .bold),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 80,
                                            decoration:
                                                BoxDecoration(
                                                    color: orderHistory.orderStatusId.toString()=="5" ?Colors.greenAccent: Colors.yellowAccent,
                                                    borderRadius:
                                                        const BorderRadius
                                                            .all(
                                                      Radius
                                                          .circular(
                                                              8),
                                                    )),
                                            child: Center(
                                              child: Text(
                                                orderHistory.orderStatusId.toString()=="5" ? "Completed".tr: "In Progress".tr,
                                                style: TextStyle(
                                                    color: orderHistory.orderStatusId.toString()=="5" ?Colors.green: Colors.deepOrange,
                                                    fontWeight:
                                                        FontWeight.w500  ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding:
                                          const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DiscountListScreen()),
                                          );

                                        },
                                        child: const Icon(Icons
                                            .keyboard_arrow_right_rounded),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),

                                /// 1st Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5
                                              ),
                                            )

                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(vertical:
                                                  8.0 ,horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              Text(
                                                "Order #".tr,
                                                style: TextStyle(
                                                  color: Colors
                                                      .grey.shade500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                               Text(
                                                orderHistory.orderId.toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold,
                                                    color:
                                                        Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [

                                          Padding(
                                            padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Date".tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .grey
                                                          .shade500),
                                                ),
                                                 Text(
                                                  orderHistory.creationDate.toString().replaceAll('T00:00:00', ""),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),

                                ///2nd Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5
                                              ),

                                            )

                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(vertical:
                                                  8.0 ,horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              Text(
                                                "Workshop".tr,
                                                style: TextStyle(
                                                  color: Colors
                                                      .grey.shade500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                               Text(
                                                orderHistory.workshopName.toString(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold,
                                                    color:
                                                        Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// car
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: [
                                                Text(
                                                  "Cost".tr,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors
                                                          .grey
                                                          .shade500),
                                                ),
                                                 Text(
                                                  "SAR".tr +" ${ double.parse(orderHistory.totalCost.toString()).toStringAsFixed(1)}",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color:
                                                        Colors.blue,
                                                    fontWeight:
                                                        FontWeight
                                                            .bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
             :
         Expanded(
              child: ListView.builder(
                itemCount: result.report.length,
                itemBuilder: (context, index) {
                  Report report = result.report[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, bottom: 10),
                    child: InkWell(
                      onTap: (){
                        Get.to(OrderFromReportService(result.report[index]));

                      },
                      child: Container(

                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),

                        /// broken windows
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                /// broken windows and in progress
                                Padding(
                                  padding: const EdgeInsets.all(
                                      13.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        getAllissueForReports(report.issueTypes),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),

                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const DiscountListScreen()),
                                      );

                                    },
                                    child: const Icon(Icons
                                        .keyboard_arrow_right_rounded),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),

                            /// 1st Row
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5
                                          ),
                                        )

                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical:
                                      8.0 ,horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "Order #".tr,
                                            style: TextStyle(
                                              color: Colors
                                                  .grey.shade500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                           report.reportId.toString(),
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color:
                                                Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [

                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              "Date".tr,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors
                                                      .grey
                                                      .shade500),
                                            ),
                                            Text(
                                              DateFormat('yyyy-MM-dd').parse(report.creationDate.toString()).toString().replaceAll('00:00:00.000', ""),
                                              // report.creationDate.toString().replaceAll('T00:00:00', ""),
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),

                            ///2nd Row
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                              color: Colors.grey,
                                              width: 0.5
                                          ),

                                        )

                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(vertical:
                                      8.0 ,horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            "Comment".tr,
                                            style: TextStyle(
                                              color: Colors
                                                  .grey.shade500,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            report.comment,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                color:
                                                Colors.black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )


          ],
        ),
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
  String getAllissueForReports(List<IssueType> issueTypes){

    List<String> data=[];
    for(int i=0;i<issueTypes.length;i++){
      data.add(issueTypes[i].faultName);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

}

