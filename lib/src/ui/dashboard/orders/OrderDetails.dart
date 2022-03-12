import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/home/OrderNowBottomSheet.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'order_tracking.dart';

class OrderDetailsCompleted extends StatelessWidget {
  Result result;

  OrderDetailsCompleted(this.result);

  _ratingDialoge(Result result) {
    Future.delayed(Duration.zero,(){
      if (result.orderRating == null) {
        String rating="5";
        String feedback="";
        Get.dialog(Center(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${"Order number".tr} ${result.orderId}\n${"Please rate and comment this workshop".tr}',
                          textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text('Rate'.tr,style: TextStyle(fontSize: 20)),
                      ),

                      /* Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: SmoothStarRating(
                            allowHalfRating: true,
                            onRated: (v) {
                              print(v);
                              rating=v.toString();
                            },
                            starCount: 5,
                            rating: 0,
                            size: 45.0,
                            isReadOnly: false,
                            // fullRatedIconData: Icons.blur_off,
                            // halfRatedIconData: Icons.blur_on,
                            color: Color(0xFFFAB002),
                            borderColor: Color(0xFFFAB002),
                            spacing: 0.0),
                      ),*/


                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: RatingBar.builder(
                              initialRating: 5,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (ratinga) {
                                print(rating);
                                rating = ratinga.toString();
                              },
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(8),),border: Border.all(width: 0.5),


                          ),

                          child: TextFormField(
                            onTap: () {
                              // Get.forceAppUpdate();
                            },
                            onChanged: (value){
                              feedback=value;
                            },
                            style: TextStyle(
                              fontSize: Get.height * .02,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              // floatingLabelBehavior: FloatingLabelBehavior.always,
                              // isDense: true,
                              // filled: true,
                                hintText: "Feedback".tr,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(5)

                            ),
                            cursorColor: Colors.black,
                            // textAlign: TextAlign.left,
                            enabled: true,
                            maxLines: null,
                            maxLength: null,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: GestureDetector(
                          onTap: () {
                            if(rating.isEmpty || rating=="0"){
                              TOASTS("Select Star Rating".tr);
                            }else if(feedback.isEmpty){
                              TOASTS("Please Write review".tr);
                            }else{
                              Get.back();
                              Get.dialog(Center(child: CircularProgressIndicator(),));
                              ApiServices.giveFeedBack(result.orderId,rating,feedback);
                            }
                          },
                          child: Container(
                            width: Get.width,
                            height: Get.height * .065,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(.13),
                                  spreadRadius: .08,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              "Confirm".tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * .02,
                              ),
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Center(child: Text("Cancel".tr,style: TextStyle(fontSize: 20,color: blue))),
                        ),
                      )

                    ],)


              ),
            ),
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool orderStatus = result.isCompleted;
    if(result.orderRating==null && result.isCompleted){
     if(Get.isDialogOpen){
       Get.back();
     }
      _ratingDialoge(result);
    }



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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
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
                  crossAxisAlignment: Get.locale.toString().contains("en")? CrossAxisAlignment.start :  CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 25,
                      decoration: BoxDecoration(
                        color: orderStatus
                            ? Color(0xff17CE3F).withOpacity(.30)
                            : Color(0xffFFD037).withOpacity(.28),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          orderStatus ? 'Completed'.tr : !orderStatus && result.orderStatusId.toString() =="5" ? 'Rejected'.tr: " " ,
                          style: TextStyle(
                            color: orderStatus
                                ? Color(0xff004910)
                                : Color(0xffea480c),
                            fontSize: Get.height * .017,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: getRatingName(),
                    ),
                    _issueDetail(result),
                    // Text(
                    //   'Comment'.tr,
                    //   style: TextStyle(color: Colors.black,fontSize: 18),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Text(
                    //     result.comments ?? "",
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                    // ),
                    SizedBox(height: 5,),
                    result.orderAttachments.length !=0?  Text(
                      'Attachments'.tr,
                      style: TextStyle(color: Colors.grey),
                    ):Container(),
                    Container(
                      height: Get.height * 0.5,
                      child: GridView.builder(
                          itemCount: result.orderAttachments.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (c, i) {
                            var orderAttachment = result.orderAttachments[i];
                            logger.e(orderAttachment.attachmentLink);
                            return Card(
                              child: orderAttachment==null?
                              Image.asset('assets/images/carlogo.png')
                              :
                              InkWell(
                                  onTap: (){
                                    openImage('https://muapi.deeps.info/'+orderAttachment.attachmentLink);
                                  },
                                  child: Image.network('https://muapi.deeps.info/'+orderAttachment.attachmentLink,fit: BoxFit.fill,)),
                            );
                          }),
                    )
                  ],
                ),
              ),
              // _orderNowButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _issueDetail(Result result) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment:Get.locale.toString().contains("en") ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            children: getOrderNumber(result)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: getOrderNumerDate(result)
            ),
          ),
          Text(
            'Issues'.tr,
            style: TextStyle(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(getAllissue2(result),
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.height * .023,
                    fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 5,),
          SizedBox(height: 5,),
          Text(
            'Comment'.tr,
            style: TextStyle(color: Colors.black,fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Text(
              result.comments ?? "",
              style: TextStyle(color: Colors.grey),
            ),
          ),


          SizedBox(height: 10,),

          Text(
            'Cost'.tr,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 3,),
          Text(
            "SR".tr+" ${double.parse(result.totalCost.toString()).toStringAsFixed(1)}",
            style: TextStyle(color: Colors.grey),
          ),


          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:Get.locale.toString().contains("en") ?MainAxisAlignment.start: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Invoices'.tr,
                      style: TextStyle(color: grey,fontWeight: FontWeight.bold,fontSize: 17),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _getTextList('Work cost'.tr,'${"SR".tr} ${double.parse(result.workCost.toString()).toInt().toString()}',)

                ),
              ),
              Container(
                height: result.orderParts.length != 0
                    ? MediaQuery.of(Get.context).size.width * 0.35
                    : 0,
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                          result.orderParts.length,
                          (index) => Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                        children: _getTextList(result.orderParts[index].partName,'${"SR".tr} ${result.orderParts[index].partCost}',)
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: orderPartList(index)
                                  ),
                                ],
                              )),
                    ),
                  ),
                ),
              ),
              Divider(
                color: grey,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getTextList('Timing'.tr,'${result.timeInDays} ${"Days".tr}')
                  // children: [
                  //   Text(),
                  //   Text(
                  //     ,
                  //     style: TextStyle(
                  //         color: blue,
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.bold),
                  //   )
                  // ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _getTextList('Total cost'.tr,
                        '${"SR".tr} ${double.parse(result.totalCost.toString()).toInt().toString()}',
                    textStyle: TextStyle(fontWeight: FontWeight.bold))
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }


  _getTextList(String title,String detail,{TextStyle textStyle}) {
    List<Widget> list=[
      Text(title,style: textStyle,),
      Text(
        detail,
        style: TextStyle(
            color: blue,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      )];
    return Get.locale.toString().contains("en") ? list : list.reversed.toList();
  }


  String getAllissue2(Result result) {
    var faults = result.faults;
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  getRatingName() {


    List<Widget> list =[
      Expanded(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment:Get.locale.toString().contains("en") ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                "${result.workshopName.name.toString()}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: Get.locale.toString().contains("ar")? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: result.orderRating == null
                          ? 0.0
                          : result.orderRating,
                      size: 30.0,
                      isReadOnly: true,
                      // fullRatedIconData: Icons.blur_off,
                      // halfRatedIconData: Icons.blur_on,
                      color: Color(0xFFFAB002),
                      borderColor: Color(0xFFFAB002),
                      spacing: 0.0),
                  Text(
                    "${result.orderRating == null ? 0.0.toString() : result.orderRating}",
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
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/carlogo.png"))),
          ),
        ),
      )
    ];

    return Get.locale.toString().contains("en") ?  list : list.reversed.toList();
  }

  getOrderNumber(Result result) {
    List<Widget> list=[
      Expanded(
          child: Row(
            mainAxisAlignment: Get.locale.toString().contains("ar")? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                'Order number'.tr,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: Get.height * .017,
                ),
              ),
            ],
          )),
      Expanded(
          child: Row(
            mainAxisAlignment: Get.locale.toString().contains("ar")? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text('Order date'.tr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Get.height * .017,
                  )),
            ],
          )),
    ];
    return
      Get.locale.toString().contains("ar")
          ?
      list.reversed.toList()
          :
        list;
  }

  getOrderNumerDate(Result result) {

    List<Widget> list=[
      Expanded(
          child: Row(
            mainAxisAlignment: Get.locale.toString().contains("ar")? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                '${result.orderId}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: Get.height * .02,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
      Expanded(
          child: Row(
            mainAxisAlignment: Get.locale.toString().contains("ar")? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text('${result.creationDate}'.replaceAll("T00:00:00", ""),
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: Get.height * .02,
                      fontWeight: FontWeight.bold)),
            ],
          )),
    ];


    return Get.locale.toString().contains("ar") ? list.reversed.toList(): list;


  }

  orderPartList(int index) {

    List<Widget> list=[
      Expanded(
          child: ApprovalChip(
            isCompleted: result
                .orderParts[index]
                .isApproved
                ? "Accepted".tr
                : result.orderParts[index]
                .pendingApproval
                ? "Waiting Approval".tr
                : !result
                .orderParts[
            index]
                .pendingApproval &&
                !result
                    .orderParts[
                index]
                    .isApproved
                ? "Rejected".tr
                : "Rejected".tr,
          )),
      Spacer(
        flex: 2,
      ),
      Expanded(
          child: TileButton(
            onTap: () {

            },
            title: 'View'.tr,
            isOutlined: true,
            height: 25,
          ))
    ];

    return Get.locale.toString().contains("en") ? list : list.reversed.toList();


  }
}
