import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/utils.dart';
import '../../form/widgets/examination_information_form.dart';
import '../../form/widgets/patient_information_form.dart';
import 'invoice_form.dart';

class InvoiceWidget extends StatelessWidget {
  InvoiceWidget({super.key, required this.patient});
  final Patient patient;

  static const getBuilderId = 'InvoiceWidget';
  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicalFormController>(
        assignId: true,
        id: getBuilderId,
        init: MedicalFormController(),
        builder: (medicalFormController) {
          medicalFormController.currentHealthRecord.value =
              invoiceController.selectedHealthRecord.value;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: FormCard(
                      child: PatientInformationForm(patient: patient),
                    ),
                  ),
                  Flexible(
                    child: FormCard(
                      child: InvoiceForm(
                        invoice: invoiceController.selectedInvoice.value!,
                        patientId: patient.id,
                        numberOfService: invoiceController
                            .selectedHealthRecord.value!.services!.length,
                        numberOfMedicine: invoiceController
                            .selectedHealthRecord.value!.medicines!.length,
                        totalMoney: invoiceController
                            .selectedHealthRecord.value!.totalMoney,
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
                            textController:
                                medicalFormController.textController,
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
