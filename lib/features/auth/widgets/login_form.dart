import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, required this.switchPage});

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
                  children: [
                    Image.asset(
                      'images/google.png',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
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
                    onPressed: () {},
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
              child: CustomButton(
                title: 'Login',
                onPressed: () => Get.toNamed(PageName.dashBoard),
              ),
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
