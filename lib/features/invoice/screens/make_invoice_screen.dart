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

  @override
  Widget build(BuildContext context) {
    Patient temp = PatientService
        .listPatients[invoiceController.selectedHealthRecord.value!.patientId]!;
    return Container(
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              children: [
                Flexible(
                  child: InvoiceWidget(patient: temp),
                ),
                Flexible(
                  child: FormCard(
                      child: ServiceDetailWidget(
                    patientName: temp.name,
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
