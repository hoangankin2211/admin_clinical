import 'dart:typed_data';

import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/features/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/utils.dart';

class GeneralSettingsTab extends StatefulWidget {
  const GeneralSettingsTab({super.key});

  @override
  State<GeneralSettingsTab> createState() => _GeneralSettingsTabState();
}

class _GeneralSettingsTabState extends State<GeneralSettingsTab> {
  final settingController = Get.find<SettingController>();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  final _isLoading = false.obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 180, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: _isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
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
                          Expanded(
                            child: CustomTextFormField(
                              controller: settingController.firstNameController,
                              title: '',
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              hint: 'First Name',
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
                              "Email Address",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              controller: settingController.emailController,
                              prefixWidget: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              hintStyle: const TextStyle(
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
                                      text:
                                          '\nThis will be display on your profile',
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
                          _image == null
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover, //
                                      image: NetworkImage(
                                          settingController.getUser().avt),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(_image!)),
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
                                    onTap: () => selectedImage(),
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
                              "Gender",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                    settingController.selectedRole.value =
                                        value;
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
                                  items: settingController
                                      .dropDownCountry.entries
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
                                  value:
                                      settingController.selectedCountry.value,
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
                        ],
                      ),
                      const Divider(
                        thickness: 0.2,
                        height: 30,
                        color: Colors.grey,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.45,
                            child: Text(
                              "Date Born",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Expanded(
                                      child: Text(
                                        DateFormat().add_yMMMEd().format(
                                            settingController
                                                .dateController.value),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final choice = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime(2030),
                                        initialDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Center(
                                              child: SizedBox(
                                            width: 1000.0,
                                            height: 1100.0,
                                            child: child,
                                          ));
                                        },
                                      );
                                      if (choice != null) {
                                        settingController.dateController.value =
                                            choice;
                                      }
                                    },
                                    child: const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),
                                  ),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.45,
                            child: Text(
                              "Phone Number",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Expanded(
                            child: CustomTextFormField(
                              controller:
                                  settingController.phoneNumberController,
                              title: '',
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                              hint: 'Phone Number',
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.2,
                        height: 30,
                        color: Colors.grey,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.45,
                          ),
                          Expanded(
                            child: CustomButton(
                              text: "Update Profile",
                              onTap: () async {
                                _isLoading.value = true;
                                await settingController.editProfile(
                                    context, _image);
                                _isLoading.value = false;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
