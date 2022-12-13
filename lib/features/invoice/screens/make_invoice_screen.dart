import 'package:admin_clinical/features/form/controller/medical_form_controller.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/widgets/service_detail_widget.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_decoration.dart';
import '../../../models/patient.dart';
import '../widgets/invoice_widget.dart';

// ignore: must_be_immutable
class MakeInvoiceScreen extends StatelessWidget {
  MakeInvoiceScreen({super.key});

  final invoiceController = Get.find<InvoiceController>();
  static const tagBuilder = 'MakeInvoiceScreen';

  @override
  Widget build(BuildContext context) {
    Patient temp = PatientService.listPatients[
            invoiceController.selectedHealthRecord.value!.patientId] ??
        Patient(
          id: 'Null',
          name: 'Null',
          gender: 'Null',
          address: 'Null',
          dob: 'Null',
          phoneNumber: 'Null',
          status: 'Null',
        );
    return Container(
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: GetBuilder<MedicalFormController>(
                init: MedicalFormController(),
                tag: tagBuilder,
                builder: (medicalFormController) {
                  medicalFormController.currentHealthRecord.value =
                      invoiceController.selectedHealthRecord.value;
                  medicalFormController.fetchIndicatorData();
                  return Row(
                    children: [
                      Flexible(
                        flex: 7,
                        child: InvoiceWidget(patient: temp),
                      ),
                      Flexible(
                        flex: 10,
                        child: FormCard(
                          child: ServiceDetailWidget(
                            patient: temp,
                          ),
                        ),
                      )
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
