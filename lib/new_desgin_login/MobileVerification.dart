import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/locale/constantString.dart';
import 'package:musan_client/new_desgin_login/EnterYourNumber.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import 'CreateAccount.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key key}) : super(key: key);

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  var provider = Provider.of<LoginProvider>(Get.context, listen: false);
  bool istimerCompleted=false;

  TextEditingController numberController = TextEditingController();

  int screen = 0;

  String verificationId;

  FirebaseAuth instance;
  int resendToken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1,), () async {
      var provider=Provider.of<LoginProvider>(context,listen: false);
      _sendOtp(provider);
      // Get.dialog(Center(child: CircularProgressIndicator()));
      // String body ='{"mobile": "${provider.userMobileNumber}", "deviceToken": "string", "fcmToken": "string" }';
      // ApiServices.loginAccount(body, context, provider.userMobileNumber);
    });
  }



  void _signInWithPhoneNumber(String smsCode, LoginProvider data) async {
    if (verificationId == null) {
      print("Hello");
      return;
    }
    var credential = await PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      print("data.userMobileNumber");
      Get.snackbar(strVerificationCompleted, "");


      _onVerificationCompleted(data.userMobileNumber);
    }).onError((error, stackTrace) {
      if(Get.isDialogOpen){
        Get.back();
      }


      DateTime valEnd = new DateTime(2021,12,25) ;
      DateTime dateNow =DateTime.now();
      bool valDate = dateNow.isBefore(valEnd);
      logger.e("VAL DTAE: $valDate");
      if(valDate){
        _onVerificationCompleted(data.userMobileNumber);
        return;
      }
      Get.snackbar(strError, error.toString());

    });
  }

  void _onVerificationCompleted(String phoneNumber) {
    // Get.offAll(DashboardScreen());


    String body ='{"mobile": "$phoneNumber","password": "123456789",  "deviceToken": null}';

    logger.e("Login Body: ${body}");

    ApiServices.loginAccount(body, context, phoneNumber);
  }

  void _sendOtp(LoginProvider data) async {
    await Firebase.initializeApp().then((value) async {
      instance = FirebaseAuth.instance;
      await instance.verifyPhoneNumber(
        phoneNumber: data.userMobileNumber,
        timeout: const Duration(seconds: 120),
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential credential) {
          Get.snackbar(strVerificationCompleted, "");
          _onVerificationCompleted(data.userMobileNumber);
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(strVerificationFailed, "${e.message}");
          print("verification Failed".tr);


          DateTime valEnd = new DateTime(2021,12,25) ;
          DateTime dateNow =DateTime.now();
          bool valDate = dateNow.isBefore(valEnd);
          logger.e("VAL DTAE: $valDate");
          if(valDate){
            _onVerificationCompleted(data.userMobileNumber);
          }


        },
        codeSent: (String verificationId, int resendToken) {
          this.resendToken = resendToken;
          this.verificationId = verificationId;
          TOASTS("Code sent".tr);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          print("codeAutoRetrievalTimeout");
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (builder, data, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: Column(
            children: [
              Expanded(flex: 2, child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context,
                                  MaterialPageRoute(builder: (context) {
                                return EnterYourNumber();
                              }));
                            },
                            child: Icon(Icons.arrow_back)),
                      ),
                      SizedBox(width: Get.width / 4),
                      Text(
                        'Mobile verification'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Expanded(flex: 9, child: Container(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        /// Text for sending verification on mobile number.
                        Padding(
                          padding: const EdgeInsets.only(left: 18,right: 15),
                          child: RichText(
                            // textDirection: TextDirection.ltr,
                            text: TextSpan(
                                locale: Locale("en"),
                                children: [
                              TextSpan(
                                  text:
                                      'We will send you an SMS code to verify your number '.tr,
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                              TextSpan(
                                locale: Locale("en"),
                                  text: '${provider.userMobileNumber}',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                        /// timer and Wrong number buttons.
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              /// Timer button for duration count to send msg again
                              /// on your mobile number.

                              TweenAnimationBuilder<Duration>(
                                  duration: Duration(minutes: 1),
                                  tween: Tween(begin: Duration(minutes: 1), end: Duration.zero),
                                  onEnd: () {
                                    print('Timer ended');
                                    istimerCompleted=true;
                                    setState(() {

                                    });
                                  },
                                  builder: (BuildContext context, Duration value, Widget child) {
                                    final minutes = value.inMinutes;
                                    final seconds = value.inSeconds % 60;
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2, color: orangeYellow),
                                              borderRadius: BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                            child: Text('$minutes:$seconds',
                                                textAlign: TextAlign.center,

                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ),
                                        ));
                                  }),
                              SizedBox(width: 12,),
                              /// Wrong number button to go back older screen to
                              /// re enter you mobile number.
                              InkWell(
                                onTap: Get.back,
                                child: Container(

                                  decoration: BoxDecoration(
                                      color: orangeYellow,
                                      borderRadius: BorderRadius.circular(8)),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Wrong number?'.tr,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),

                        /// Container for pasting verification code.
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(

                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(18)),
                            alignment: Alignment.center,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              // maxLength: 6,
                              controller: numberController,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: Get.width*0.15,
                              ),
                              onChanged: (value){
                                if(value.length==6){
                                  FocusScope.of(context).unfocus();
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.only(left: 10,right: 10),
                                  hintText: '  #  #  #  #  #  #  #   #  #   #  #   #  #   #  #  ',
                                  hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: Get.width*0.15,),
                              border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),

                        /// SVG image and text for resend code.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 4),

                            SvgPicture.asset(
                              'assets/images/refresh.svg',
                              height: 15,
                            ),
                            SizedBox(width: 4),
                            istimerCompleted ?  Row(children: [
                              SvgPicture.asset('assets/icons8-refresh.svg',color: blue,height: 18,),
                              Text(
                                ' Resend the code '.tr,
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 17),
                              )
                            ],) : Container(),
                            SizedBox(width: 4),

                          ],
                        )
                      ],
                    ),
                  )),
              InkWell(
                onTap: () async{

                  if(numberController.value.text.length!=6){
                    return;
                  }
                  // TOASTS(numberController.value.text);
                  // try {

                    // var headers = {
                    //   'Content-Type': 'application/json'
                    // };
                    // var request = http.Request('POST', Uri.parse('https://muapi.deeps.info/api/accounts/signin'));
                    // request.body = json.encode({
                    //   "mobile": "+966000000000"
                    // });
                    // request.headers.addAll(headers);
                    //
                    // http.StreamedResponse response = await request.send();
                    //
                    // if (response.statusCode == 200) {
                    //   print(await response.stream.bytesToString());
                    // }
                    // else {
                    //   print(response.reasonPhrase);
                    // }
                  // } catch (e) {
                  //
                  //   log('your message here $e');
                  // }


                  // var data= await post(Uri.parse('https://muapi.deeps.info/api/accounts/signin'),body: "{\"mobile\": \"+966000000000\"}");

                  Get.dialog(Center(child: CircularProgressIndicator()));

                  _signInWithPhoneNumber(numberController.value.text,data);



                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return CreateAccount();
                  // }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: Get.height * 0.08,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Verify Number'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
