import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/FCM.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';


class ThankYou extends StatefulWidget {
  const ThankYou({Key key}) : super(key: key);

  @override
  _ThankYouState createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {


  var dashboardProvider=Provider.of<DashboardProvider>(Get.context,listen: false);
  bool willpop=false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        return willpop;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.blue.shade100,
          child: Column(
            children: [
              /// Animation bar using containers in a row.
              /*Expanded(
                  flex: 1,
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      child: stepBar(isFirstTickToshow: true, isSecondTickToshow: true, isThirdTickToshow: true, isFourthTickToshow: true)
                  )
              ),*/
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22,right: 22,top: 22,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height/3.2,
                          width: Get.width/1.6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image.asset('assets/playstore.png'),
                          ),
                        ),
                        Text(
                            'Thank You!'.tr,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                            'Thanks for using Musan app'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                            'You can now track your order status on the order details screen'.tr,
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: Get.height/16,),
                        GestureDetector(
                          onTap: ()async {
                            getOffersAndOderAtOnce();
                            willpop=true;
                            if(dashboardProvider.isTechnicianOrder==0){
                              ///this mean technician order
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            }
                            else{
                              ///this mean workshop order
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            }

                            // await Get.offAll(DashboardScreen());
                            // await Future.delayed(Duration(seconds: 1));
                            // var dashbaord=Provider.of<DashboardProvider>(context,listen: false);
                            dashboardProvider.onTabbedBar(1);


                            },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Order Details'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            willpop=true;
                            getOffersAndOderAtOnce();

                            if(dashboardProvider.isTechnicianOrder==0){
                              ///this mean technician order
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            }
                            else{
                              ///this mean workshop order
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                              Get.back();
                            }
                            // Get.offAll(DashboardScreen());

                          },
                          child: Text(
                              'Back to Home'.tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    analytics.logScreenView(screenName: "ThankYou",screenClass:"ThankYou");

  }
}
