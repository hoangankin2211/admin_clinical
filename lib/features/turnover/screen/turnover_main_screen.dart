import 'package:admin_clinical/features/patient/widgets/show_entries_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../patient/controller/patient_page_controller.dart';

class TurnoverMainScreen extends StatelessWidget {
  TurnoverMainScreen({super.key});
  final patientPageController = Get.put(PatientPageController());

  List<Map<String, dynamic>> listFilter = [
    {
      "icon": Icons.person_add_alt_outlined,
      "title": "Select User",
      "onTap": () {},
    },
    {
      "icon": Icons.date_range,
      "title": "Select Date",
      "onTap": () {},
    },
    {
      "icon": Icons.book,
      "title": "Select Status",
      "onTap": () {},
    },
    {
      "icon": FontAwesome.save,
      "title": "By category",
      "onTap": () {},
    },
  ];

  List<Map<String, dynamic>> listInvoices = [
    {
      "icon": Icons.file_copy_outlined,
      "title": "All Invoices",
      "data": 878797,
      "data1": 50,
    },
    {
      "icon": Icons.folder_copy_outlined,
      "title": "Paid Invoices",
      "data": 45884,
      "data1": 60,
    },
    {
      "icon": Icons.paid_outlined,
      "title": "All Invoices",
      "data": 878797,
      "data1": 70,
    },
    {
      "icon": Icons.security_outlined,
      "title": "Cancelled Invoices",
      "data": 88797,
      "data1": 80,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.primaryColor,
                  ),
                  child: const Icon(
                    FontAwesome.file,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  " Invoke",
                  style: TextStyle(
                    color: AppColors.primarySecondColor,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.list,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(width: 10.0),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.grid_view_outlined,
                    color: AppColors.headline1TextColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          _listFilterField(),
          const SizedBox(height: 20.0),
          _invoiceStatusField(),
          const SizedBox(height: 20.0),
          _invoiceListField(),
          const SizedBox(height: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowEntriesWidget(
                    applyEntries: patientPageController.applyEntries,
                    numberOfEntries:
                        patientPageController.numberOfEntries.value - 1,
                    width: constraints.maxWidth * 0.03,
                    height: constraints.maxHeight * 0.05,
                    maxEntries: patientPageController.data.value.length - 1,
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          width: 0.4,
                          color: Colors.grey,
                        ),
                      ),
                      child: Column(
                        children: [],
                      ),
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

  Row _invoiceListField() {
    return Row(
      children: [
        ...listInvoices.map(
          (e) => Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.3),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(e['icon'],
                          color: AppColors.primarySecondColor.withOpacity(0.6),
                          size: 30.0),
                      Text(
                        "\$ ${e["data"]}",
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${e["title"]}  ${e["data1"]}",
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Padding _invoiceStatusField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          const Text(
            "All Invoice",
            style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 20.0),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.settings_outlined,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 10.0),
          ButtonMouseRegion(
            color: AppColors.primaryColor,
            colorChange: Colors.yellow,
            child: Row(
              children: const [
                Icon(
                  Icons.add_circle_outline_sharp,
                  color: Colors.white,
                ),
                Text(
                  ' New Invoice',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            func: () {},
          ),
        ],
      ),
    );
  }

  Container _listFilterField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: [
          ...listFilter.map(
            (e) => Expanded(
              child: InkWell(
                onTap: () => e["onTap"],
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        e["icon"],
                        color: AppColors.primaryColor,
                        size: 20.0,
                      ),
                      Text(
                        ' ${e["title"]}',
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  width: 0.2,
                  color: AppColors.primaryColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.show_chart,
                    color: AppColors.primaryColor,
                    size: 20.0,
                  ),
                  Text(
                    ' Generate Report',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
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
}

class ButtonMouseRegion extends StatelessWidget {
  final Color color;
  final Color colorChange;
  final Widget child;
  final Function() func;
  ButtonMouseRegion(
      {super.key,
      required this.color,
      required this.colorChange,
      required this.child,
      required this.func});
  RxBool onIt = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) => onIt.value = true,
      onExit: (value) => onIt.value = false,
      child: Obx(
        () => InkWell(
          onTap: () {},
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 100),
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: onIt.value ? colorChange : color,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
