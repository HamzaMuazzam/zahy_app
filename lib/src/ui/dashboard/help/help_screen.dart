import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'help_details.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String description =
      'نشكركم على تسجيلكم بتطبيق مصان، ونؤكد لكم بأن بياناتكم الشخصية ستكون بأمان كامل معنا، ونرجو منكم العلم أن صفحة سياسة الخصوصية الخاصة بنا تشمل بنود هامة يجب أن يعرفها جميع المستخدمين قبل استخدامهم لتطبيقنا، وهذه البنود تتضمن البيانات الشخصية المطلوبة من المستخدمين، وكيفية التعامل مع البيانات الشخصية الخاصة للمستخدم، ومسؤولية المستخدمين بتطبيقنا، وحقوق المستخدمين، وحقوق التطبيق، وهذه البنود هي كالتالي:-'
      '1-البيانات الشخصية التي نقوم بجمعها من المستخدمين وفيما نستخدم تلك البيانات: -'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      'نقوم بجمع بعض البيانات الشخصية من المستخدمين وذلك من أجل أن يتمكنوا من استخدام الخدمات المتنوعة التي يقدمها التطبيق، ومن أجل أن يتمكنوا من التسجيل بالتطبيق، ونقوم باستخدام بيانات المستخدمين من أجل ارسال عروض مميزة لكم، والبيانات التي نطلبها من السادة المستخدمين مثل البريد الالكتروني وكلمة السر، ونطلب بعض البيانات الأخرى لإتمام عملية الدفع وشراء الخدمة مثل بيانات وسيلة الدفع.'
      '2-مسؤولية المستخدم تجاه حسابه في التطبيق: -'
      'يقوم المستخدم بإنشاء حساب في التطبيق ويكتب كلمة سر لحسابه ، فيجب عليه أن يحتفظ بكلمة السر ولا يسلمها لأي شخص لأن كشف المستخدم لكلمة السر الخاصة به قد يعرض حسابه للإيقاف والتطبيق لا يتحمل مسؤولية سوء استخدا';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title:    Text(
          'Support'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .028,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: deepGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * .03),
            // supportWidget(1, 'Help for orders'.tr, workshopIcon, null),
            // supportWidget(2, 'Help for wallet'.tr, drawerPaymentIcon, null),
            Container(
              height: Get.height * 0.25,
              width: Get.width,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description),
              ),
            ),
            SizedBox(height: Get.height * .03),
            supportWidget(3, 'Call us'.tr, null, Icons.phone_in_talk),
            supportWidget(4, 'FAQ'.tr, null, null),
          ],
        ),
      ),
    );
  }

  Widget supportWidget(int index, String name, image, icon) {
    return GestureDetector(
      onTap: () {
        index == 1 || index == 2 ? Get.to(HelpDetails(title: name)) : null;
        if (index == 3) {
          launch("tel://+923224041454");

          // Scaffold.of(context).showBottomSheet((context) => Sheet(),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40) ),
          //     ),
          //     backgroundColor: white);
        }
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: Get.height * .02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffF1F3F5), width: 1),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff000000).withOpacity(.13),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: index == 4
                        ? Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: headingTextColor,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '?',
                                style: TextStyle(
                                  color: headingTextColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : index == 3
                            ? Icon(icon, color: headingTextColor, size: 22)
                            : Image.asset(image,
                                scale: 1.4, color: headingTextColor),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  name,
                  style: TextStyle(
                    color: headingTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: Get.height * .02,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_outlined,
                color: Colors.black, size: 18),
          ],
        ),
      ),
    );
  }
}

class Sheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .4,
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: 6,
              width: 80,
              decoration: BoxDecoration(
                  color: grey.withOpacity(0.3),
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10), right: Radius.circular(10))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Contact us Via'.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgTileButton(
                icon: 'assets/images/phone-call (2) 1.svg',
                title: 'Call'.tr,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgTileButton(
                icon: 'assets/images/sms-svgrepo-com.svg',
                title: 'SMS'.tr,
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgTileButton(
                icon: 'assets/images/chat 1.svg',
                title: 'Chat'.tr,
                onTap: () {
                  // Get.to(ChatScreen());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SvgTileButton extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;

  const SvgTileButton(
      {Key key,
      this.icon = 'assets/images/phone-call (2) 1.svg',
      this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width * 0.93,
        alignment: Alignment.center,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 0), // changes position of shadow
          )
        ], color: white, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: SvgPicture.asset(
                icon,
                color: blue,
                height: 30,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: blue, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
