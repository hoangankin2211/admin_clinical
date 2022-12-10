import 'package:admin_clinical/constants/utils.dart';
import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/invoice/widgets/invoice_form.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../form/widgets/examination_information_form.dart';
import '../../form/widgets/patient_information_form.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key});

  static const getBuilderId = 'InvoiceWidget';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalFormController>(
        assignId: true,
        id: getBuilderId,
        builder: (medicalFormController) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: FormCard(
                      child: PatientInformationForm(
                        patient: Patient(
                          address: "",
                          dob: "",
                          gender: "",
                          id: "",
                          name: "",
                          phoneNumber: "",
                          status: "",
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FormCard(child: InvoiceForm()),
                  ),
                  Flexible(
                    flex: 2,
                    child: FormCard(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: constraints.maxHeight * 0.6,
                          child: ExaminationInformationForm(
                            examField: Utils.examField,
                            formKey: medicalFormController.formKey,
                            measureField: Utils.measureField,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
