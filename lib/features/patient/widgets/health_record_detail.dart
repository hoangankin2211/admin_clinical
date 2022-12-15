import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/service_indication_widgets/result_indication.dart';
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
  const HealthRecordDetail({
    super.key,
    required this.patient,
    required this.healthRecord,
  });
  final Patient patient;
  final HealthRecord healthRecord;

  Future<Map<String, dynamic>> fetchDataToList() async {
    Map<String, dynamic> result = {};

    await Future(
      () {
        List<Medicine> medicines = [
          if (healthRecord.medicines != null)
            for (var element in healthRecord.medicines!)
              if (MedicineService.instance
                      .getMedicine(element['medicine'] as String) !=
                  null)
                MedicineService.instance
                    .getMedicine(element['medicine'] as String)!
        ];

        List<Service> services = [
          if (healthRecord.services != null)
            for (var element in healthRecord.services!)
              if (ServiceDataService
                      .instance.service[element['service'] as String] !=
                  null)
                ServiceDataService
                    .instance.service[element['service'] as String]!
        ];

        result.addAll({"medicines": medicines, "services": services});
      },
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: fetchDataToList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map<String, dynamic> data = snapshot.data ??
                      {
                        "medicine": [] as List<Medicine>,
                        'services': [] as List<Service>
                      };
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
                              child: FormCard(
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
                            ),
                            Flexible(
                              flex: 2,
                              child: FormCard(
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    height: constraints.maxHeight * 0.6,
                                    child: ExaminationInformationForm(
                                      healthRecordData: {
                                        'clinicalExamination':
                                            healthRecord.clinicalExamination,
                                        'symptom': healthRecord.symptom,
                                        'diagnostic': healthRecord.diagnostic,
                                        'conclusionAndTreatment':
                                            healthRecord.conclusionAndTreatment,
                                        'weight': healthRecord.weight,
                                        'heartBeat': healthRecord.heartBeat,
                                        'height': healthRecord.heartBeat,
                                        'temperature': healthRecord.temperature,
                                        'bloodPressure':
                                            healthRecord.bloodPressure,
                                        'allergy': healthRecord.allergy,
                                        'note': healthRecord.note,
                                      },
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
                        child: FormCard(
                          child: ServiceMedicineDetail(
                            patientName: patient.name,
                            avt: patient.avt,
                            medicine: data['medicines'],
                            services: data['services'],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
              return const Center(child: CircularProgressIndicator());
            });
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
                  child: ResultServiceIndicationView(services: services)),
            ),
            Expanded(
              child: FormCard(
                  child: ResultMedicineIndicationView(medicine: medicine)),
            ),
          ],
        );
      },
    );
  }
}

class ResultMedicineIndicationView extends StatelessWidget {
  const ResultMedicineIndicationView({super.key, required this.medicine});

  final List<Medicine> medicine;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class ResultServiceIndicationView extends StatelessWidget {
  const ResultServiceIndicationView({super.key, required this.services});

  final List<Service> services;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              return ResultServiceTableRow(
                color: Colors.white,
                service: services.elementAt(index),
              );
            },
            itemCount: services.length,
          ),
        ),
      ],
    );
  }
}
