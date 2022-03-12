// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:get/get.dart';
// // import 'package:google_map_location_picker/google_map_location_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:musan_client/api_services/ApiServices.dart';
// import 'package:musan_client/api_services/Finals.dart';
// import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
// import 'package:musan_client/utils/colors.dart';
// import 'package:musan_client/utils/common_classes.dart';
// import 'package:musan_client/utils/validator.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../GoogleMap.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class WorkShopAndTechnicianORDER extends StatefulWidget {
//   int screenChecked;
//   bool isFromDicountOffers;
//   int offerID;
//   WorkShopAndTechnicianORDER({this.screenChecked,this.isFromDicountOffers:false, this.offerID});
//   @override
//   _WorkShopAndTechnicianORDERState createState() => _WorkShopAndTechnicianORDERState();
// }
//
// class _WorkShopAndTechnicianORDERState extends State<WorkShopAndTechnicianORDER> {
//
//   String apiKey="AIzaSyBSPIlIrLMIexjBrrImq9HKbAZxtRF-lKI";
//
//   final picker = ImagePicker();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 2),(){
//       ApiServices.getFaults(context);
//       ApiServices.getCarRelatedInformation(context);
//       Get.dialog(Center(child: CircularProgressIndicator(),));
//       SharedPreferences.getInstance().then((value) {
//         ApiServices.getCarInformationByUserID(context, value.getString(Finals.USER_ID));
//       });
//     });
//   }
//
//
//   @override
//   WorkShopAndTechnicianORDER get widget => super.widget;
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WorkShopOrderProvider>(builder: (builder, data, child) {
//       return Scaffold(
//         backgroundColor: screenBgColor,
//         bottomNavigationBar: _orderButton(data),
//         appBar: AppBar(
//           backgroundColor: screenBgColor,
//           leading: IconButton(
//             icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
//             onPressed: () => Get.back(),
//           ),
//           elevation: 0,
//           title: Text(
//             widget.screenChecked == 1 ? 'Workshop order'.tr : 'Technician order'.tr,
//             style: TextStyle(
//               color: headingTextColor,
//               fontSize: Get.height * .026,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
//             child: Column(
//               children: [
//
//                 InkWell(
//                   onTap: () async {
//                     Get.to( () => GMaps(title: "Location".tr,)).then((value) {
//                       print("Address Values: $value");
//                       if(!value.toString().contains("null")){
//                         logger.e("weeeeeee");
//                         data.setLatLong(double.parse(value[0].toString()),double.parse(value[1].toString()));
//                         _geoCoder(double.parse(value[0].toString()),double.parse(value[1].toString()),data: data);
//                       }
//                     });
//
//                     },
//                   child: Container(
//                     width: Get.width,
//                     height: Get.height * .07,
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.symmetric(
//                       vertical: Get.height * .01,
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: Get.width * .04),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xff000000).withOpacity(.13),
//                           spreadRadius: 1,
//                           blurRadius: 3,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//
//                         Expanded(child: Text('${data.address}',style: TextStyle(color: headingTextColor.withOpacity(.50),fontSize: Get.height * .02,),)),
//
//                         Icon(Icons.location_on_outlined, color: themeColor),
//
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: Get.width,
//                   margin: EdgeInsets.symmetric(
//                     vertical: Get.height * .01,
//                   ),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Get.width * .04,
//                     vertical: Get.height * .02,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff000000).withOpacity(.13),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       widget.screenChecked == 0
//                           ? SizedBox()
//                           : Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
//                                 Text(
//                                   'Issue type'.tr,
//                                   style: TextStyle(
//                                     color: headingTextColor,
//                                     fontSize: Get.height * .022,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                                 SizedBox(height: Get.height * .02),
//                                data.isFaultsLoaded ? Wrap(children: _listed(data),) : SizedBox(height: 150,child: Container(child: Center(
//                                  child: CircularProgressIndicator(backgroundColor: Colors.blue,),
//                                ),),)
//
//                               ],
//                             ),
//                       Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: Get.height * .03),
//                         child: Text(
//                           "What's  your car".tr,
//                           style: TextStyle(
//                             color: headingTextColor,
//                             fontSize: Get.height * .022,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child:  data.isUserCarsLoaded? dropDown(data) :Container()
//                           ),
//                           SizedBox(width: 5),
//                           Expanded(
//                             child: GestureDetector(
//                               onTap: () {
//                                 if(data.isCarRelatedDataLoaded){
//                                   Get.bottomSheet(AddANewCarBottomSheet());
//                                   // Get.to(DropdownGeneral());
//
//                                 }
//                                 else{
//                                   Get.dialog(Center(child: CircularProgressIndicator(),),barrierDismissible: false);
//                                   ApiServices.getCarRelatedInformation(context);
//                                 }
//                               },
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     color: data.isCarRelatedDataLoaded ? themeColor:Colors.grey,
//                                     size: 40,
//                                   ),
//                                   SizedBox(width: 5),
//                                   Text('Add a new car'.tr,style: TextStyle(
//                                     color: data.isCarRelatedDataLoaded ? themeColor:Colors.grey,
//                                     fontSize: Get.height * .019,
//                                       fontWeight: FontWeight.w600,
//                                     ),),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Get.height * .02),
//                       Column(children: [
//                         Row(children: [
//                           GestureDetector(
//                             onTap: (){
//                               _showPicker(context,data);
//
//                             },
//                             child: Container(
//
//                               height: Get.height * .125,
//
//                               padding: EdgeInsets.symmetric(
//                                 vertical: Get.height * .010,
//                                 horizontal: Get.width * .04,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 // image: DecorationImage(image: FileImage(File("data.imageFile.path"), ) ,fit: BoxFit.cover,),
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: themeColor, width: 2),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xff000000).withOpacity(.13),
//                                     spreadRadius: 1,
//                                     blurRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     color: themeColor,
//                                     size: 25,
//                                   ),
//                                   SizedBox(height: Get.height * .005),
//                                   Text(
//                                     'Attach\n Picture'.tr,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: themeColor,
//                                       fontSize: Get.height * .018,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10),
//                               child: Column(
//                                 children: <Widget>[
//
//                                   Container(
//
//                                     height: Get.height * .125,
//                                     child: ListView.builder(
//                                       padding: EdgeInsets.zero,
//                                         scrollDirection: Axis.horizontal,
//                                         shrinkWrap: true,
//                                         itemCount:data.imageList.length,
//                                         itemBuilder: (context,index){
//                                           return  Stack(children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(right: 10),
//                                               child: Container(
//                                                 width: Get.width * .225,
//                                                 height: Get.height * .18,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(10),
//                                                     border: Border.all(color: themeColor, width: 2),
//                                                     color: Colors.blue,image: DecorationImage(fit: BoxFit.fill,image: FileImage(new File(data.getImage(index))))),),
//                                             ),
//                                           InkWell(
//                                             onTap: (){
//                                               data.removeImage(index);
//                                             },
//                                             child: Align(
//                                               alignment: Alignment(1,-1),
//                                                 child: Icon(Icons.remove_circle,color: Colors.red,),
//                                               ),
//                                           )
//
//                                           ],);
//                                         }),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],),
//
//
//
//                       ],)
//
//
//                     ],
//                   ),
//                 ),
//                 _textFormFiled(0, 'Free comment'.tr,data),
//
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget dropDown(WorkShopOrderProvider data){
//     return  Container(
//       margin: const EdgeInsets.only( right: 10.0),
//       padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 5,bottom: 5),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Colors.transparent,
//           border: Border.all(color: Colors.blue,width: 2)),
//       child: DropdownButton(
//         dropdownColor: Colors.white,
//         isExpanded: true,
//         focusColor: Colors.blue,
//         value: data.initValueForSelectACar,
//         onTap: () {
//           if (!data.isUserCarsLoaded) {
//             Get.dialog(Center(child: CircularProgressIndicator(),));
//
//             SharedPreferences.getInstance().then((value) {
//               ApiServices.getCarInformationByUserID(context, value.getString(Finals.USER_ID));
//             });
//           }
//         },
//         style:TextStyle(fontSize: 14,color: Colors.grey.shade50),
//         icon: Icon(Icons.keyboard_arrow_down),
//         underline: Container(color: Colors.transparent),
//         onChanged: data.isUserCarsLoaded ? (value){
//           data.onSelectAcar(value);
//           print(value);
//         } : null ,
//         items: data.userCars.map((value) {
//           return DropdownMenuItem(
//             child: Container(
//               margin: EdgeInsets.only(left: 4, right: 4),
//               child: Text(value,
//                   style:
//                   TextStyle(fontSize: 14, color: Colors.black)),
//             ),
//             value: value,
//           );
//         }).toList(),
//       ),
//     );
//
//   }
//
//   List<Widget> _listed(WorkShopOrderProvider data) {
//     List<Widget> listWidget2 = [];
//     if(listWidget2.isNotEmpty){
//       listWidget2.clear();
//     }
//
//
// /*
//     for (int i = 0; i < data.faultsReponse.result.length; i++) {
//       listWidget2.add(Padding(
//         padding: const EdgeInsets.only(right: 5),
//         child: FilterChip(
//           avatar: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xff898989)),),
//           backgroundColor: Colors.grey,
//           selectedColor: Color(0xff02AAF1),
//           shape: data.issuetypesList.contains(data.faultsReponse.result[i].name)
//               ? RoundedRectangleBorder(
//               side: BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(10))
//               : RoundedRectangleBorder(
//               side: BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(10)),
//           label: Text(data.faultsReponse.result[i].name),
//           selected: data.issuetypesList.contains(data.faultsReponse.result[i].name),
//           onSelected: (bool value) {
//             setState(() {
//               if (value) {
//                 data.issuetypesList.add(data.faultsReponse.result[i].name);
//               } else {
//                 data.issuetypesList.removeWhere((String name) {
//                   return name == data.faultsReponse.result[i].name;
//                 });
//               }
//             });
//           },
//         ),
//       ));
//     }*/
//     return listWidget2;
//   }
//
//   issueTypeWidget(int index) {
//     return Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(vertical: Get.height * .007),
//       decoration: BoxDecoration(
//         color: index == 0 || index == 1
//             ? Color(0xff02AAF1).withOpacity(.40)
//             : Color(0xffA8A8A8).withOpacity(.40),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xff000000).withOpacity(.13),
//             spreadRadius: 1,
//             blurRadius: 3,
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 25,
//             height: 25,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: index == 0 || index == 1 ? themeColor : Color(0xffA8A8A8),
//             ),
//             child: index == 0 || index == 1
//                 ? Icon(Icons.check, color: Colors.white, size: 16)
//                 : SizedBox(),
//           ),
//           SizedBox(width: 10),
//           Text(
//             'Issue name'.tr,
//             style: TextStyle(
//               color: index == 0 || index == 1 ? themeColor : Color(0xffA8A8A8),
//               fontSize: Get.height * .019,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _orderButton(WorkShopOrderProvider data) {
//     return GestureDetector(
//       onTap: () {
//         // Get.bottomSheet(serviceCostBottomSheet());
//
//         // if(widget.screenChecked==0){
//           // TOASTS("Pay Car Pickup Price");
//           data.submitOrder(context,widget.screenChecked,widget.isFromDicountOffers,widget.offerID);
//         //
//         //   // _showBottomSheetForCarPickupPayment(context,widget.screenChecked,widget.isFromDicountOffers,widget.offerID,data);
//         // }else {
//         //   data.submitOrder(context,widget.screenChecked,widget.isFromDicountOffers,widget.offerID);
//         // }
//         //
//
//
//       },
//       child: Container(
//         width: Get.width,
//         height: Get.height * .065,
//         margin: EdgeInsets.only(
//           top: Get.height * .01,
//           bottom: Get.height * .01,
//           left: Get.width * .06,
//           right: Get.width * .06,
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
//           'Order'.tr,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: Get.height * .02,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _textFormFiled(int index, String label, WorkShopOrderProvider data ) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: Get.height * .02,
//         top: Get.height * .01,
//       ),
//       child: TextFormField(
//         onTap: () {
//           Get.forceAppUpdate();
//         },
//         style: TextStyle(
//           fontSize: Get.height * .02,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//         onChanged: (value){
//
//           data.setFreeComment(value);
//
//           },
//         maxLines: 4,
//         textInputAction: index == 4 ? TextInputAction.done : TextInputAction.next,
//         decoration: InputDecoration(
//           // floatingLabelBehavior: FloatingLabelBehavior.always,
//           isDense: true,
//           filled: true,
//           fillColor: Colors.white,
//           hintText: label,
//           hintStyle: TextStyle(
//               fontSize: Get.height * .018,
//               color: Color(0xff2C4752).withOpacity(.30)),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           errorStyle: TextStyle(fontSize: Get.height * .014),
//         ),
//         cursorColor: Colors.black,
//         textAlign: TextAlign.left,
//         enabled: true,
//         keyboardType: TextInputType.text,
//         validator: FieldValidator.thisField,
//       ),
//     );
//   }
//
//   /*
//   serviceCostBottomSheet() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: Get.height * .02,
//             horizontal: Get.width * .06,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: Get.width * .2,
//                 child: Divider(
//                   thickness: 6,
//                   color: Color(0xffF1F1F1),
//                 ),
//               ),
//               SizedBox(height: Get.height * .01),
//               Text(
//                 widget.screenChecked == 0
//                     ? 'Technician services'
//                     : 'Workshop service',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: Get.height * .022,
//                   color: headingTextColor,
//                 ),
//               ),
//               SizedBox(height: Get.height * .01),
//               widget.screenChecked == 1
//                   ? SizedBox()
//                   : Text(
//                       "\$100",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .03,
//                         color: themeColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//               SizedBox(height: Get.height * .01),
//               Text(
//                 widget.screenChecked == 1
//                     ? 'your order is placed'
//                     : 'service cost',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: Get.height * .019,
//                   color: headingTextColor.withOpacity(.50),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   if (widget.screenChecked == 0) {
//                     Get.back();
//                     Get.bottomSheet(technicianServiceBottomSheet(0));
//
//                   } else {
//                     Get.back();
//                     Get.back();
//                     // Get.to(OrderTracking());
//
//                     // Get.bottomSheet(technicianServiceBottomSheet(1));
//                   }
//                 },
//                 child: Container(
//                   width: Get.width,
//                   height: Get.height * .065,
//                   margin: EdgeInsets.only(
//                     top: Get.height * .03,
//                   ),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: themeColor,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff000000).withOpacity(.13),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     'Confirm',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: Get.height * .02,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   technicianServiceBottomSheet(int indexForTracking) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: Get.height * .02,
//             horizontal: Get.width * .06,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: Get.width * .2,
//                 child: Divider(
//                   thickness: 6,
//                   color: Color(0xffF1F1F1),
//                 ),
//               ),
//               SizedBox(height: Get.height * .02),
//               Text(
//                 "Technician assigned",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: Get.height * .022,
//                   fontWeight: FontWeight.w600,
//                   color: headingTextColor,
//                 ),
//               ),
//               SizedBox(height: Get.height * .03),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         "Name assigned as your technician. He will arrive in 10 minutes.",
//                         style: TextStyle(
//                           fontSize: Get.height * .02,
//                           color: headingTextColor,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         width: 50,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           color: Color(0xffC4C4C4),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                   if(indexForTracking==0){
//                     Get.to(TechnicianTrack());
//
//                   }else if (indexForTracking==1) {
//                     // Get.to(OrderTracking());
//
//                   }
//                 },
//                 child: Container(
//                   width: Get.width,
//                   height: Get.height * .065,
//                   margin: EdgeInsets.only(
//                     top: Get.height * .04,
//                   ),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: themeColor,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff000000).withOpacity(.13),
//                         spreadRadius: 1,
//                         blurRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     'Order track',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: Get.height * .02,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }*/
//
//   void _getLocation() async {
//     print('get location');
//     Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((value){
//       print(value);
//       _geoCoder(value.latitude, value.longitude);
//     }).onError((error, stackTrace) {
//       print(error);
//     });
//   }
//
//   void _geoCoder(double lat, double lng,{WorkShopOrderProvider data}) async {
//     print(lat);
//     print(lng);
//
//     // From a query
//     // final query = "1600 Amphiteatre Parkway, Mountain View";
//     // var addresses = await Geocoder.local.findAddressesFromQuery(query);
//     // var first = addresses.first;
//     // print("${first.featureName} : ${first.coordinates}");
//     // From coordinates
//
//     final coordinates = new Coordinates(lat, lng);
//     List<Address> addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     Address address = addresses.first;
//     print(address.addressLine);
//     data.setAddress(address.addressLine);
//
//     // print(address.adminArea);
//     // print(address.countryCode);
//     // print(address.countryName);
//     // print(address.featureName);
//     // print(address.thoroughfare);
//
//   }
//
//   void _showPicker(context, WorkShopOrderProvider data) {
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Color(0x00000000),
//         builder: (BuildContext bc) {
//           return Container(
//             decoration: BoxDecoration(
//                 border: Border.fromBorderSide(
//                     BorderSide(color: Color(0xFFFFEB3B), width: 0.8)),
//                 color: Color(0xFFFFFFFF),
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25),
//                     topRight: Radius.circular(25))),
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: new Icon(
//                       Icons.photo_library,
//                       color: Color(0xFF000000),
//                     ),
//                     title: new Text(
//                       'Photo Library'.tr,
//                       style: TextStyle(color: Color(0xFF000000)),
//                     ),
//                     onTap: () {
//                       _imgFromGallery(context,data);
//                       Navigator.of(context).pop();
//                     }),
//                 new ListTile(
//                   leading: new Icon(
//                     Icons.photo_camera,
//                     color: Color(0xFF000000),
//                   ),
//                   title: new Text(
//                     'Camera'.tr,
//                     style: TextStyle(color: Color(0xFF000000)),
//                   ),
//                   onTap: () {
//                     _imgFromCamera(context,data);
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   _imgFromCamera(BuildContext context, WorkShopOrderProvider data) async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     if(pickedFile!=null){
//       data.setImageSeletedOrNot(true);
//       data.setSelectedImage(pickedFile);
//     }
//
//   }
//
//   _imgFromGallery(BuildContext context, WorkShopOrderProvider data) async {
//
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//     if(pickedFile!=null){
//       data.setImageSeletedOrNot(true);
//       data.setSelectedImage(pickedFile);
//     }
//
//
//   }
//
//
//
//
// }
//
//
//
// // CarLocationScreen()