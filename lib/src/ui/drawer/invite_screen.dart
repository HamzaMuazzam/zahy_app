import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class InviteCodeScreen extends StatefulWidget {
  const InviteCodeScreen({Key key}) : super(key: key);

  @override
  State<InviteCodeScreen> createState() => _InviteCodeScreenState();
}

class _InviteCodeScreenState extends State<InviteCodeScreen> {
  Widget verticalSpace = const SizedBox(height: 25);
  final FlutterShareMe share = FlutterShareMe();


  String couponCode="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((value) async {
      couponCode = value.getString(Finals.USER_COUPON,);
      setState(() {});
    });
    ApiServices.getCashBackValueOfCoupon();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body: Consumer<DashboardProvider>(
        builder: (builder,data,child) {
          return SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                SizedBox(
                    height: Get.width * .5, //for square *width
                    width: Get.width * .5,
                    child: Image.asset("assets/invite_screen_assest/QRIC.png", fit: BoxFit.fill)),
                verticalSpace,
                Container(
                  width: Get.width * .8,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 10,),
                         Text("$couponCode",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19)),
                        InkWell(
                          onTap: (){
                            Clipboard.setData(ClipboardData(text: couponCode)).then((_){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coupon '$couponCode' copied to clipboard")));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: SvgPicture.asset('assets/invite_screen_assest/SimpleIC.svg'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(Get.locale.toString().contains("en")?
                      "Share the code to get"
                          " ${data.couponAmount} SAR cash back once "
                          "they use it And they will "
                          "get discount %10 on their "
                          "first order":"شارك الكود مع أصدقائك واحصل على"
                  " ${data.couponAmount} ريال مستردة لحسابك بالمحفظة "
                  "و ١٠٪ خصم على أول طلب لصديقك",
                      textAlign: TextAlign.center),
                ),
                verticalSpace,
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  InkWell(
                      onTap: () async {
                        await sendEmail();
                      },
                      child: SvgPicture.asset('assets/invite_screen_assest/GmailIC.svg')),
                  InkWell(
                      onTap: () async {
                        var responce =
                        await share.shareToWhatsApp(msg: "Example Text");
                        debugPrint(responce);
                      },
                      child: SvgPicture.asset('assets/invite_screen_assest/WhatsAppIC.svg')),
                  InkWell(
                      onTap: () async {
                        await sendEmail();
                      },
                      child: SvgPicture.asset('assets/invite_screen_assest/emailIC.svg')),
                ])
              ],
            ),
          );
        }
      ),
    );
  }
  sendEmail() async {
    Email email = Email(
      body: couponCode,
      subject: '',
      recipients: [''],
      cc: [''],
      bcc: [''],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }


}

