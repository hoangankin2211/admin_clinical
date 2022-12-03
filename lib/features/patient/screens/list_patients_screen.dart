import 'package:admin_clinical/commons/widgets/custom_icon_button.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/add_patient_dialog.dart';
import '../widgets/filter_card.dart';
import '../widgets/show_entries_widget.dart';
import 'package:http/http.dart' as http;

const Map<String, String> patientListField = {
  'name': 'Patient Name',
  'id': 'Id',
  'date': 'Date',
  'gender': 'Gender',
  'diseases': 'Diseases',
  'status': 'Status',
  'payment': 'Payment',
};

class ListPatientScreen extends StatelessWidget {
  ListPatientScreen({super.key});

  final patientPageController = Get.put(PatientPageController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => ShowEntriesWidget(
                    maxEntries: patientPageController.data.value.length,
                    applyEntries: patientPageController.applyEntries,
                    numberOfEntries:
                        patientPageController.numberOfEntries.value,
                    width: constraints.maxWidth * 0.03,
                    height: constraints.maxHeight * 0.05,
                  ),
                ),
                CustomIconButton(
                  onPressed: () async {
                    await PatientService.fetchAllPatientData();
                  },
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
            const SizedBox(height: 20),
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
            PatientListRow(
              name: patientListField['name']!,
              id: patientListField['id']!,
              date: patientListField['date']!,
              gender: patientListField['gender']!,
              diseases: patientListField['diseases']!,
              status: patientListField['status']!,
              color: Colors.blueGrey[50]!,
              avt: 'images/fake_avatar.jpg',
              payment: patientListField['payment']!,
            ),
            Expanded(
              child: GetBuilder<PatientPageController>(
                id: 'list_patients_screen',
                assignId: true,
                autoRemove: false,
                builder: (controller) => Obx(
                  () => ListView.builder(
                    itemExtent: 60,
                    itemCount: patientPageController.numberOfEntries.value,
                    itemBuilder: (context, index) => PatientListRow(
                      removeEntries: patientPageController.removeEntries,
                      name: patientPageController.data.value.values
                          .elementAt(index)
                          .name,
                      id: patientPageController.data.value.values
                          .elementAt(index)
                          .id,
                      date: patientPageController.data.value.values
                          .elementAt(index)
                          .dob,
                      gender: patientPageController.data.value.values
                          .elementAt(index)
                          .gender,
                      diseases: patientPageController.data.value.values
                          .elementAt(index)
                          .name,
                      status: patientPageController.data.value.values
                          .elementAt(index)
                          .status,
                      payment: '100000',
                      avt: patientPageController.data.value.values
                          .elementAt(index)
                          .avt,
                      color: Colors.white,
                    ),
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
