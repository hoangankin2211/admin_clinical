import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/widgets/examination_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/patient.dart';
import '../../doctor/widgets/medical_exmamindation_item.dart';

// ignore: must_be_immutable
class MedicalExaminationTab extends StatelessWidget {
  const MedicalExaminationTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDecoration.primaryPadding,
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: PatientInformationForm(patient: patient),
                          ),
                          VerticalDivider(
                            color: Colors.blueGrey[400],
                            thickness: 0.3,
                          ),
                          Expanded(
                            child: RecordInformationForm(),
                          ),
                        ],
                      ),
                    ),
                    AppWidget.primaryDivider,
                    const SizedBox(height: 5),
                    Flexible(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.60,
                          child: ExaminationInformationForm(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppWidget.primaryDivider,
            ],
          );
        },
      ),
    );
  }
}
