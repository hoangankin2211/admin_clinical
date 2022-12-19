import 'package:admin_clinical/routes/name_route.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  signInAndLoading(BuildContext context) async {
    isLoading.value = true;

    final response = await AuthService.instance.signIn(
      context: context,
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false;
    if (response == true) {
      Get.offAllNamed(PageName.dashBoard);
    }
  }
}
