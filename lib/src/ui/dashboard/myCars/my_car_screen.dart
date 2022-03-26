// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:musan_client/api_services/ApiServices.dart';
// import 'package:musan_client/api_services/Finals.dart';
// import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';
// import 'package:musan_client/src/provider/MyCarsScreenProvider.dart';
// import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
// import 'package:musan_client/src/provider/dashboard_provider.dart';
// import 'package:musan_client/src/ui/auth/SignUp.dart';
// import 'package:musan_client/src/ui/dashboard/home/order_from_service.dart';
// import 'package:musan_client/src/ui/order_booking_screens/car_model_screen.dart';
// import 'package:musan_client/utils/colors.dart';
// import 'package:musan_client/utils/common_classes.dart';
// import 'package:musan_client/utils/images.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'MyCarsOrderDetails.dart';
// // import '.dart';
//
// class MyCarScreen extends StatefulWidget {
//   // 0 mean on dashboard and 1 mean from drawer
//   int screenChecked;
//
//   MyCarScreen({this.screenChecked});
//
//   @override
//   _MyCarScreenState createState() => _MyCarScreenState();
// }
//
// class _MyCarScreenState extends State<MyCarScreen> {
//
//   @override
//   void initState() {
//
//     Future.delayed(Duration.zero,(){
//
//       SharedPreferences.getInstance().then((value){
//
//         Get.dialog(Center(child: CircularProgressIndicator(),));
//
//         ApiServices.getCarRelatedInformation(context);
//
//         ApiServices.getMyCarsById(context, value.getString(Finals.USER_ID));
//
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<MyCarsScreenProvider>(builder: (builder,data,child,) => Scaffold(
//       extendBody: true,
//       backgroundColor: Colors.white,
//       // bottomNavigationBar: addANewCarButton(),
//       appBar: widget.screenChecked == 0
//           ? PreferredSize(preferredSize: Size.fromHeight(Get.height * .0), child: SizedBox())
//           : AppBar(
//         backgroundColor: screenBgColor,
//         leading: IconButton(
//           icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
//           onPressed: () => Get.back(),
//         ),
//         elevation: 0,
//         title: Text(
//           'My Cars'.tr,
//           style: TextStyle(
//             color: headingTextColor,
//             fontSize: Get.height * .026,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: data.isMyCarLoaded ? Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   widget.screenChecked == 0
//                       ? Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: Get.height * .02,
//                       horizontal: Get.width * .06,
//                     ),
//                     child: Text(
//                       'My cars'.tr,
//                       style: TextStyle(
//                         color: headingTextColor,
//                         fontSize: Get.height * .026,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//                       : SizedBox(),
//                   Column(
//                     children: List.generate(
//                         data.getMyCarsByUserIdFromJson.result.length, (index) {
//                       return myCarList(data.getMyCarsByUserIdFromJson.result,index);
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           addANewCarButton()
//
//         ],
//       ) : Container(),
//     ));
//   }
//
//   myCarList(List<Result> resultlist, int index) {
//     return Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(
//         vertical: Get.height * .02,
//         horizontal: Get.width * .08,
//       ),
//       margin: EdgeInsets.only(
//         left: Get.width * .06,
//         right: Get.width * .06,
//         bottom: Get.height * .02,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff000000).withOpacity(.13),
//             spreadRadius: .08,
//             blurRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//
//               Expanded(
//                 child: myCarData(resultlist[index]),
//               ),
//             ],
//           ),
//           SizedBox(height: Get.height * .02),
//           Row(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Gear transmission'.tr,
//                     style: TextStyle(
//                       color: Color(0xff1E1E1E).withOpacity(.70),
//                       fontSize: Get.height * .017,
//                     ),
//                   ),
//                   SizedBox(height: Get.height * .005),
//                   Text(
//                     '${resultlist[index].carTransmission}',
//                     style: TextStyle(
//                       color: themeColor,
//                       fontSize: Get.height * .02,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           orderHistoryReport(title: "Order History".tr,result: resultlist[index]),
//           orderReport(title: "Reports".tr,result: resultlist[index]),
//
//         ],
//       ),
//     );
//   }
//
//   String getAllissue(List<Issue> issues){
//
//     List<String> data=[];
//     for(int i=0;i<issues.length;i++){
//       data.add(issues[i].name);
//     }
//     return data.toString().replaceAll("[", "").replaceAll("]", "");
//   }
//
//   String getAllissueForReports(List<IssueType> issueTypes){
//
//     List<String> data=[];
//     for(int i=0;i<issueTypes.length;i++){
//       data.add(issueTypes[i].faultName);
//     }
//     return data.toString().replaceAll("[", "").replaceAll("]", "");
//   }
//
//   _divider() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: Get.height * .01),
//       child: Divider(color: Color(0xff000000).withOpacity(.18), thickness: 1),
//     );
//   }
//
//   myCarData(Result result) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Car name'.tr,
//           style: TextStyle(
//             color: Color(0xff1E1E1E).withOpacity(.70),
//             fontSize: Get.height * .018,
//           ),
//         ),
//         SizedBox(height: Get.height * .007),
//         Text(
//           '${result.carName}',
//           style: TextStyle(
//             color: themeColor,
//             fontSize: Get.height * .022,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   orderHistoryReport({String title,Result result}) {
//     return ExpansionTile(
//      tilePadding: EdgeInsets.zero,
//      leading: Text(
//        title,
//        style: TextStyle(
//          color: Color(0xffFFD037),
//          fontSize: Get.height * .022,
//          fontWeight: FontWeight.w600,
//        ),
//      ),
//
//      children: [
//        Container(
//          height: Get.height*0.25,
//          child: ListView.builder(
//
//            shrinkWrap:true,itemBuilder: (context, index) {
//            return Container(
//              width: Get.width*0.75,
//              child: Column(children: [
//                Row(
//                  children: [
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(
//                            'Date'.tr,
//                            style: TextStyle(
//                              color: Color(0xff1E1E1E).withOpacity(.70),
//                              fontSize: Get.height * .018,
//                            ),
//                          ),
//                          // SizedBox(height: Get.height * .007),
//                          Text(
//                            result.orderHistory[index].creationDate.toString().replaceAll("T00:00:00", ''),
//                            style: TextStyle(
//                              color: themeColor,
//                              fontSize: Get.height * .02,
//                              fontWeight: FontWeight.w600,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(
//                            'Cost'.tr,
//                            style: TextStyle(
//                              color: Color(0xff1E1E1E).withOpacity(.70),
//                              fontSize: Get.height * .018,
//                            ),
//                          ),
//                          // SizedBox(height: Get.height * .007),
//                          Text(
//                            "SR".tr+" ${double.parse(result.orderHistory[index].totalCost.toString()).toInt().toString()}",
//                            style: TextStyle(
//                              color: themeColor,
//                              fontSize: Get.height * .02,
//                              fontWeight: FontWeight.w600,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: [
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Text(
//                          'Issue'.tr,
//                          style: TextStyle(
//                            color: Color(0xff1E1E1E).withOpacity(.70),
//                            fontSize: Get.height * .017,
//                          ),
//                        ),
//                        // SizedBox(height: Get.height * .005),
//                        Text(
//                          getAllissue( result.orderHistory[index].issues),
//                          style: TextStyle(
//                            color: themeColor,
//                            fontSize: Get.height * .02,
//                            fontWeight: FontWeight.w600,
//                          ),
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//                GestureDetector(
//                  onTap: () {
//
//                 Get.to(()=>MyCarsOrderDetails(result.orderHistory[index]));
//
//                  },
//                  child: Container(
//                    width: Get.width*0.65,
//                    height: Get.height * .055,
//                    margin: EdgeInsets.only(
//                      bottom: Get.height * .02,
//                      top: Get.height * .02,
//                    ),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10),
//                      border: Border.all(color: themeColor, width: 1),
//                    ),
//                    child: Text(
//                      "See Order Details".tr,
//                      style: TextStyle(
//                        color: themeColor,
//                        fontSize: Get.height * .02,
//                      ),
//                    ),
//                  ),
//                ),
//              ],),);
//          }, itemCount: result.orderHistory.length, scrollDirection: Axis.vertical,),
//        )
//      ],
//         );
//   }
//
//   orderReport({String title,Result result}) {
//     return ExpansionTile(
//
//      tilePadding: EdgeInsets.zero,
//      leading: Text(
//        title,
//        style: TextStyle(
//          color: Color(0xffFFD037),
//          fontSize: Get.height * .022,
//          fontWeight: FontWeight.w600,
//        ),
//      ),
//
//      children: [
//        Container(
//          height: Get.height*0.26,
//          child: ListView.builder(shrinkWrap:true,itemBuilder: (context, index) {
//            return Container(
//              width: Get.width*0.72,
//              child: Column(children: [
//
//                SizedBox(height: Get.height * .01),
//
//                Row(
//                  children: [
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(
//                            'Date'.tr,
//                            style: TextStyle(
//                              color: Color(0xff1E1E1E).withOpacity(.70),
//                              fontSize: Get.height * .018,
//                            ),
//                          ),
//                          SizedBox(height: Get.height * .007),
//                          Text(
//                            DateFormat("yyyy-MM-dd").format(DateTime.parse(result.report[index].creationDate.toString())),
//                            style: TextStyle(
//                              color: themeColor,
//                              fontSize: Get.height * .02,
//                              fontWeight: FontWeight.w600,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Expanded(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: [
//                          Text(
//                            'Issue'.tr,
//                            style: TextStyle(
//                              color: Color(0xff1E1E1E).withOpacity(.70),
//                              fontSize: Get.height * .017,
//                            ),
//                          ),
//                          SizedBox(height: Get.height * .005),
//                          Text(
//                            getAllissueForReports(result.report[index].issueTypes),
//                            style: TextStyle(
//                              color: themeColor,
//                              fontSize: Get.height * .02,
//                              fontWeight: FontWeight.w600,
//                            ),
//                          ),
//                        ],
//                      )
//                    ),
//                  ],
//                ),
//
//                SizedBox(height: Get.height * .017),
//
//                GestureDetector(
//                  onTap: () {
//                  Get.to(OrderFromReportService(result.report[index]));
//                  },
//                  child: Container(
//                    width: Get.width,
//                    height: Get.height * .065,
//                    margin: EdgeInsets.only(
//                      bottom: Get.height * .02,
//                      top: Get.height * .02,
//                    ),
//                    alignment: Alignment.center,
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(10),
//                      border: Border.all(color: themeColor, width: 1),
//                    ),
//                    child: Text(
//                      "Order From Report".tr,
//                      style: TextStyle(
//                        color: themeColor,
//                        fontSize: Get.height * .02,
//                      ),
//                    ),
//                  ),
//                ),
//              ],),);
//          }, itemCount: result.report.length, scrollDirection: Axis.vertical,),
//        )
//      ],
//         );
//   }
//
//   Widget addANewCarButton() {
//
//     return GestureDetector(
//       onTap: () {
//         var data = Provider.of<WorkShopOrderProvider>(context,listen: false);
//     data.isExpanded=true;
//         if(data.isCarRelatedDataLoaded){
//           Get.bottomSheet(Material(child: addNewCar(),),isScrollControlled: true);
//         }
//         else{
//           Get.dialog(Center(child: CircularProgressIndicator(),),barrierDismissible: true);
//           ApiServices.getCarRelatedInformation(context);
//         }
//         // Get.to(Material(child: AddANewCarBottomSheet()));
//
//       },
//       child: Container(
//         width: Get.width,
//         height: Get.height * .07,
//         margin: EdgeInsets.only(
//           top: Get.height * .01,
//           left: Get.width * .06,
//           right: Get.width * .06,
//           bottom: 20
//         ),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: themeColor,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(.13),
//               spreadRadius: 1,
//               blurRadius: 3,
//             ),
//           ],
//         ),
//         child: Text(
//           'Add a new car'.tr,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: Get.height * .02,
//           ),
//         ),
//       ),
//     );
//   }
//
// }
