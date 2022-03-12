import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About us".tr),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Container(
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("نحن فريق مصُان لخدمات صيانة السيارات.",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("رؤيتنا هي تسهيل ورفع جودة عملية صيانة السيارات حول المملكة العربية السعودية."
                    "رسالتنا هي ابراز افضل واقرب مراكز صيانة السيارات والمعتمدة من مُصان.\m"
                    "نسعى دائماً لراحة بالك والاستمتاع برحلة صيانة سيارتك.\n",style: TextStyle(fontSize: 15),),
              ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("الموقع الرسمي:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text("www.musan.net",style: TextStyle(fontSize: 18,color: Colors.blue.shade700,fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("الايميل الرسمي لمصان:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text("info@musan.net",style: TextStyle(fontSize: 18,color: Colors.blue.shade700,fontWeight: FontWeight.bold),),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("العنوان:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text("الرياض - حي الخليج\n",style: TextStyle(fontSize: 18),),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("الرمز البريدي:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text("13221",style: TextStyle(fontSize: 18),),
                ),
                SizedBox(height: 20,),
                SizedBox(height: 20,),


              ],),
          ),
        ));
  }
}
