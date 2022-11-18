import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:admin_clinical/features/form/widgets/record_information_form.dart';
import 'package:admin_clinical/features/form/widgets/service_indication_widgets/service_indication_form.dart';
import 'package:flutter/material.dart';
import '../widgets/service_indication_widgets/result_indication.dart';

class ServiceIndicationDialog extends StatelessWidget {
  const ServiceIndicationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: AppDecoration.primaryRadiusBorder,
              side: const BorderSide(
                color: Colors.blueGrey,
                width: 0.3,
              ),
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
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: AppDecoration.primaryPadding,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.3,
                              ),
                              borderRadius: AppDecoration.primaryRadiusBorder,
                              boxShadow: AppDecoration.elevationContainer,
                            ),
                            child: Column(
                              children: [
                                Flexible(child: PatientInformationForm()),
                                AppWidget.primaryDivider,
                                const SizedBox(height: 10),
                                Flexible(child: RecordInformationForm()),
                              ],
                            ),
                          ),
                        ),
                        Flexible(flex: 3, child: ServiceIndicationForm())
                      ],
                    ),
                  ),
                  Flexible(child: ResultIndication()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
