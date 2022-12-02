import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/features/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';

// ignore: must_be_immutable
class ChangePasswordTab extends StatelessWidget {
  ChangePasswordTab({super.key});
  final settingController = Get.find<SettingController>();

  final isLoading = false.obs;
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
          return Obx(() => isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
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
                      CustomTextFormField(
                        controller: settingController.oldPasswordController,
                        isPasswordField: true,
                        hint: 'Enter your Current password',
                        trailingIcon: const Icon(
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
                      CustomTextFormField(
                        controller: settingController.newPasswordController,
                        isPasswordField: true,
                        hint: 'Enter your New password',
                        trailingIcon: const Icon(
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
                      CustomTextFormField(
                        isPasswordField: true,
                        controller: settingController.rePasswordController,
                        hint: 'Retype Password',
                        trailingIcon: const Icon(
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
                            onPressed: () async {
                              isLoading.value = true;
                              await settingController.changePassword(context);
                              isLoading.value = false;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
        },
      ),
    );
  }
}
