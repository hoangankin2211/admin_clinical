import 'dart:io';

import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:admin_clinical/features/invoice/widgets/invoice_form.dart';
import 'package:flutter/material.dart';

import '../../form/widgets/examination_information_form.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flexible(
            //   child: FormCard(child: PatientInformationForm()),
            // ),
            Flexible(
              child: FormCard(child: InvoiceForm()),
            ),
            Flexible(
              flex: 2,
              child: FormCard(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: ExaminationInformationForm(),
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
