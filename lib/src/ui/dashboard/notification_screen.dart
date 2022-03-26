import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GetNotification.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:provider/provider.dart';
class NotificationScreen extends StatefulWidget {
  NotificationScreen();
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    ApiServices.getNotifications();
    super.initState();
    analytics.logScreenView(screenName: "NotificationScreen",screenClass:"NotificationScreen");

  }
  @override
  Widget build(BuildContext context)=> Consumer<DashboardProvider>(builder: (builder,data,child)=>Scaffold(

    backgroundColor: screenBgColor,

    appBar: AppBar(
      backgroundColor: screenBgColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
        onPressed: () => Get.back(),
      ),
      elevation: 0,
      title: Text(
        'Notifications'.tr,
        style: TextStyle(
          color: headingTextColor,
          fontSize: Get.height * .026,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    body: data.isNotiDataLoaded
        ?  SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * .02),
          child: Column(
            children: List.generate(data.notificationFromJson.result.length, (index) {
              return notificationWidget(data.notificationFromJson.result[index]);
            }),
          ),
        )) : Center(child: CircularProgressIndicator(color: blue,),),

  ));
  notificationWidget(Result result) {
    return InkWell(
      onTap: ()async{
        await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
          title: new Text('${result.title} '),
          content: Text(
              '${result.message} '),
          actions: <Widget>[

            new Text("${"Time".tr}: ${result.notificationTime}"),
            new FlatButton(
              onPressed: () {
                Get.back();
                ApiServices.markAsReadNotification(result.id);

                // dismisses only the dialog and returns nothing
              },
              child: new Text('Mark as read'.tr),
            ),
          ],
        ),
        );
      },
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .02,
          horizontal: Get.width * .04,
        ),
        margin: EdgeInsets.only(
          left: Get.width * .06,
          right: Get.width * .06,
          bottom: Get.height * .02,
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${result.title} ",
              style: TextStyle(
                color: Color(0xff1E1E1E).withOpacity(.70),
                fontSize: Get.height * .018,
              ),
            ),
            SizedBox(height: Get.height * .01),
            RichText(
              text: TextSpan(
                text: "${result.message} ",
                style: TextStyle(
                  color: themeColor,
                  fontSize: Get.height * .021,
                  fontWeight: FontWeight.w600,
                ),
                children: <TextSpan>[
                  // TextSpan(
                  //   text: 'has sent an offer....',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontSize: Get.height * .021,
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
