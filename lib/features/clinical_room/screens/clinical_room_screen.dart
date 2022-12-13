import 'package:admin_clinical/constants/global_widgets/header_list_item.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:admin_clinical/features/clinical_room/controller/clinical_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/btn_with_icon.dart';
import '../../auth/widgets/custom_button.dart';

class ClinicalRoom extends StatelessWidget {
  ClinicalRoom({super.key});
  final controller = Get.find<ClinicalRoomController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          _searchField(MediaQuery.of(context).size.width, context),
          const SizedBox(height: 20.0),
          Expanded(
            child: Row(children: [
              Expanded(
                flex: 5,
                child: _listField(),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: _listRoomViewField(),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Container _listRoomViewField() {
    return Container(
      margin: const EdgeInsets.only(right: 20.0, bottom: 20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Name Room",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1),
          const SizedBox(height: 10.0),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reception",
                      style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView(
                    children: [
                      ClinicalPatientItem(),
                      ClinicalPatientItem(),
                      ClinicalPatientItem(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 1),
          const SizedBox(height: 10.0),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Exmained",
                      style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView(
                    children: [
                      ClinicalPatientItem(),
                      ClinicalPatientItem(),
                      ClinicalPatientItem(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {},
            child: Container(
              // margin:
              //     const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              width: double.infinity,
              height: 55,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor.withOpacity(0.6),
              ),
              child: const Text(
                "Edit Room",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listField() {
    return Obx(
      () => Column(
        children: [
          const HeaderListItem(
            checkHeader: true,
            titles: [
              "ID",
              "Name",
              "Reception",
              "Exmained",
            ],
          ),
          const SizedBox(height: 10.0),
          ...controller.listClincalRoom.map((element) => InkWell(
                onTap: () => controller.selectRoomId.value = element.id,
                child: ListItem(
                  widgets: [
                    Text(
                      element.id,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.primarySecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    Text(
                      element.name,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.primarySecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.userDoctor,
                            color: Colors.green, size: 20.0),
                        Text(
                          ' ${element.reception}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.medical_services,
                            color: Colors.red, size: 20.0),
                        Text(
                          ' ${element.exmained}',
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  ],
                  checkHeader: true,
                ),
              ))
        ],
      ),
    );
  }

  Row _searchField(double widthDevice, BuildContext context) {
    return Row(
      children: [
        Container(
          width: widthDevice / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: AppColors.headline1TextColor.withOpacity(0.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Row(
            children: [
              const SizedBox(width: 10.0),
              const Icon(Icons.search, color: AppColors.headline1TextColor),
              const SizedBox(width: 10.0),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search Doctor.....",
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        BtnWithIcon(
          title: "Add new Room",
          icon: Icons.add,
          color: AppColors.primaryColor.withOpacity(0.5),
          callBack: () => Get.dialog(
            Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                width: 400,
                height: 300,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Add new Room",
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    const SizedBox(height: 5.0),
                    const Divider(thickness: 1),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      autofocus: true,
                      controller: controller.textController,
                      decoration: InputDecoration(
                        suffixIcon: const SizedBox(),
                        hintText: "Enter Name Room",
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        labelText: 'Name Room',
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
                    const Spacer(),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 40.0,
                        child: CustomButton(
                          check: controller.isLoadingInsert.value,
                          title: "Add new room",
                          onPressed: () => controller.insertNewRoom(
                            context,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
      ],
    );
  }
}

class ClinicalPatientItem extends StatelessWidget {
  const ClinicalPatientItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '01',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Nguyen Minh Hung',
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat().add_yMEd().format(DateTime.now()),
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
