import 'package:admin_clinical/features/auth/widgets/login_form.dart';
import 'package:admin_clinical/features/auth/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  PageController? controller = PageController();
  // final controller = Get.put()
  void switchPage(int index) {
    controller!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
              child: Image(
            image: const AssetImage("assets/images/background_login.jpg"),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            width: Get.width * 0.5,
            height: Get.height,
          )),
          Expanded(
            child: PageView(
              controller: controller,
              children: [
                LoginForm(switchPage: switchPage),
                SignUpForm(switchPage: switchPage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
