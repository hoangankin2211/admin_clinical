import 'package:admin_clinical/commons/widgets/custom_icon_button.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/overview/widgets/custom_table.dart';
import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:admin_clinical/features/patient/screens/patient_detail_screen.dart';
import 'package:admin_clinical/features/patient/screens/patient_screen.dart';
import 'package:admin_clinical/features/patient/widgets/edit_patient_dialog.dart';
import 'package:admin_clinical/features/patient/widgets/select_health_record_dialog.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../widgets/add_patient_dialog.dart';
import '../widgets/filter_card.dart';
import '../widgets/show_entries_widget.dart';

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
  ListPatientScreen({super.key, required this.examinationActionHandle});
  final Function(String, {String? healthRecordId}) examinationActionHandle;
  final patientPageController = Get.put(PatientPageController());

  void _onSelectionAction(
      String value, int index, BuildContext context, Patient patient) async {
    if (value == 'Examination') {
      Patient temp = patientPageController.data.value.values.elementAt(index);
      List<HealthRecord> listHealthRecord = [];

      if (temp.healthRecord != null) {
        temp.healthRecord?.forEach((element) {
          if (HealthRecordService.listHealthRecord[element] != null) {
            listHealthRecord
                .add(HealthRecordService.listHealthRecord[element]!);
          }
        });
      }
      Get.dialog(
        SelectRecordDialog(
          records: listHealthRecord,
          onTapRecord: examinationActionHandle,
          patientId: patient.id,
        ),
      );
    } else if (value == 'Detail') {
      Get.dialog(const PatientDetailScreen());
    } else if (value == 'Edit') {
      Get.dialog(
        EditPatientDialog(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.6,
          patient: patient,
        ),
      );
    } else if (value == 'Generate Invoice') {
    } else if (value == 'Delete') {
      patientPageController.isLoading.value = true;
      final result = await PatientService.deletePatient(patient.id, context);
      patientPageController.isLoading.value = false;
      patientPageController.removeEntries(patient.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return patientPageController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Flexible(
                  flex: 10,
                  child: Padding(
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
                                maxEntries:
                                    patientPageController.data.value.length,
                                applyEntries:
                                    patientPageController.applyEntries,
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
                                  borderRadius:
                                      AppDecoration.primaryRadiusBorder,
                                  side: const BorderSide(
                                      color: Colors.grey, width: 0.3),
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
                                itemCount:
                                    patientPageController.numberOfEntries.value,
                                itemBuilder: (context, index) {
                                  Patient tempPatient = patientPageController
                                      .data.value.values
                                      .elementAt(index);
                                  return PatientListRow(
                                    onClick: () => patientPageController
                                        .selectedPatient.value = tempPatient.id,
                                    onSelectedAction: (value) {
                                      _onSelectionAction(
                                          value, index, context, tempPatient);
                                    },
                                    removeEntries:
                                        patientPageController.removeEntries,
                                    name: tempPatient.name,
                                    id: tempPatient.id,
                                    date: tempPatient.dob,
                                    gender: tempPatient.gender,
                                    diseases: tempPatient.name,
                                    status: tempPatient.status,
                                    payment: '100000',
                                    avt: tempPatient.avt,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Obx(
                    () => PatientProfileCard(
                        patient:
                            patientPageController.selectedPatient.value != null
                                ? patientPageController.data.value[
                                    patientPageController.selectedPatient.value]
                                : null),
                  ),
                ),
              ],
            );
    });
  }
}

class PatientProfileCard extends StatelessWidget {
  const PatientProfileCard({super.key, required this.patient});
  final Patient? patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      // margin: const EdgeInsets.only(left: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.2),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[100],
                backgroundImage: (patient != null &&
                        patient!.avt != null &&
                        patient!.avt!.isNotEmpty)
                    ? NetworkImage(
                        patient!.avt!,
                      ) as ImageProvider
                    : const AssetImage('images/user.png'),
                radius: 80,
              ),
              if (patient != null)
                InkWell(
                  onTap: () {
                    print(patient!.id);
                    Get.dialog(
                      EditPatientDialog(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.6,
                        patient: patient!,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primaryColor),
                    child: const Icon(
                      Icons.mode_edit_outline_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            patient == null ? " " : patient!.name,
            style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.w700,
                fontSize: 22.0),
          ),
          const SizedBox(height: 5.0),
          Text(
            patient == null ? " " : "22 Years, ${patient!.gender}",
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          const Divider(thickness: 0.6),
          const SizedBox(height: 20.0),
          ProfileRow(
            mainTitle: "Email",
            title: patient == null ? " " : patient!.email ?? 'hcmus@gmail.com',
          ),
          const SizedBox(height: 25.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProfileRow(
                mainTitle: "Phone",
                title: patient == null ? ' ' : patient!.phoneNumber,
              ),
              ProfileRow(
                mainTitle: "Status",
                title: patient == null ? ' ' : patient!.status,
              ),
            ],
          ),
          const SizedBox(height: 25.0),
          ProfileRow(
            mainTitle: "Date of Birth",
            title: patient == null ? ' ' : patient!.dob,
          ),
          const SizedBox(height: 25.0),
          const SizedBox(height: 20.0),
          const Divider(thickness: 0.6),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ContainerProcess(
                  mainTitle: "Blood Pessure",
                  total: 900,
                  data: 400,
                  color: Colors.red,
                  backgroundColor: Colors.red.withOpacity(0.2),
                  des: "141/90 mmhg",
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ContainerProcess(
                  mainTitle: "Body Temperature",
                  total: 500,
                  data: 400,
                  color: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.2),
                  des: "29'C",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: ContainerProcess(
                  mainTitle: "Body Height",
                  total: 1000,
                  data: 300,
                  color: Colors.orange,
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  des: "5.6\"inc",
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ContainerProcess(
                  mainTitle: "Body Weight",
                  total: 1000,
                  data: 400,
                  color: Colors.blue,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  des: "78Kg",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
