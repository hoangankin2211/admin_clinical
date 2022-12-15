import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/utils.dart';
import '../../../models/health_record.dart';
import '../../../models/medicine.dart';
import '../../../models/patient.dart';
import '../../../models/service.dart';
import '../../../services/data_service/medicine_service.dart';
import '../../../services/data_service/service_data_service.dart';
import '../../form/widgets/examination_information_form.dart';
import '../../form/widgets/form_card.dart';
import '../../form/widgets/medicine_indication_widgets/medicine_search_form.dart';
import '../../form/widgets/patient_information_form.dart';
import '../../overview/widgets/custom_table.dart';

class HealthRecordDetail extends StatelessWidget {
  const HealthRecordDetail(
      {super.key, required this.patient, required this.healthRecord});
  final Patient patient;
  final HealthRecord healthRecord;
  @override
  Widget build(BuildContext context) {
    List<Medicine> medicines = [
      if (healthRecord.medicines != null)
        for (var element in healthRecord.medicines!)
          if (MedicineService.instance
                  .getMedicine(element['medicine'] as String) !=
              null)
            MedicineService.instance.getMedicine(element['medicine'] as String)!
    ];

    List<Service> services = [
      if (healthRecord.services != null)
        for (var element in healthRecord.services!)
          if (ServiceDataService
                  .instance.service[element['medicine'] as String] !=
              null)
            ServiceDataService.instance.service[element['medicine'] as String]!
    ];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Flexible(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: FormCard(
                      child: PatientInformationForm(patient: patient),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RecordInformationForm(
                      dateCreate: DateFormat()
                          .add_yMMMd()
                          .format(healthRecord.dateCreate),
                      department: healthRecord.departmentId,
                      doctorInCharge: healthRecord.doctorId,
                      id: healthRecord.id,
                      note: healthRecord.note,
                      status: healthRecord.status,
                      totalMoney: healthRecord.totalMoney,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: FormCard(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.6,
                          child: ExaminationInformationForm(
                            isReading: true,
                            examField: Utils.examField,
                            measureField: Utils.measureField,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 10,
              child: Flexible(
                flex: 10,
                child: FormCard(
                  child: ServiceMedicineDetail(
                    patientName: patient.name,
                    avt: patient.avt,
                    medicine: medicines,
                    services: services,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ServiceMedicineDetail extends StatelessWidget {
  const ServiceMedicineDetail({
    super.key,
    required this.avt,
    required this.patientName,
    required this.medicine,
    required this.services,
  });
  final String? avt;
  final String patientName;
  final List<Medicine> medicine;
  final List<Service> services;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FormCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage: (avt != null && avt!.isNotEmpty)
                          ? NetworkImage(
                              avt!,
                            ) as ImageProvider
                          : const AssetImage('images/user.png'),
                      radius: 25,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      patientName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FormCard(
                child: Column(
                  children: [
                    const MedicineSearchFormRow(
                      customRow: [
                        {'flex': 2, 'text': 'ID'},
                        {'flex': 1, 'text': 'Name'},
                        {'flex': 1, 'text': 'Department ID'},
                        {'flex': 1, 'text': 'Price'},
                        {'flex': 1, 'text': 'Description'},
                      ],
                      width: 48,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ResultServiceTableRow(
                            color: Colors.white,
                            service: services.elementAt(index),
                          );
                        },
                        itemCount: services.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FormCard(
                child: Column(
                  children: [
                    const MedicineSearchFormRow(
                      customRow: [
                        {'flex': 2, 'text': 'ID'},
                        {'flex': 1, 'text': 'Name'},
                        {'flex': 1, 'text': 'Unit'},
                        {'flex': 1, 'text': 'Price Per Unit'},
                        {'flex': 1, 'text': 'Amount'},
                        {'flex': 1, 'text': 'Type'},
                        {'flex': 1, 'text': 'Description'},
                      ],
                      width: 48,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ResultMedicineTableRow(
                          amount: 0,
                          medicine: medicine.elementAt(index),
                          color: Colors.white,
                        );
                      },
                      itemCount: medicine.length,
                    )),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
