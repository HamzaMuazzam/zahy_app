import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
import 'package:musan_client/api_services/response_models/OfferOrderCustomReponse.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/images.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


class orderNegotitateDialog extends StatefulWidget {
  var offers;
  int index;
  Result result;
  orderNegotitateDialog(this.offers , this.index, {this.result});

  @override
  _orderNegotitateDialogState createState() => _orderNegotitateDialogState(this.offers,index);
}

class _orderNegotitateDialogState extends State<orderNegotitateDialog> {
  var offers;
  int index;
  _orderNegotitateDialogState(this.offers,this.index);
@override
  // TODO: implement widget
  orderNegotitateDialog get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder, provider, _) {
      return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * .06),
                  padding: EdgeInsets.symmetric(
                    vertical: Get.height * .02,
                    horizontal: Get.width * .03,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: provider.negotitateFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Negotiation'.tr,
                          style: TextStyle(
                            color: textColor,
                            fontSize: Get.height * .02,
                          ),
                        ),
                        _textFormFiled(
                          0,
                          'Set price'.tr,
                          provider.negotitateSetPriceController,
                          provider,
                        ),
                        // setTime("Set price", provider),
                        GestureDetector(
                          onTap: () {
                            // Get.back();
                            if(provider.negotiatePrioce.trim().length!=0){


                              print("OFFERS OBJECT  ${widget.result.offers[index].workshopId}" );
                              Get.dialog(Center(child: CircularProgressIndicator(),));
                              ApiServices.negotiateOffer(context, offers[index].offerId.toString(), provider.negotiatePrioce,workshopId:widget.result.offers[index].workshopId);


                            }


                          },
                          child: Container(
                            height: Get.height * .07,
                            margin: EdgeInsets.symmetric(
                              vertical: Get.height * .02,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(.13),
                                  spreadRadius: .08,
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Text(
                              'Send'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Get.height * .02,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: Get.height * .01,
                            bottom: Get.height * .03,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              'Cancel'.tr,
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Get.height * .02,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _textFormFiled(
      int index,
      String label,
      TextEditingController tc,
      DashboardProvider provider,
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height * .02,
      ),
      child: TextFormField(
        onChanged: (value){
          provider.negotiatePrioce=value;
        },
        style: TextStyle(
          fontSize: Get.height * .02,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        textInputAction:
        index == 1 ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          hintText: label,
          hintStyle: TextStyle(
              fontSize: Get.height * .018,
              color: Color(0xff2C4752).withOpacity(.30)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: textFieldBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: textFieldBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: textFieldBorderColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: textFieldBorderColor),
          ),
          errorStyle: TextStyle(fontSize: Get.height * .014),
        ),
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        enabled: true,
        keyboardType: TextInputType.number,
        // validator: FieldValidator.validatePhoneNumber,
      ),
    );
  }

  setTime(String hint, DashboardProvider dashboardProvider) {
    return GestureDetector(
      onTap: () {
        onSelectDateTapped(dashboardProvider);
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(bottom: Get.height * .03),
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .02,
          vertical: Get.height * .022,
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: textFieldBorderColor),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            dashboardProvider.negotaiteTime == null
                ? hint
                : DateFormat("dd-MM-yyyy")
                .format(dashboardProvider.negotaiteTime),
            style: TextStyle(
              color: dashboardProvider.negotaiteTime == null
                  ? Color(0xffA6AFBF)
                  : Colors.black,
              fontSize: Get.height * .02,
              // color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> onSelectDateTapped(DashboardProvider dashboardProvider) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dashboardProvider.negotaiteTime == null
            ? DateTime.now()
            : dashboardProvider.negotaiteTime,
        firstDate: new DateTime(1950),
        lastDate: new DateTime.now());

    setState(() {
      dashboardProvider.negotaiteTime = picked;
    });
  }
}