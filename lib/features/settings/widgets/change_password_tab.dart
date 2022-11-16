import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

// ignore: must_be_immutable
class ChangePasswordTab extends StatelessWidget {
  const ChangePasswordTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 300, vertical: 80),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.2,
        ),
        borderRadius: AppDecoration.primaryRadiusBorder,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password Settings',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 30),
                Text(
                  'Current Password',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 5),
                const CustomTextFormField(
                  isPasswordField: true,
                  hint: 'Enter your Current password',
                  trailingIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'New Password',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 5),
                const CustomTextFormField(
                  isPasswordField: true,
                  hint: 'Enter your New password',
                  trailingIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Retype Password',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 5),
                const CustomTextFormField(
                  isPasswordField: true,
                  hint: 'Retype Password',
                  trailingIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    height: 40,
                    width: constraints.maxWidth * 0.3,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Change password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
