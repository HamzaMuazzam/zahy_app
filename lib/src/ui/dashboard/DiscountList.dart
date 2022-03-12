import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/response_models/GetDiscountOffers.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_location_screen.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/validator.dart';
import 'package:provider/provider.dart';

class DiscountList extends StatefulWidget {
  String image;
  List<Result> discountOffer;
  DiscountList(this.image, {this.discountOffer});

  @override
  _DiscountListState createState() => _DiscountListState();
}

class _DiscountListState extends State<DiscountList> {

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder, data, _) {
      return Scaffold(

        backgroundColor: screenBgColor,

        appBar: AppBar(
          backgroundColor: screenBgColor,
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
          centerTitle: false,
          title: Text(
            'Discount list'.tr,
            style: TextStyle(
              color: headingTextColor,
              fontSize: Get.height * .026,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        body: data.isDicountOffersLaoded ?

        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  child: Align(
                    alignment: Alignment(1, -1),
                    child: Container(
                      height: Get.height * 0.055,
                      width: Get.width * 0.35,
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * .02,
                        horizontal: Get.width * .06,
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
                        '20% discount'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Get.height * .02,
                        ),
                      ),
                    ),
                  ),
                  height: Get.height * 0.32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.image,
                        ),
                        fit: BoxFit.fill),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 3,
                          offset: Offset(1, 1),
                          color: Color(0xffecebeb))
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: Get.height * 0.18,
                  child: ListView.builder(
                    itemCount: data.discountOffersFromJson.result.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            width: Get.width * 0.28,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withOpacity(.13),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: Get.height * 0.135,
                                  color: Colors.grey,
                                  child: Image.network("https://muapi.deeps.info/${data.discountOffersFromJson.result[index].workshop.displayPicture}",
                                  fit: BoxFit.fill,),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Text(
                                      "${data.discountOffersFromJson.result[index].offerName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      !data.isDicountOffersLaoded ? " " :
                                      data.discountOffersFromJson.result[data.homePagePicture].isPercentDiscount ?
                                      "${double.parse(data.discountOffersFromJson.result[data.homePagePicture].discountValue.toString()).toInt()}% OFF"
                                          :"${double.parse(data.discountOffersFromJson.result[data.homePagePicture].discountValue.toString()).toInt()} SAR OFF",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Column(
                    children: List.generate(data.discountOffersFromJson.result.length, (index) {
                      var result = data.discountOffersFromJson.result[index];
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 15),
                        child: Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFBFBCBC),
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0), // shadow direction: bottom right
                                )
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: ExpansionTile(
                            onExpansionChanged: (val) {
                              setState(() {


                              });
                            },
                            title: Text("${result.workshop.name} ",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            initiallyExpanded: true,
                            children: [

                              Row(children: [
                                Expanded(
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        children: [
                                          Text("Offer name".tr,style: TextStyle(color: blue,fontSize: 15,fontWeight: FontWeight.w500),),
                                          Expanded(child: Text("${result.offerName}")),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Row(
                                        children: [
                                          Text("Discount".tr,style: TextStyle(color: blue,fontSize: 15,fontWeight: FontWeight.w500),),
                                          Expanded(child: Text("${result.discountValue.toInt()}${result.isPercentDiscount ?'% OFF'.tr : 'SAR OFF'.tr}"))
                                        ],
                                      ),
                                    ),
                                  ],),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 50,
                                    width: 50,
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
                                        image: DecorationImage(fit: BoxFit.fill,
                                            image: NetworkImage(result.workshop.displayPicture==null ?
                                            "https://i.imgur.com/vNYmZ47.png" : "https://muapi.deeps.info/${result.workshop.displayPicture}"))),
                                  ),
                                )
                              ],),




                              Padding(
                                padding: const EdgeInsets.only(left: 30,right: 15,top: 30),
                                child: TileButton(
                                  height: 50,
                                  onTap: () {
                                    Get.to(()=>CarLocationScreen(isTechnicianOrder: 1,isFromDicountOffers: true,offerID:result.discountOfferId));
                                  },
                                  isOutlined: true,
                                  title: 'Order'.tr,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  )),
            ],
          ),
        )
            :
        Center(child: CircularProgressIndicator(color: Colors.blue,),),

      );
    });
  }

  _addACarButton(DashboardProvider provider) {
    return GestureDetector(
      onTap: () {
        provider.addACarOnButtonTapped();
      },
      child: Container(
        width: Get.width,
        height: Get.height * .065,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .06,
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
          'Add a car'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  Widget _textFormFiled(
    int index,
    String label,
    TextEditingController tc,
    DashboardProvider provider) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: Get.height * .02,
        left: Get.width * .06,
        right: Get.width * .06,
      ),
      child: TextFormField(
        onTap: () {
          Get.forceAppUpdate();
        },
        style: TextStyle(
          fontSize: Get.height * .02,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        controller: tc,
        textInputAction:
            index == 4 ? TextInputAction.done : TextInputAction.next,
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
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          errorStyle: TextStyle(fontSize: Get.height * .014),
        ),
        cursorColor: Colors.black,
        textAlign: TextAlign.left,
        enabled: true,
        // keyboardType:
        //     TextInputType.numberWithOptions(signed: true, decimal: true),
        keyboardType: TextInputType.text,
        validator: FieldValidator.thisField,
      ),
    );
  }
}
