import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/locale/constantString.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:provider/provider.dart';

import 'SignUp.dart';

class EmailEnter extends StatelessWidget {
  final keyForm = GlobalKey<FormState>();
String text;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context,data,child){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: lightGrey,
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              strEnteremail,
                              style: TextStyle(fontSize: 35),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Form(
                              key: keyForm,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextForm(
                                    onchange: (value){
                                      text=value;
                                    },
                                    hintText: '$strEmail',
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TileButton(
                                    onTap: () {
                                      if (keyForm.currentState.validate()) {

                                        Get.to(Signup());


                                      }

                                      // Navigator.push(
                                      //     context, MaterialPageRoute(builder: (context) => SignUp()));
                                    },
                                    title: strCreateAnAccount,
                                    isOutlined: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: TileButton(
                            onTap: (){},
                            isOutlined: true,
                            title: strLoginwithGoogle,
                          ),
                        )
                      ],
                    ),
                  )),

            ],
          ),
        ),
      );
    },);
  }
}
