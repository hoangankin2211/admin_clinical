import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:admin_clinical/routes/page_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinic Management',
      defaultTransition: Transition.fadeIn,
      theme: ThemeData(
        fontFamily: "Roboto",
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: AppColors.headline1TextColor,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.greyBackgroundCOlor,
        primarySwatch: Colors.lightBlue,
      ),
      getPages: PagesRoute.pages,
      initialRoute: PageName.dashBoard,
    );
  }
}
