// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:musan_client/api_services/ApiServices.dart';
// import 'package:musan_client/api_services/Finals.dart';
// import 'package:musan_client/api_services/response_models/LoginReponse.dart';
// import 'package:musan_client/locale/constantString.dart';
// import 'package:musan_client/localization/locale_constant.dart';
// import 'package:musan_client/main.dart';
// import 'package:musan_client/src/provider/Login_provider.dart';
// import 'package:musan_client/src/ui/auth/SignUp.dart';
// import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
// import 'package:musan_client/utils/colors.dart';
// import 'package:musan_client/utils/common_classes.dart';
// import 'package:musan_client/utils/validator.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   int resendToken;
//
//   TextEditingController numberController = TextEditingController();
//
//   int screen = 0;
//
//   String verificationId;
//
//   FirebaseAuth instance;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       // SharedPreferences.getInstance().then((value) async {
//       //   await value.setBool(Finals.USER_LOGGED_IN_OR_NOT, true).then((value) => null);
//       //   // await value.setString(Finals.USER_EMAIL, loginReponse.result.user.email).then((value) => null);
//       //   // await value.setString(Finals.USER_TOKEN, loginReponse.result.token).then((value) => null);
//       //   // await value.setString(Finals.USER_REFRESH_TOKEN,loginReponse.result.refreshToken).then((value) => null);
//       //   await value.setString(Finals.USER_ID,'115').then((value) => null);
//       //   await value.setString(Finals.USER_NAME,'Hamza Muazzam').then((value) => null);
//       //   await value.setString(Finals.USER_TYPE_ID,'1').then((value) => null);
//       //   await value.setString(Finals.USER_PHONE,'+923224041445').then((value) => null);
//       //   Get.offAll(DashboardScreen());
//       //
//       // });
//
//       print("GET LOCALE: ${Get.locale}");
//       var gsignIn = Provider.of<LoginProvider>(context, listen: false);
//       gsignIn.initGoogleSignIn(context);
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: Firebase.initializeApp(),
//         builder: (context,snapshop){
//       return Consumer<LoginProvider>(builder: (contexts,data,child){
//         if(data.currentUser!=null){
//           print(data.currentUser.displayName);
//         }
//         return Scaffold(
//           resizeToAvoidBottomInset: true,
//           backgroundColor: screenBgColor,
//           body: SingleChildScrollView(
//             child: Container(
//               width: Get.width,
//               height: Get.height,
//               padding: EdgeInsets.symmetric(
//                 vertical: Get.height * .015,
//                 horizontal: Get.width * .06,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//
//
//                   Column(
//                     children: [
//                       SizedBox(height: Get.height * .15),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Login".tr,
//                           style: TextStyle(
//                             color: headingTextColor,
//                             fontSize: Get.height * .028,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: Get.height * .03),
//                       screen == 0
//                           ? SizedBox()
//                           : Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             data.userMobileNumber.toString()==""? "  ": data.userMobileNumber,
//                             style: TextStyle(
//                               color: Color(0xff1E1E1E),
//                               fontSize: Get.height * .02,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: (){
//                               data.setUserMobileNumner(numberController.text);
//                               setState(() {
//                                 screen=0;
//                               });
//                             },
//                             child: Text(
//                               "Edit".tr,
//                               style: TextStyle(
//                                 color: themeColor,
//                                 fontSize: Get.height * .02,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       _textFormFiled(0,screen == 0 ? 'Mobile number'.tr : 'Verification code'.tr,numberController),
//
//
//                       _loginButton('Login'.tr,data),
//                       screen == 0
//                           ? SizedBox()
//                           : InkWell(
//                                   onTap: () {
//                                     _resendOTP(data);
//                                   },
//                                   child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         margin: EdgeInsets.symmetric(
//                             vertical: Get.height * .03,
//                         ),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             border: Border.all(color: themeColor, width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Text(
//                           'Resend the code'.tr,
//                             style: TextStyle(
//                               color: themeColor,
//                               fontWeight: FontWeight.w600,
//                               fontSize: Get.height * .02,
//                             ),
//                         ),
//                       ),
//                           ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: (){
//                           _signInUsingGoogle(data);
//                         },
//                         child: Container(
//                           width: Get.width,
//                           height: Get.height * .065,
//                           margin: EdgeInsets.symmetric(
//                             vertical: Get.height * .03,
//                           ),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: Colors.transparent,
//                             border: Border.all(color: themeColor, width: 1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Text(
//                             'Log in with Google'.tr,
//                             style: TextStyle(
//                               color: themeColor,
//                               fontWeight: FontWeight.w600,
//                               fontSize: Get.height * .02,
//                             ),
//                           ),
//                         ),
//                       ),
//                       screen == 1
//                           ? SizedBox()
//                           : Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: (){
//
//                           },
//                           child: Text(
//                             'Terms & Condition'.tr,
//                             style: TextStyle(
//                               color: Color(0xff1E1E1E),
//                               fontSize: Get.height * .02,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: ()async {
//                           await showDialog(
//                               context: context,
//                               builder: (context) => new AlertDialog(
//                             title: new Text('Alert'.tr),
//                             content: Text(
//                                 '${"Do you want to change app language to".tr} ${Get.locale.toString().contains("en") ? "عربي" : "English"}' ),
//                             actions: <Widget>[
//                               InkWell(onTap: (){
//                                 Get.back();
//                               },
//                                   child: new Text("${"Cancel".tr}")),
//                               FlatButton(
//                                 onPressed: () async {
//                                   SharedPreferences.getInstance().then((value) {
//                                     Get.back();
//                                     value.setString(Finals.USER_Language,Get.locale.toString().contains("en") ? "ar" : "en").then((value){
//
//                                       Get.locale=(Get.locale.toString().contains("en") ? Locale("ar") : Locale("en"));
//                                       MyApp.restartApp(context);
//                                       // Get.offAll(LoginScreen());
//                                     });
//                                   });
//
//                                   // dismisses only the dialog and returns nothing
//                                 },
//                                 child: new Text('Confirm'.tr),
//                               ),
//                             ],
//                           ),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                             Text("Language".tr),
//                             SizedBox(width: 5,),
//                             Text(Get.locale.toString().contains("en") ? "English" : "عربي",style: TextStyle(color: blue,fontSize: 20),)
//                           ],),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
//     });
//   }
//
//   Widget _textFormFiled(int index,String label,TextEditingController tc) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: Get.height * .02),
//       child: TextFormField(
//         onTap: () {
//           Get.forceAppUpdate();
//         },
//         style: TextStyle(
//           fontSize: Get.height * .02,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//         controller: tc,
//         textInputAction: TextInputAction.done,
//         decoration: InputDecoration(
//           // floatingLabelBehavior: FloatingLabelBehavior.always,
//           isDense: true,
//           filled: true,
//           fillColor: Colors.white,
//           hintText: label,
//           hintStyle: TextStyle(
//               fontSize: Get.height * .018,
//               color: Color(0xff2C4752).withOpacity(.30)),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             borderSide: BorderSide(width: 1, color: Colors.white),
//           ),
//           errorStyle: TextStyle(fontSize: Get.height * .014),
//         ),
//         cursorColor: Colors.black,
//         // textAlign: TextAlign.left,
//         enabled: true,
//       ),
//     );
//   }
//
//   _loginButton(String text, LoginProvider data,) {
//     return GestureDetector(
//       onTap: () async {
//           data.setUserMobileNumner(numberController.text);
//         // if (screen == 1) {
//         //   Get.offAll(DashboardScreen());
//         // } else {
//         //   setState(() {
//         //     screen = 1;
//         //   });
//         // }
//         _signInWithPhoneNumber(numberController.text,data);
//       /*  if(screen==0){
//           if(numberController.text.length<11 ){
//             Get.snackbar(strInvalidNumber, strPleaseentercompletenumber);
//
//
//           }
//           else{
//             _signInWithPhoneNumber(numberController.text,data);
//             // _sendOtp(data);
//             // setState(() {
//             //   numberController.text="";
//             //   screen=1;
//             // });
//           }
//         }
//         else if(screen==1){
//           // if(numberController.text.length!=6){
//           //   Get.snackbar(strError, strInvalidcode);
//           //   return;
//           // }
//           // else{
//           //   _signInWithPhoneNumber(numberController.text,data);
//           // }
//
//
//           // FirebaseAuth.instance.signInWithPhoneNumber(verificationId: verificationId, smsCode: value).then((FirebaseUser value) {
//           //   Navigator.pop(context,[true]);
//           // }).catchError((e){
//           //   SHOW.TOAST(e);
//           // });
//
//         }*/
//
//
//
//
//       },
//       child: Container(
//         width: Get.width,
//         height: Get.height * .065,
//         margin: EdgeInsets.symmetric(vertical: Get.height * .01),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: themeColor,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(.13),
//               spreadRadius: 1,
//               blurRadius: 3,
//             ),
//           ],
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//             fontSize: Get.height * .02,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _signInWithPhoneNumber(String smsCode, LoginProvider data) async {
//     // if(verificationId==null){
//     //   print("Hello");
//     //   return;
//     // }
//     // var credential = await PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//     //
//     // await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
//     //   Get.snackbar(strVerificationCompleted,"");
//     logger.e(data.userMobileNumber);
//     _onVerificationCompleted( data.userMobileNumber);
//     // }).onError((error, stackTrace) {
//     //   Get.snackbar(strError, error.toString());
//     // });
//   }
//
//   void _signInUsingGoogle(LoginProvider data) {
//
//     data.googleSignIn.signIn();
//
//
//   }
//
//   void _sendOtp(LoginProvider data) async {
//
//     await Firebase.initializeApp().then((value) async {
//       instance= FirebaseAuth.instance;
//       await instance.verifyPhoneNumber(
//
//         phoneNumber: data.userMobileNumber,
//         // timeout: const Duration(seconds: 120),
//         forceResendingToken: resendToken,
//         verificationCompleted: (PhoneAuthCredential credential) {
//           Get.snackbar(strVerificationCompleted,"");
//           _onVerificationCompleted(data.userMobileNumber);
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           Get.snackbar(strVerificationFailed, "${e.message}");
//           print("verification Failed");
//         },
//         codeSent: (String verificationId, int resendToken) {
//           this.resendToken=resendToken;
//           this.verificationId=verificationId;
//
//           Get.snackbar(strCodesent, "$strCodeHasBeenSent ${data.userMobileNumber}");
//           print("codeSent");
//           setState(() {
//
//           });
//
//
//
//         },
//
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Get.snackbar("Alert", "Auto retrieval time out");
//           this.verificationId=verificationId;
//           print("codeAutoRetrievalTimeout");
//
//         },
//       );
//     });
//
//
//
//   }
//
//   void _onVerificationCompleted(String phoneNumber) {
//     // Get.offAll(DashboardScreen());
//
//     Get.dialog(Center(child: CircularProgressIndicator()));
//
//     String body='{"mobile": "$phoneNumber","password": "123456789",  "deviceToken": null}';
//
//     ApiServices.loginAccount(body,context,phoneNumber);
//
//
//
//
//
//   }
//
//   void _resendOTP(LoginProvider data) {
//     Get.snackbar(strCodeResent, strCodehasbeenresent);
//     _sendOtp(data);
//
//   }
//
// }