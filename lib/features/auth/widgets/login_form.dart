import 'dart:convert';

import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/auth/controller/auth_controller.dart';
import 'package:admin_clinical/features/auth/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatelessWidget {
  LoginForm({super.key, required this.switchPage});
  final controller = Get.find<AuthController>();
  final Function(int) switchPage;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: Theme.of(context).textTheme.headline1,
            ),
            AppDecoration.spaceBetweenElementForm,
            InkWell(
              borderRadius: AppDecoration.primaryRadiusBorder,
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: AppDecoration.primaryRadiusBorder),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/images/google.png'),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login with Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            AppDecoration.spaceBetweenElementForm,
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey[350],
                    thickness: 1.5,
                    endIndent: 5,
                  ),
                ),
                const Text(
                  'Or',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Divider(
                    indent: 5,
                    color: Colors.grey[350],
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            AppDecoration.spaceBetweenElementForm,
            TextFormField(
              autofocus: true,
              controller: controller.emailController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email_outlined),
                hintText: "Enter your Email",
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppDecoration.primaryRadiusBorder,
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: controller.passwordController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.lock_outline),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: 'Enter your Password',
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                labelText: 'Password',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppDecoration.primaryRadiusBorder,
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Remember Information',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () async {
                      Get.dialog(const ForgetPasswordForm());
                    },
                    child: const Text("Forgot Password",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)))
              ],
            ),
            AppDecoration.spaceBetweenElementForm,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.signInAndLoading(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDecoration.primaryRadiusBorder,
                    ),
                  ),
                  child: Obx(
                    () => !controller.isLoading.value
                        ? const Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                  )),
            ),
            AppDecoration.spaceBetweenElementForm,
            Row(
              children: [
                const Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () => switchPage(1),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
