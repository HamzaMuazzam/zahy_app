import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/LoginReponse.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
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

  var loginProvider =Provider.of<LoginProvider>(Get.context, listen: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // var body = '''{"message": "POST Request successful.","result": {"token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiIxNjU2IiwidW5pcXVlX25hbWUiOiIxNTk4NzQ1NjMiLCJzdWIiOiJhY2NvdW50T25lQGdtYWlsLmNvbSIsImp0aSI6Ijg1YTRhYzhkLWVjYjItNDFjNC1iNDQ1LTk2YTJlNGFkMjI1MiIsImVtYWlsIjoiYWNjb3VudE9uZUBnbWFpbC5jb20iLCJpZCI6IjE2NTYiLCJuYmYiOjE2NDgzNjc2NDUsImV4cCI6MTY0ODQ1NDA0NSwiaWF0IjoxNjQ4MzY3NjQ1LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0IiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdCJ9.CLJpEIHUuagPFOCT7QS6sBHLiLJeolCY3b8fik-suxKeSnZr5v5S3LWjFsnVBFxTYSFogQTrTEZAWLZmGyPJrQ","refreshToken": "5a63ef00-88a6-49cb-ba38-817eead989ac","user": {"id": 1659,"name": "any","email": "any@any.com","created": "2022-03-27T10:53:44.043+03:00","phoneNumber": "12365479444798","userTypeId": 1,"isAvailable": false,"vatEnabled": false,"fcmToken": null,"couponCode": "1659AVAODC"}}}''';
    //
    // LoginReponse loginReponse = loginReponseFromJson(body.toString());
    //
    // loginProvider.saveLogin(loginReponse);

  }

}
