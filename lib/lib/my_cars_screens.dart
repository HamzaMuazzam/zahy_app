import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/interniescreens/cars_detail_screen.dart';
import 'package:musan_client/src/provider/MyCarsScreenProvider.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_model_screen.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';

class MyCarsScreenNewDesign extends StatefulWidget {
  const MyCarsScreenNewDesign({Key key}) : super(key: key);

  @override
  _MyCarsScreenNewDesignState createState() => _MyCarsScreenNewDesignState();
}

class _MyCarsScreenNewDesignState extends State<MyCarsScreenNewDesign> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero,(){

      SharedPreferences.getInstance().then((value){

        Get.dialog(Center(child: CircularProgressIndicator(color: blue,),));

        ApiServices.getCarRelatedInformation(context);

        ApiServices.getMyCarsById(context, value.getString(Finals.USER_ID));

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<MyCarsScreenProvider>(builder: (builder,data,child){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,

            title: Text("My Cars".tr,style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [ InkWell(
              onTap: () {
                var data = Provider.of<WorkShopOrderProvider>(Get.context,listen: false);
                data.isExpanded=true;
                if(data.isCarRelatedDataLoaded){
                  Get.bottomSheet(Material(child: addNewCar(),),isScrollControlled: true);
                }
                else{
                  Get.dialog(Center(child: CircularProgressIndicator(),),barrierDismissible: true);
                  ApiServices.getCarRelatedInformation(context);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                  size: 30,
                ),
              ))],),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Container(
              color: Colors.white,
              child:
              data.isMyCarLoaded?
                  data.getMyCarsByUserIdFromJson.result.length!=0?

              ListView.builder(
                itemCount: data.getMyCarsByUserIdFromJson.result.length,
                itemBuilder: (context, index) {
                  Result result = data.getMyCarsByUserIdFromJson.result[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18, top: 15),
                    child: InkWell(
                      onTap: (){
                        Get.to( CarDetailsScreen(result));

                      },
                      child: Container(

                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      ///picture
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          height:MediaQuery.of(context).size.height/15,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(10)),
                                              image: DecorationImage(
                                                image:NetworkImage('https://i.imgur.com/cP53jb6.jpg',),
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                      ),
                                      /// text

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                        Row(children: [
                                          Expanded(
                                            child: Text(
                                              result.carName??"",
                                              style: const TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],),
                                            Text(
                                              result.company??"",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// button
                                 Padding(
                                  padding:
                                  EdgeInsets.only(right: 10),
                                  child: Icon(Get.locale.toString().contains("ar")
                                      ? Icons.keyboard_arrow_left_outlined: Icons.keyboard_arrow_right_rounded),

                                ),
                              ],
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// model
                                Padding(
                                  padding: const EdgeInsets.all(13.0),
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
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                /// color
                                Container(
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
                                    padding: const EdgeInsets.symmetric(horizontal: 35),
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
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                /// gear
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
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
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        decoration:  BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  );
                },
              ):
                  Container(
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        SvgPicture.asset('assets/images/emoji_laugh.svg'),
                        SizedBox(height: 20,),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No Car Available".tr,style: TextStyle(color: blue,fontSize: 25,fontWeight: FontWeight.bold),),
                        )

                      ],),)
                  : Container(),
            ),
          ),
        ),
      );
    });
  }



}
