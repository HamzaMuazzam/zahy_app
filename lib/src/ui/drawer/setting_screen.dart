import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/localization/language/languages.dart';
import 'package:musan_client/localization/locale_constant.dart';
import 'package:musan_client/model/language_data.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/drawer/privacy_screen.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:musan_client/utils/images.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import 'package:musan_client/main.dart' as app;


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isChecked = true;
  DashboardProvider data;
  @override
  void initState() {
    var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
    this.data=dashboardProvider;
    analytics.logScreenView(screenName: "SettingScreen",screenClass:"SettingScreen");

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder,data,child){
      this.data=data;

      return Scaffold(
      backgroundColor: screenBgColor,
      appBar: AppBar(
        backgroundColor: screenBgColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          'Settings'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
        child: Column(
          children: [
            editProfileWidget(),
            settingWidget(1, 'Language'.tr,Get.locale.toString().contains("en") ? "English" : 'عربي' ),
            // settingWidget(2, 'Theme', 'Light'),
            // _createLanguageDropDown(),
            settingWidget(3, 'Notifications'.tr, ''),
            // settingWidget(4, 'Privacy'.tr, ''),
          ],
        ),
      ),
    );});
  }
  _createLanguageDropDown() {
    return DropdownButton<LanguageData>(
      iconSize: 30,
      hint: Text(Languages
          .of(context)
          .labelSelectLanguage),
      onChanged: (LanguageData language) {
        changeLanguage(context, language.languageCode);
      },
      items: LanguageData.languageList()
          .map<DropdownMenuItem<LanguageData>>(
            (e) =>
            DropdownMenuItem<LanguageData>(
              value: e,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    e.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(e.name)
                ],
              ),
            ),
      )
          .toList(),
    );
  }

  Widget editProfileWidget() {
    return GestureDetector(
      onTap: () {
        Get.to(EditProfile());
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(
          bottom: Get.height * .01,
          top: Get.height * .01,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .06,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: .08,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(editIcon, scale: 3, color: headingTextColor),
            SizedBox(width: Get.width * .04),
            Text(
              'Edit Profile'.tr,
              style: TextStyle(
                color: headingTextColor,
                fontSize: Get.height * .02,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingWidget(int index, String name, String languageName) {
    return GestureDetector(
      onTap: () async {


        if(index==1){
          await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
            title: new Text('Alert'.tr),
            content: Text(
                '${"Do you want to change app language to".tr} ${Get.locale.toString().contains("en")
                    ?
                "عربي"
                    :
                "English"}' ),
            actions: <Widget>[
              InkWell(onTap: (){
                Get.back();
              },
                  child: new Text("${"Cancel".tr}")),
              new FlatButton(
                onPressed: () async {
                  SharedPreferences.getInstance().then((value) {
                    Get.back();
                    value.setString(Finals.USER_Language,Get.locale.toString().contains("en") ? "ar" : "en").then((value){
                      Get.locale=(Get.locale.toString().contains("en") ? Locale("ar") : Locale("en"));
                      // MyApp.restartApp(context);
                      app.main();
                      var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
                      dashboardProvider.onTabbedBar(1);
                      dashboardProvider.onTabbedBar(0);
                      setState(() {

                      });
                      setState(() {

                      });


                    });
                  });
                  // dismisses only the dialog and returns nothing
                },
                child: new Text('Confirm'.tr),
              )
            ],
          ),
        );
        }




        index == 4 ? Get.to(PrivacyScreen()) : null;
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(
          bottom: Get.height * .01,
          top: Get.height * .01,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .06,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: .08,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: headingTextColor,
                fontSize: Get.height * .02,
                fontWeight: FontWeight.w600,
              ),
            ),
            index == 3 ?  CustomSwitch (

              value: data.notificaionSetting,
              onChanged: (bool value){
                data.sub_unsub_topic(value);
                // data.updateNotificationSetting(val);

              },
            ): Row(
                    children: [
                      Text(
                        languageName,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: Get.height * .02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      index == 3
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child:Container()
                        /*CustomSwitchButton(
                                backgroundColor: Color(0xffEFEFEF),
                                unCheckedColor: Colors.grey,
                                animationDuration: Duration(milliseconds: 400),
                                checkedColor: themeColor,
                                checked: isChecked,
                              )*/,
                            )
                          : Icon(Icons.keyboard_arrow_down,
                              size: 20, color: themeColor),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

