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
                  content: 'Record ID',
                  label: id ?? "",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  content: 'Date Create',
                  label: dateCreate ?? "",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  content: 'Status',
                  label: status ?? "",
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
                  content: 'Department',
                  label: id ?? "",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  content: 'Doctor in Charge',
                  label: dateCreate ?? "",
                ),
              ),
              Expanded(
                child: DisplayInformationWidget(
                  content: 'Total Money',
                  label: status ?? "",
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Expanded(
            child: DisplayInformationWidget(
              content: 'Note',
              label: note ?? "",
            ),
          ),
        ),
      ],
    );
  }
}
