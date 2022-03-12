import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/auth/login_screen.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math; // import this

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  PageController homePagePictureIndicatorController = new PageController();
      var list=[
        "assets/images/onboarding1.svg",
        "assets/images/2.svg",
        "assets/images/3.svg"
      ];
      int index=0;
@override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: Get.height,
        width: Get.width,
        color: white,
        child: Column(children: [
          Expanded(child: Container(
            child: Column(
              children: [
              Expanded(
                child: SafeArea(
                  child: PageView(
                    controller: homePagePictureIndicatorController,
                     reverse:Get.locale.toString().contains("ar") ? true :false,
                    scrollDirection: Axis.horizontal,
                        children: List.generate(
                          3,
                          (index) {
                            return Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20,left: index==0 || index==2? 10: 0,right: index==2?10:0),
                                child: SvgPicture.asset(list[index],fit: BoxFit.fill,),
                              ),
                            );
                          },
                        ),
                        onPageChanged: (index) {
                          this.index=index;
                          setState(() {

                          });
                        },
                      ),
                ),
                  ),
               Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(

                          child: SmoothPageIndicator(
                            controller: homePagePictureIndicatorController,
                            count: 3,
                            effect: JumpingDotEffect(
                              activeDotColor: themeColor,
                              dotHeight: 12,
                              dotWidth: 12,
                              dotColor: Color(0xFFCED5D9),
                              radius: 10,
                              spacing: 6,
                            ),
                          ),
                        ),
                      ),
                    ),

            ],),


          )),
          _signupButton(),
          SizedBox(height: 45,)



        ],),
      ),
    );
  }

  gteRotation(int index){
    if (index == 2) {
      return 0.0;
    }
    else if (index != 2 && Get.locale.toString().contains('ar')) {
      return math.pi;
    }
    else if (index != 2 && Get.locale.toString().contains('en')) {
      return 0.0;
    }
  }



  Widget _signupButton() {
    return GestureDetector(
      onTap: () {
        // var dashboardProvider = Provider.of<DashboardProvider>(context,listen: false);
        // Get.dialog(Center(child: CircularProgressIndicator(color: themeColor,)));
        // ApiServices.getAllReportsByUserID(dashboardProvider);
        Get.offAll(Signup());
      },
      child: Container(
        width: Get.width * .85,
        height: Get.height * .065,
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
          'Login'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: Get.height * .0225,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }



}
