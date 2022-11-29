import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_profile_screen.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/fake_data.dart';
import '../../../constants/global_widgets/custom_password_field.dart';
import '../../../constants/global_widgets/custom_text_field_icon_btn.dart';
import '../../patient/widgets/custom_text_form_field.dart';

class DialogAddNewDoctor extends StatelessWidget {
  DialogAddNewDoctor({
    Key? key,
  }) : super(key: key);
  final _passController = TextEditingController();
  RxInt _value = 0.obs;
  final _rePassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person,
                  color: AppColors.primaryColor, size: 30.0),
              const Text(
                " Add new Doctor",
                style: TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: AppColors.headline1TextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Divider(thickness: 1),
          const SizedBox(height: 20.0),
          Expanded(
            child: Row(children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Expanded(
                              child: CustomTextFormField(
                            title: "First Name",
                            width: double.infinity,
                            hint: "Enter First Name",
                            trailingIcon: Icon(Icons.person),
                          )),
                          SizedBox(width: 20.0),
                          Expanded(
                              child: CustomTextFormField(
                            title: "Last Name",
                            width: double.infinity,
                            hint: "Enter Last Name",
                            trailingIcon: Icon(Icons.person),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: const [
                          Expanded(
                              child: CustomTextFormField(
                            title: "UserName",
                            width: double.infinity,
                            hint: "Enter Username",
                            trailingIcon: Icon(Icons.person),
                          )),
                          SizedBox(width: 20.0),
                          Expanded(
                              child: CustomTextFormField(
                            title: "Email",
                            width: double.infinity,
                            hint: "Enter Email",
                            trailingIcon: Icon(Icons.person),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                              child: CustomPasswordField(
                                  controller: _passController,
                                  hintText: "Enter Password",
                                  labelText: "Password")),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: CustomPasswordField(
                                controller: _rePassController,
                                hintText: "Enter Re-Password",
                                labelText: "Confirm Password"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldIconBtn(
                              title: "Day of Birth",
                              width: double.infinity,
                              callBack: () {},
                              trailingIcon: const Icon(Icons.calendar_month),
                              hint: "Select Day of Birth",
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Obx(
                            () => Expanded(
                                child: Row(
                              children: [
                                const Text(
                                  "Gender:   ",
                                  style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                const Text(
                                  "Male",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Radio(
                                  value: 0,
                                  groupValue: _value.value,
                                  onChanged: (value) {
                                    _value.value = value!;
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                                const SizedBox(width: 40.0),
                                const Text(
                                  "Fe Male",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Radio(
                                  value: 1,
                                  groupValue: _value.value,
                                  onChanged: (value) {
                                    _value.value = value!;
                                  },
                                  activeColor: AppColors.primaryColor,
                                ),
                              ],
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const CustomTextFormField(
                        title: "Address",
                        width: double.infinity,
                        hint: "Enter Address",
                        trailingIcon: Icon(Icons.location_on_sharp),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          const Expanded(
                              child: CustomTextFormField(
                            title: "Phone Number",
                            width: double.infinity,
                            hint: "Enter Phone Number",
                            trailingIcon: Icon(Icons.phone),
                          )),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: CustomTextFieldIconBtn(
                              title: "Country",
                              width: double.infinity,
                              callBack: () {},
                              trailingIcon: const Icon(Icons.arrow_drop_down),
                              hint: "Select Day of Country",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      const CustomTextFormField(
                        title: "Description",
                        maxLine: 4,
                        width: double.infinity,
                        hint: "Enter Description",
                      )
                    ],
                  )),
              const SizedBox(width: 10),
              Container(
                  width: 0.3, height: double.infinity, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.2),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/fake_avatar.jpg',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.4)
                              ]),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black.withOpacity(0.2)),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "  Pick Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 70,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.primaryColor.withOpacity(0.7),
                          ),
                          child: const Text(
                            "Create Doctor",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
