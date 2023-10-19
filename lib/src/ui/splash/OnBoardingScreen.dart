import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/splash/SplashScreen.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController homePagePictureIndicatorController = new PageController();
  var list = ["assets/images/onboarding1.svg", "assets/images/2.svg", "assets/images/3.svg"];
  int index = 0;

  final List<IntroTextModel> introList = <IntroTextModel>[
    IntroTextModel("Zahy guarantees your comfort",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ."),
    IntroTextModel("High quality maintenance services",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ."),
    IntroTextModel("A technology experience that improves your life",
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ."),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            
            _signupButton(),

            InkWell(
              onTap: () async {
                SharedPreferences.getInstance().then((value) {
                  Get.back();
                  value
                      .setString(
                      Finals.USER_Language, Get.locale.toString().contains("en") ? "ar" : "en")
                      .then((value) {
                    Get.locale =
                    (Get.locale.toString().contains("en") ? Locale("ar") : Locale("en"));
                    Get.offAll(SplashScreen());
                  });
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Language".tr),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    Get.locale.toString().contains("en") ? "English" : "عربي",
                    style: TextStyle(color: blue, fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ).paddingOnly(bottom: 20),

        body: Container(
          height: Get.height,
          width: Get.width,
          color: white,
          child: Column(
            children: [
              SizedBox(height: 50),
              Expanded(
                // height: Get.height * .5
                child: PageView(
                  controller: homePagePictureIndicatorController,
                  reverse: Get.locale.toString().contains("ar") ? true : false,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    3,
                    (index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20,
                                  left: index == 0 || index == 2 ? 10 : 0,
                                  right: index == 2 ? 10 : 0),
                              child: SvgPicture.asset(
                                list[index],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                         Column(children: [
                           Text(
                             introList[index].title,
                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                           ),
                           Text(
                             introList[index].des,
                             style: TextStyle(),
                           ),
                         ],)
                        ],
                      );
                    },
                  ),
                  onPageChanged: (index) {
                    this.index = index;
                    setState(() {});
                  },
                ).paddingSymmetric(horizontal: 20),
              ),


            ],
          ),
        ),
      ),
    );
  }

  gteRotation(int index) {
    if (index == 2) {
      return 0.0;
    } else if (index != 2 && Get.locale.toString().contains('ar')) {
      return math.pi;
    } else if (index != 2 && Get.locale.toString().contains('en')) {
      return 0.0;
    }
  }

  Widget _signupButton() {
    return GestureDetector(
      onTap: () {
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
              color: Colors.white, fontSize: Get.height * .0225, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  var loginProvider = Provider.of<LoginProvider>(Get.context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
}

class IntroTextModel {
  final String title;
  final String des;

  IntroTextModel(this.title, this.des);
}
