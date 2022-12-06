import 'package:admin_clinical/models/medicine.dart';
import 'package:flutter/material.dart';

import '../../../models/invoice.dart';
import '../../form/widgets/patient_information_form.dart';

class InvoiceForm extends StatelessWidget {
  InvoiceForm({super.key});

  // final Invoice fakeInvoice = Invoice(
  //   realPay: 1100000,
  //   patientId: '123',
  //   id: '234',
  //   amount: 1000000,
  //   createDate: '18/11/2022',
  //   discount: 0.2,
  //   services: null,
  //   medicine: null,
  // );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Invoice Information',
        //   style: Theme.of(context)
        //       .textTheme
        //       .headline5!
        //       .copyWith(color: Colors.red[400]),
        // ),
        // const SizedBox(height: 3),
        // Flexible(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Expanded(
        //           child: DisplayInformationWidget(
        //               label: 'ID', content: fakeInvoice.id)),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //             label: 'Patient ID', content: fakeInvoice.patientId),
        //       ),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //             label: 'Create Date', content: fakeInvoice.createDate),
        //       ),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //             label: 'Number of Services',
        //             content: fakeInvoice.services.toString()),
        //       ),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //             label: 'Number of Type Medicine',
        //             content: fakeInvoice.medicine.toString()),
        //       ),
        //       const SizedBox(width: 5),
        //     ],
        //   ),
        // ),
        // Flexible(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Expanded(
        //         child: DisplayInformationWidget(
        //           label: 'Amount',
        //           content: fakeInvoice.amount.toString(),
        //         ),
        //       ),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //           label: 'Discount',
        //           content: fakeInvoice.discount.toString(),
        //         ),
        //       ),
        //       const SizedBox(width: 5),
        //       Expanded(
        //         child: DisplayInformationWidget(
        //           label: 'Real Pay',
        //           content: fakeInvoice.realPay.toString(),
        //         ),
        //       ),
        //       const SizedBox(width: 5),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
