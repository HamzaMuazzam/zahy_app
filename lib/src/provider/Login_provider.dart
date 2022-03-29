import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/LoginReponse.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>['email']);
  GoogleSignInAccount currentUser;
  String userMobileNumber;

  void setUserMobileNumner(String mobileNumber) {
    userMobileNumber = mobileNumber;
    notifyListeners();
  }

  void initGoogleSignIn(BuildContext context) {

    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account)async {
      try{
        print('called');
        if(account!=null){

          Get.dialog(Center(child: CircularProgressIndicator()));

          currentUser = account;
          // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          // await sharedPreferences.setBool(Finals.USER_LOGGED_IN_OR_NOT, true);
          // await  sharedPreferences.setString(Finals.USER_EMAIL, currentUser.email);
          // await  sharedPreferences.setString(Finals.USER_NAME, currentUser.displayName);
          // Get.to(DashboardScreen());
          // Get.reset();



          String body='{"mobile": "${currentUser.id}","password": "123456789",  "deviceToken": null}';

          ApiServices.loginAccount(body, context, currentUser.id,isLoginMethodGoogle: true);



        }
        googleSignIn.signInSilently();
        notifyListeners();
      }
      catch(e){

        e.printError();

      }

    });

  }

  saveLogin(LoginReponse loginReponse){

    SharedPreferences.getInstance().then((value) async {
      await value.setBool(Finals.USER_LOGGED_IN_OR_NOT, true).then((value) => null);
      await value.setString(Finals.USER_EMAIL, loginReponse.result.user.email).then((value) => null);
      await value.setString(Finals.USER_TOKEN, loginReponse.result.token).then((value) => null);
      await value.setString(Finals.USER_REFRESH_TOKEN,loginReponse.result.refreshToken).then((value) => null);
      await value.setString(Finals.USER_ID,loginReponse.result.user.id.toString()).then((value) => null);
      await value.setString(Finals.USER_NAME,loginReponse.result.user.name).then((value) => null);
      await value.setString(Finals.USER_TYPE_ID,loginReponse.result.user.userTypeId.toString()).then((value) => null);
      await value.setString(Finals.USER_PHONE,loginReponse.result.user.phoneNumber).then((value) => null);
      await value.setString(Finals.USER_COUPON,loginReponse.result.user.couponCode).then((value) => null);
      userMobileNumber=loginReponse.result.user.phoneNumber;

      Get.offAll(DashboardScreen());

    });
  }
  String userName;
  void setName(String name) {
    userName=name;
    notifyListeners();
  }



}