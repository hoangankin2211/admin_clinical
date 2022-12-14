import 'dart:typed_data';

import 'package:admin_clinical/constants/fake_data.dart';
import 'package:admin_clinical/constants/global_widgets/list_item.dart';
import 'package:admin_clinical/constants/global_widgets/rangeDate_picker_dialog.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/medicine/controller/medicine_controller.dart';
import 'package:admin_clinical/features/medicine/widgets/change_no_data_field.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/chart/column_2_chart.dart';
import '../../../constants/global_widgets/chart/line_chart_design.dart';
import '../../../constants/utils.dart';
import '../../../models/medicine.dart';
import '../widgets/dialog_add_medicine.dart';
import '../widgets/dialog_update_amount_medicine.dart';
import '../widgets/header_list_medicine.dart';
import '../widgets/input_with_header_text.dart';
import '../widgets/list_medicine_item.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});
  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final controller = Get.find<MedicineController>();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _overviewMedicineView(),
                      const SizedBox(height: 10.0),
                      const Divider(thickness: 1),
                      const SizedBox(height: 10.0),
                      _listMedicineView(),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                _rightField(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _rightField() {
    return Obx(() => Expanded(
          flex: 3,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.headline1TextColor.withOpacity(0.2),
                      blurRadius: 10.0,
                    )
                  ],
                ),
                child: (controller.listMedicine.isEmpty)
                    ? const Center(
                        child: Text(
                          "NULL",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Medicine View",
                                style: TextStyle(
                                  color: AppColors.primarySecondColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              InkWell(
                                onTap: () => Get.dialog(
                                  DialogPickRangeDate(
                                    controller: controller.dateController1Line,
                                    callback: () {
                                      controller.dateController1Line
                                          .selectDateDoneClick();
                                      controller.fetchData1LineChart(controller
                                          .listMedicine[
                                              controller.selectMedcine.value]
                                          .id);
                                      Get.back();
                                    },
                                  ),
                                ),
                                child: Row(children: const [
                                  Text("Selecct Week ",
                                      style: TextStyle(
                                          color: AppColors.primarySecondColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0)),
                                  Icon(Icons.arrow_drop_down,
                                      color: AppColors.primarySecondColor),
                                ]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Obx(
                            () => Container(
                              height: 210,
                              width: double.infinity,
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: AppColors.backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.headline1TextColor
                                        .withOpacity(0.2),
                                    blurRadius: 4.0,
                                  )
                                ],
                              ),
                              child: LineChartDesign(
                                  maxTitle: controller.maxOflistChart2.value
                                      .toString(),
                                  middleTitle:
                                      (controller.maxOflistChart2.value / 2)
                                          .round()
                                          .toString(),
                                  listData: [
                                    ...controller.listDataChart2.map(
                                      (element) => FlSpot(
                                        element['id'],
                                        // ignore: unrelated_type_equality_checks
                                        controller.maxOflistChart2 != 0
                                            ? (element['price'] /
                                                    controller.maxOflistChart2
                                                        .value) *
                                                5
                                            : 0,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: _image == null
                                    ? Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors
                                                    .headline1TextColor
                                                    .withOpacity(0.2),
                                                blurRadius: 10.0),
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              controller
                                                  .listMedicine[controller
                                                      .selectMedcine.value]
                                                  .thumbnails,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors
                                                    .headline1TextColor
                                                    .withOpacity(0.2),
                                                blurRadius: 10.0),
                                          ],
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(_image!),
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                          .listMedicine[
                                              controller.selectMedcine.value]
                                          .name,
                                      style: const TextStyle(
                                        color: AppColors.primarySecondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      controller
                                          .listMedicine[
                                              controller.selectMedcine.value]
                                          .type,
                                      style: const TextStyle(
                                        color: AppColors.primarySecondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "Price: \$${controller.listMedicine[controller.selectMedcine.value].price}",
                                      style: const TextStyle(
                                        color: AppColors.primarySecondColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AuthService.instance.user.type == "Admin"
                                  ? InkWell(
                                      onTap: () => selectedImage(),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.blue.withOpacity(0.7),
                                        ),
                                        child: Row(children: const [
                                          Icon(Icons.camera,
                                              color: Colors.white),
                                          Text(
                                            " Edit Thumbnails",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(thickness: 1),
                          const SizedBox(height: 10.0),
                          MedicineFormWidget(
                            name: controller.rxnameController.value,
                            price: controller.rxpriceController.value,
                            listType: controller.listType,
                            selectTypeEdit: controller.selectTypeEdit.value,
                            description: controller.descriptionController,
                            isLoadingEdit: controller.isLoadingEdit.value,
                            editMedicine: controller.editMedicine,
                            onChanged: (value) =>
                                controller.selectTypeEdit.value = value ?? 0,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ));
  }

  Expanded _listMedicineView() {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Medicines",
                style: TextStyle(
                  color: AppColors.primarySecondColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const Spacer(),
              AuthService.instance.user.type == "Admin"
                  ? SizedBox(
                      height: 40,
                      child: CustomButton(
                        title: "Add new Medicine",
                        onPressed: () async {
                          controller.fetchAllListType();
                          await Get.dialog(
                            DialogAddNewMedicine(),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(height: 20),
          const HeaderListMedicine(),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView(
                children: [
                  for (int i = 0; i < controller.listMedicine.value.length; i++)
                    InkWell(
                      onTap: () {
                        _image = null;
                        controller.funcselectMedincine(i);
                      },
                      child: ListMedicineItem(
                        delete: () {
                          bool isDelete = false;
                          showDialog(
                            context: Get.context!,
                            builder: (context) {
                              return AlertDialog(
                                alignment: Alignment.center,
                                title: const Text('Are you sure ?'),
                                content: const Text(
                                    'Do you want to remove the doctor from the list ? '),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      isDelete = true;
                                      controller.deleteMedicine(context,
                                          controller.listMedicine.value[i].id);
                                    },
                                    child: const Text('YES'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      isDelete = false;
                                      Get.back();
                                    },
                                    child: const Text('NO'),
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            return isDelete;
                          });
                        },
                        e: controller.listMedicine.value[i],
                        select: () async {
                          await Get.dialog(
                            DialogUpdateAmountMedicine(
                                controller: controller, i: i),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _overviewMedicineView() {
    return Expanded(
      flex: 3,
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Overview",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            InkWell(
              onTap: () => Get.dialog(
                DialogPickRangeDate(
                  controller: controller.dateController2Column,
                  callback: () {
                    controller.dateController2Column.selectDateDoneClick();
                    controller.fetchData2ColumnChart();
                    Get.back();
                  },
                ),
              ),
              child: Row(children: const [
                Text("Last Week ",
                    style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                Icon(Icons.arrow_drop_down,
                    color: AppColors.primarySecondColor),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _numberDrugField(), //
                    const SizedBox(height: 10.0),
                    _remainingMedcineField(),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Obx(
                () => Expanded(
                  flex: 6,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.headline1TextColor.withOpacity(0.3),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ColumnChartTwoColumnCustom(
                      barGroups: [
                        ...controller.listDataChart1.map((e) => makeGroupData(
                              e['id'],
                              controller.maxOfList2ColumnChart == 0
                                  ? 0
                                  : e['remain'] /
                                      controller.maxOfList2ColumnChart.value *
                                      20,
                              controller.maxOfList2ColumnChart == 0
                                  ? 0
                                  : e['sold'] /
                                      controller.maxOfList2ColumnChart.value *
                                      20,
                            )),
                      ],
                      members: const [
                        'Sun',
                        'Mon',
                        'Tue',
                        'Wed',
                        'Thu',
                        'Fri',
                        'Sat'
                      ],
                      columnData: controller.maxOfList2ColumnChart.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _remainingMedcineField() {
    return Obx(() => Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(FontAwesome.medkit, color: AppColors.primaryColor),
                    Expanded(
                      child: Text(
                        " Remaining medicine",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        children: [
                          const TextSpan(
                            text: "Amount: ",
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                            ),
                          ),
                          TextSpan(
                            text: "${controller.remainAmount} ",
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        children: [
                          const TextSpan(
                            text: "Price: ",
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                            ),
                          ),
                          TextSpan(
                            text: "\$${controller.priceRemain} ",
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _numberDrugField() {
    return Obx(() => Expanded(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(FontAwesome.medkit, color: Colors.red),
                    Expanded(
                      child: Text(
                        " Number of drugs sold",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        children: [
                          const TextSpan(
                            text: "Amount: ",
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                            ),
                          ),
                          TextSpan(
                            text: "${controller.noSoldAmount.value} ",
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                        children: [
                          const TextSpan(
                            text: "Price: ",
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                            ),
                          ),
                          TextSpan(
                            text: "\$${controller.priceSold.value} ",
                            style: const TextStyle(
                              color: AppColors.primarySecondColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class MedicineFormWidget extends StatelessWidget {
  const MedicineFormWidget(
      {super.key,
      this.image,
      required this.name,
      required this.price,
      required this.listType,
      required this.selectTypeEdit,
      required this.description,
      required this.isLoadingEdit,
      required this.editMedicine,
      required this.onChanged});
  final TextEditingController name;
  final TextEditingController price;
  final TextEditingController description;
  final bool isLoadingEdit;
  final int selectTypeEdit;
  final Function(int?) onChanged;
  final Function(BuildContext context, Uint8List? image) editMedicine;
  final List<String> listType;
  final Uint8List? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputWithHeaderText(
          header: "Medicine Name",
          hint: "Enter Medicine Name",
          controller: name,
        ),
        const SizedBox(height: 10.0),
        InputWithHeaderText(
          header: "Medicine Price",
          hint: "Enter Medicine Price",
          controller: price,
        ),
        const SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select type of Medecine",
              style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 5.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 1.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: AppDecoration.primaryBorder,
                borderRadius: AppDecoration.primaryRadiusBorder,
              ),
              child: Obx(
                () => DropdownButton<int>(
                  underline: const SizedBox(),
                  items: listType
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ))
                      .toList(),
                  value: selectTypeEdit,
                  onChanged: onChanged,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        InputWithHeaderText(
          header: "Description",
          hint: "Enter description",
          maxLines: 4,
          controller: description,
        ),
        const SizedBox(height: 20.0),
        AuthService.instance.user.type == "Admin"
            ? SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  check: isLoadingEdit,
                  title: "Edit Medicine",
                  onPressed: () => editMedicine(context, image),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      toY: y1,
      color: AppColors.primaryColor.withOpacity(0.7),
      width: 7,
    ),
    BarChartRodData(
      toY: y2,
      color: Colors.red,
      width: 7,
    ),
  ]);
}
