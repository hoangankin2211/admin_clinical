import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/service_indication_widgets/service_indication_form.dart';
import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import '../widgets/service_indication_widgets/result_indication.dart';

class ServiceIndicationDialog extends StatelessWidget {
  const ServiceIndicationDialog({super.key, required this.patient});
  final Patient patient;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppDecoration.primaryRadiusBorder,
              side: AppDecoration.primarySecondBorder,
            ),
            child: Container(
              decoration: AppDecoration.primaryDecorationContainer,
              child: Column(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: FormCard(
                            child: Column(
                              children: [
                                Flexible(
                                    child: PatientInformationForm(
                                  patient: patient,
                                )),
                                AppWidget.primaryDivider,
                                const SizedBox(height: 10),
                                Flexible(child: RecordInformationForm()),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 3,
                            child: FormCard(child: ServiceIndicationForm()))
                      ],
                    ),
                  ),
                  Flexible(
                    child: FormCard(
                      child: ResultIndication(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
