import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isLoading = false.obs;

  signInAndLoading(BuildContext context) async {
    isLoading.value = true;
    update();
    AuthService.instance.signIn(
      context: context,
      email: emailController.text,
      password: passwordController.text,
      updataLoading: () {
        isLoading.value = false;
        update();
      },
    );
    isLoading.value = false;
    update();
  }
}
