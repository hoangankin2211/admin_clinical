import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/material.dart';

class RecordInformationForm extends StatelessWidget {
  const RecordInformationForm({
    super.key,
    this.id,
    this.dateCreate,
    this.doctorInCharge,
    this.totalMoney,
    this.note,
    this.status,
    this.department,
  });
  final String? id;
  final String? dateCreate;
  final String? doctorInCharge;
  final double? totalMoney;
  final String? note;
  final String? status;
  final String? department;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Record Information',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.red[400]),
        ),
        const SizedBox(height: 3),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Record ID',
                  content: id ?? "Null",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Date Create',
                  content: dateCreate ?? "Null",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Status',
                  content: status ?? "Null",
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Department',
                  content: department ?? "Null",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Doctor in Charge',
                  content: doctorInCharge ?? "Null",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Total Money',
                  content: totalMoney.toString(),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: DisplayInformationWidget(
            label: 'Note',
            content: note ?? "Null",
          ),
        ),
      ],
    );
  }
}
