import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/locale/constantString.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:provider/provider.dart';

// class SignUp extends StatefulWidget {
//   String text;
//   SignUp(this.text);
//
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   final keyForm = GlobalKey<FormState>();
// String firstname,lastname;
//   @override
//   Widget build(BuildContext context) {
//
//     return Consumer<LoginProvider>(builder: (context, data,child){return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         color: lightGrey,
//         child: Column(
//           children: [
//             Expanded(
//                 flex: 5,
//                 child: Container(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.only(bottom: 15),
//                           child: Text(
//                             strCreateAnAccount,
//                             style: TextStyle(fontSize: 35),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 2,
//                         child: SingleChildScrollView(
//                           child: Form(
//                             key: keyForm,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 CustomTextForm(
//                                   keyBordType: TextInputType.name,
//                                   hintText: strFirstName,
//                                 onchange: (firstname){
//                                     this.firstname=firstname;
//                                 },
//                                 ),
//                                 CustomTextForm(
//                                   hintText: strLastName,
//                                   keyBordType: TextInputType.name,
//                                   onchange: (lastname){
//                                     this.lastname=lastname;
//                                   },
//                                 ),
//
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 TileButton(
//                                   onTap: () {
//
//                                     if(firstname!="" && lastname!=""){
//                                       Get.dialog(Center(child: CircularProgressIndicator(),),barrierDismissible: true);
//
//                                       // String body = '{"name": "$firstname $lastname","email": "${widget.text}","phoneNumber": "${data.userMobileNumber}","password": "123456789","type": 1}';
//                                       Map<String,String> body=   {'Name': '$firstname $lastname',
//                                         'PhoneNumber': '${data.userMobileNumber}',
//                                         'Password': '123456789',
//                                         'Type': '1',
//                                         'Email': '${widget.text}',
//                                         'FCMToken': 'noToken',
//                                         'SpecializationId': '1',
//                                         'IndustryId': '1',
//                                         'CityId': '1',
//                                         'Address': 'No Address Associated',
//                                         'Latitude': '0',
//                                         'Longitude': '0',
//
//                                       };
//                                       print(body);
//                                       ApiServices.signUpUser(body,context);
//
//
//
//
//                                     }else{
//                                       print('eee');
//                                       keyForm.currentState.validate();
//                                     }
//
//                                   },
//                                   title: strFinish,
//                                   isOutlined: false,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//
//           ],
//         ),
//       ),
//     );});
//   }
// }

class TileButton extends StatelessWidget {
  final String title;
  final bool isOutlined;
  final Function onTap;
  final double textSize, height;

  const TileButton(
      {this.title, this.isOutlined = false, this.onTap, this.textSize = 18, this.height = 55});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width * 0.93,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: isOutlined
                ? Border.all(
                    width: 1,
                    color: blue,
                  )
                : Border.all(width: 0, color: Colors.transparent),
            boxShadow: isOutlined
                ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.0),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
            color: isOutlined ? Colors.transparent : blue,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          title,textAlign: TextAlign.center,
          style: TextStyle(color: isOutlined ? blue : white, fontSize: textSize),
        ),
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final hintText, errorText, keyBordType;
final controller;
  final Function onchange;
  const CustomTextForm(
      {Key key,
      this.hintText,
      this.errorText ,
      this.keyBordType = TextInputType.emailAddress,this.controller,this.onchange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ], color: white, borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          onChanged: onchange,
          controller: controller,
          validator: (c) {
            if (c.contains('@')) {
              return null;
            } else
              return errorText ==null ? strEmailMustContain : errorText;
          },

          cursorColor: black,
          keyboardType: keyBordType,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              hintText: hintText==null ? strMobileNumberEmail : hintText ,
              hintStyle: TextStyle(color: grey)),
        ),
      ),
    );
  }
}

// const Color white = Color(0xFFFFFFFF);
const Color lightGrey = Color(0xFFF1F1F1);
const Color midGrey = Color(0xFF6F7D95);
const Color deepGrey = Color(0xFFF3F3F3);
const Color black = Color(0xFF000000);

const Color red = Color(0xFFE73939);
const Color green = Color(0xFF17CE3F);
const Color blue = Color(0xFF02AAF1);
const Color yellow = Color(0xFFFFC107);
const Color orangeYellow = Color(0xFFE8BC2A);
const Color white = CupertinoColors.white;
const Color grey = Color(0xFFB1B1B1);
const Color greylight = Color(0xFFBFBFBF);
const Color icon_grey_color = Color(0xFFCED5D9);
const Color textgreyColor = Color(0xFF7A8F99);
