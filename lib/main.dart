import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/provider/MyCarsScreenProvider.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/ui/splash/SplashScreen.dart';
import 'package:provider/provider.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'locale/StaticStrings.dart';
import 'src/provider/dashboard_provider.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';

Future main() async {

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  WidgetsApp.debugAllowBannerOverride = false;

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.blue,
  //     statusBarIconBrightness: Brightness.light));


  runApp(MyApp(sharedPreferences));
}

class MyApp extends StatefulWidget {


  SharedPreferences sharedPreferences;

  MyApp(this.sharedPreferences);
  @override
  _MyAppState createState() => _MyAppState(this.sharedPreferences);
}

class _MyAppState extends State<MyApp> {

  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  SharedPreferences sharedPreferences;
  _MyAppState(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {

    var languageCode = sharedPreferences.getString(Finals.USER_Language);
    if(languageCode==null || languageCode==""){
      languageCode="en";
    }
    return  KeyedSubtree(
      key: key,
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => DashboardProvider()),
            ChangeNotifierProvider(create: (context) => LoginProvider()),
            ChangeNotifierProvider(create: (context) => WorkShopOrderProvider()),
            ChangeNotifierProvider(create: (context) => OrderScreenProvider()),
            ChangeNotifierProvider(create: (context) => MyCarsScreenProvider()),
          ],
          child: GetMaterialApp(
            theme: ThemeData(fontFamily: 'noto_all'),
            debugShowCheckedModeBanner: false,
              locale: new Locale(languageCode,''),
              fallbackLocale: Locale(languageCode, ''),
              translations: StaticStrings(),
              title: 'Zahy',
              color: Colors.white,
              home: SplashScreen(),
          ),
        ),
    );

  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}