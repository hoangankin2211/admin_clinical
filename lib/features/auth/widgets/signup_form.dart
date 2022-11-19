import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key, required this.switchPage});

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
              'Sign Up',
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
                      'Sign up with Google',
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
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.person_outline),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: 'Enter your Full name',
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                labelText: 'Full Name',
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
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.lock_outline),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                hintText: 'Reenter your Password',
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                labelText: 'Reenter Password',
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
            AppDecoration.spaceBetweenElementForm,
            SizedBox(
              height: 50,
              width: double.infinity,
              child: CustomButton(
                title: 'Create Account',
                onPressed: () {},
              ),
            ),
            AppDecoration.spaceBetweenElementForm,
            Row(
              children: [
                const Text(
                  'Already have an account ? ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () => switchPage(0),
                  child: const Text(
                    'Log in',
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
