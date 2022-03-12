import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:musan_client/new_desgin_login/EnterYourNumber.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/drawer/TermsConditions.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_apple/sign_in_apple.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isLoggedIn = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['Email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (e) {
      print(e);
    }
  }
  Logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    print("GET LOCALE: Musaan app logo.....    ${Get.locale}");
    var gsignIn = Provider.of<LoginProvider>(context, listen: false);
    gsignIn.initGoogleSignIn(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (builder,data,child){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container()
              ),
              /// Musaan app logo.....
              Expanded(
                  flex: 1,
                  child: Container(
                    // height: Get.height* 0.,
                    // width: Get.width/2,
                    decoration: BoxDecoration(
                      // color: blue,
                      borderRadius: BorderRadius.circular(30),
                      // image: DecorationImage(image: AssetImage('assets/playstore.png',),)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset('assets/logo.png',fit: BoxFit.fill,),
                    ),
                  )
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Text 'Enter Your Number'
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Enter your number'.tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                        /// Container for input Country and phone number...
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: Get.height*0.085,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.ltr,
                                children: [
                                  /// Text country number
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 12),
                                    child: Text(
                                      '+966',
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                  Expanded(child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return EnterYourNumber();
                                      }));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(right: 10,left: 5),
                                        child: TextFormField(
                                          // textDirection: TextDirection.ltr,
                                          enabled: false,
                                          controller: numberController,
                                          keyboardType: TextInputType.numberWithOptions(signed: true),

                                          decoration: InputDecoration(
                                            isDense: true,
                                              border: InputBorder.none,
                                              hintTextDirection: TextDirection.ltr,
                                              hintText: "Phone Number".tr,
                                              hintStyle: TextStyle(color: Colors.blueGrey,fontSize: 16)
                                          ),)
                                    ),
                                  ))

                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 12),
                                  //   child: Text(
                                  //     'Phone number',
                                  //     style: TextStyle(
                                  //         color: Colors.grey.shade400,
                                  //         fontSize: 18
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 2,
                              width: Get.width/2.5,
                              color: Colors.grey.shade200,
                            ),
                            Text(
                              ' '.tr,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              height: 2,
                              width: Get.width/2.5,
                              color: Colors.grey.shade200,
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        // SignInWithAppleButton(
                        //   onPressed: () async {
                        //     final credential = await SignInWithApple.getAppleIDCredential(
                        //       scopes: [
                        //         AppleIDAuthorizationScopes.email,
                        //         AppleIDAuthorizationScopes.fullName,
                        //       ],
                        //     );
                        //
                        //     print(credential);
                        //
                        //     // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                        //     // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                        //   },
                        // ),



                        // InkWell(
                        //   onTap:(){},
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       height: Get.height/15,
                        //       width: Get.width,
                        //       decoration: BoxDecoration(
                        //           color: Colors.black,
                        //           borderRadius: BorderRadius.circular(12)
                        //       ),
                        //       child: Row(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.all(12.0),
                        //             child: SvgPicture.asset(
                        //               'assets/images/whiteapplelogo.svg',
                        //               height: 32,
                        //               color: white,
                        //             ),
                        //           ),
                        //           SizedBox(width: Get.width/6),
                        //           Text(
                        //             'Sign in with Apple'.tr,
                        //             style: TextStyle(
                        //                 color: Colors.white,
                        //                 fontSize: 18
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
/*
                        InkWell(
                          onTap:()async{
                            await data.googleSignIn.signOut();
                            await data.googleSignIn.signIn();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: Get.height/15,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1,color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SvgPicture.asset(
                                      'assets/images/google.svg',
                                      height: 32,
                                    ),
                                  ),
                                  SizedBox(width: Get.width/6),
                                  Text(
                                    'Sign in with Google'.tr,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
*/
                      ],
                    ),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      Get.to(()=> TermsConditions());

                    },
                    child: Container(
                        height: Get.height,
                        width: Get.width,
                        child: Column(
                          children: [
                            SizedBox(height: Get.height/12),
                            Text(
                              'Terms & Conditions'.tr,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade500
                              ),
                            ),

                          ],
                        )
                    ),
                  )
              ),
            ],
          ),
        ),
      );
    });
  }



}
