import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/features/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralSettingsTab extends StatelessWidget {
  GeneralSettingsTab({super.key});
  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 180, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Personal Info',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Update your avatar and personal information here',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: Text(
                        "Name",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const Expanded(
                      child: CustomTextFormField(
                        title: '',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        hint: 'First Name',
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: CustomTextFormField(
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        hint: 'Last Name',
                      ),
                    )
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: Text(
                        "Email Address",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    const Expanded(
                      child: CustomTextFormField(
                        prefixWidget: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                        hint: 'Email',
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: RichText(
                        text: TextSpan(
                            text: "Your Photo\n",
                            style: Theme.of(context).textTheme.headline4,
                            children: [
                              TextSpan(
                                text: '\nThis will be display on your profile',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                      color: Colors.blueGrey,
                                    ),
                              ),
                            ]),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'images/fake_avatar.jpg',
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: AppDecoration.primaryBorder,
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: CircleAvatar(
                                backgroundColor: Colors.blueGrey[50]!,
                                child: Center(
                                  child: Icon(
                                    Icons.cloud_upload_outlined,
                                    color: Colors.blueGrey[400],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                text: 'Click to upload',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const [
                                  TextSpan(
                                      text:
                                          ' or drag and drop SVG, PNG, JPG or GIF (max 800x400px)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: Text(
                        "Role",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: AppDecoration.primaryBorder,
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                        child: Obx(
                          () => DropdownButton<int>(
                            underline: const SizedBox(),
                            items: settingController.dropDownRoleChoice
                                .asMap()
                                .entries
                                .map((e) => DropdownMenuItem<int>(
                                      value: e.key,
                                      child: Text(
                                        e.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ))
                                .toList(),
                            value: settingController.selectedRole.value,
                            onChanged: (value) {
                              settingController.selectedRole.value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),

                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: Text(
                        "Country",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: AppDecoration.primaryBorder,
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                        child: Obx(
                          () => DropdownButton<String>(
                            underline: const SizedBox(),
                            items: settingController.dropDownCountry.entries
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e.key,
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.2,
                                      child: ListTile(
                                        dense: true,
                                        leading: Image.asset(
                                          e.value,
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                        title: Text(
                                          e.key,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: settingController.selectedCountry.value,
                            onChanged: (value) {
                              settingController.selectedCountry.value =
                                  value ?? 'Vietnam';
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
                //////////////////////////////////////////////////////////////////
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.45,
                      child: Text(
                        "Bio",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: ColoredBox(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: CustomTextFormField(
                            hint: 'Enter your Bio',
                            maxLine: 5,
                            borderSide: BorderSide(
                              color: Colors.blue[100]!,
                              width: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 0.2,
                  height: 30,
                  color: Colors.grey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
