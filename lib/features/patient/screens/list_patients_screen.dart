import 'package:admin_clinical/commons/widgets/custom_icon_button.dart';
import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/add_patient_dialog.dart';
import '../widgets/filter_card.dart';
import '../widgets/show_entries_widget.dart';

class ListPatientScreen extends StatelessWidget {
  ListPatientScreen({super.key});

  final patientPageController = Get.put(PatientPageController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patient List',
                  style: Theme.of(context).textTheme.headline2,
                ),
                CustomIconButton(
                  onPressed: () => Get.dialog(
                    AddPatientDialog(
                      height: constraints.maxHeight * 0.8,
                      width: constraints.maxWidth * 0.45,
                    ),
                  ),
                  label: const Text(
                    'Add Patient',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  icon: const Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => ShowEntriesWidget(
                    applyEntries: patientPageController.applyEntries,
                    numberOfEntries:
                        patientPageController.numberOfEntries.value - 1,
                    width: constraints.maxWidth * 0.03,
                    height: constraints.maxHeight * 0.05,
                    maxEntries: patientPageController.data.value.length - 1,
                  ),
                ),
                CustomIconButton(
                  onPressed: () {},
                  label: Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.blueGrey,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDecoration.primaryRadiusBorder,
                      side: const BorderSide(color: Colors.grey, width: 0.3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Expanded(
                  child: FilterCategory(
                    title: 'Patient',
                    hint: 'Patient name, Patient id, etc',
                    iconData: Icons.search_outlined,
                  ),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  child: FilterCategory(
                    title: 'Category',
                    hint: 'All Category',
                    iconData: Icons.category_outlined,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FilterCategory(
                    title: 'Date of Joining',
                    hint: DateFormat()
                        .add_yMd()
                        .format(DateTime.now())
                        .toString(),
                    iconData: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: patientPageController.numberOfEntries.value * 60,
              child: Obx(
                () => ListView.builder(
                  itemExtent: 60,
                  itemCount: patientPageController.numberOfEntries.value,
                  itemBuilder: (context, index) => PatientListRow(
                    index: index,
                    removeEntries: patientPageController.removeEntries,
                    name: patientPageController.data.value[index]['name']!,
                    id: patientPageController.data.value[index]['id']!,
                    date: patientPageController.data.value[index]['date']!,
                    gender: patientPageController.data.value[index]['gender']!,
                    diseases: patientPageController.data.value[index]
                        ['diseases']!,
                    status: patientPageController.data.value[index]['status']!,
                    payment: patientPageController.data.value[index]
                        ['payment']!,
                    avt: 'images/fake_avatar.jpg',
                    color: index == 0 ? Colors.blueGrey[50]! : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
