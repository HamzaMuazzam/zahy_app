import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'additional_information_screen.dart';


class CarModelScreen extends StatefulWidget {
  const CarModelScreen({Key key}) : super(key: key);

  @override
  _CarModelScreenState createState() => _CarModelScreenState();
}

class _CarModelScreenState extends State<CarModelScreen> {

  ScrollController scrollController=ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkShopOrderProvider>(builder: (builder,data,child){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.blue.shade100,
          child: Column(
            children: [
              /// Animation bar using containers in a row.
              Expanded(
                  flex: 1,
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      child: stepBar(isFirstTickToshow: true, isSecondTickToshow: true)
                  )
              ),
              data.isUserCarsLoaded ?
              Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)
                        )
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22,right: 22,top: 22,),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Step 3 of 4'.tr,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Car model'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          Text(
                            'Select one of your car or add new one'.tr,
                            style: TextStyle(
                                color: textGreyColor,
                                fontSize: 18
                            ),
                          ),
                          Container(
                            height: Get.height*0.4,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                children: [
                                  Column(
                                    children: List.generate(data.carInformationReponseFromJsonByUserID.result.length, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: Column(
                                          children: [
                                            InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    data.selectedCarIndex=index;
                                                    // onTapCarModelList = !onTapCarModelList;
                                                  });
                                                },
                                                child:Container(
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color:  data.selectedCarIndex!=index ?  blueShade : yellowShade,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                height: 25,
                                                                width: 25,
                                                                decoration: BoxDecoration(
                                                                  color:  data.selectedCarIndex!=index  ?  Colors.white : yellow,
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                              ),
                                                              SizedBox(width: 12,),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Text(
                                                                      '${data.carInformationReponseFromJsonByUserID.result[index].carName}',
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.w500
                                                                      ),
                                                                    ),
                                                                    Text('${data.carInformationReponseFromJsonByUserID.result[index].model}, '
                                                                        '${data.carInformationReponseFromJsonByUserID.result[index].color}, '
                                                                        '${data.carInformationReponseFromJsonByUserID.result[index].carTransmission}',style: TextStyle(fontSize: 12),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 50,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: Center(
                                                                child: Image.asset('assets/images/carlogo.png')
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                addNewCar()
                                ],
                              ),
                            ),
                          ),
                          /// Row for tow buttons. Cancel and Next buttons.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: customCancelbackbutton()
                              ),
                              InkWell(
                                  onTap: (){

                                    if(data.selectedCarIndex==-1){
                                      return;
                                    }
                                    Get.to(AdditionalInformationScreen());
                                  },
                                  child: customNextButton()
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  )
              )
                  :
              Expanded(
                  flex: 6,
                  child: Center(child: CircularProgressIndicator(),)),
            ],
          )
        ),
      );
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytics.logScreenView(screenName: "CarModelScreen",screenClass:"CarModelScreen");

    SharedPreferences.getInstance().then((value) {
      ApiServices.getCarRelatedInformation(Get.context);

      ApiServices.getCarInformationByUserID(Get.context, value.getString(Finals.USER_ID));
    });
  }
}

Widget addNewCarOptions (int index,{double addNewCarWidth = 1}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Container(
      margin: EdgeInsets.only(bottom: 8),
      // padding: EdgeInsets.symmetric(horizontal: 12),
      height: 50,
      width: Get.width*addNewCarWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
      ),
    child: Row(children: [
      Expanded(child: dropDown(index))
    ],),

    ),
  );
}


Widget addNewCar(){
  return   Consumer<WorkShopOrderProvider>(builder: (builder,data,child){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: data.isExpanded ? yellowShade : blueShade,
      ),
      child: ExpansionTile(
        onExpansionChanged: (value){
          data.isExpanded=value;
          data.notifyListeners();
        },
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: data.isExpanded ? yellow : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add new car'.tr,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        maintainState: true,
        initiallyExpanded: true,
        children: [
          data.isCarRelatedDataLoaded ?
          SingleChildScrollView(
            child: Column(
              children: [
                addNewCarOptions(1,),
                addNewCarOptions(2),
                addNewCarOptions(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: addNewCarOptions(3)),
                    Expanded(child: addNewCarOptions(4)),
                  ],
                ),
                addNewCarOptions(5),
                GestureDetector(
                  onTap: () {
                    if(Get.isBottomSheetOpen){
                      Get.back();
                    }

                    data.addACar(Get.context);

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
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
                  ),
                ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    );
  });


}