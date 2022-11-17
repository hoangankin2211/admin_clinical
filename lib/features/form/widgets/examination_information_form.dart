import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

class ExaminationInformationForm extends StatelessWidget {
  ExaminationInformationForm({super.key});

  final List<Map<String, dynamic>> examField = [
    {
      'title': 'Clinical Examination',
      'maxLine': 3,
    },
    {
      'title': 'Symptom',
      'maxLine': 3,
    },
    {
      'title': 'Diagnostic',
      'maxLine': 4,
    },
    {
      'title': 'Conclusion and Treatment',
      'maxLine': 4,
    },
  ];

  final List<Map<String, dynamic>> measureField = [
    {
      'title': 'Weight',
      'maxLine': 1,
    },
    {
      'title': 'Height',
      'maxLine': 1,
    },
    {
      'title': 'Heartbeat',
      'maxLine': 1,
    },
    {
      'title': 'Temperature',
      'maxLine': 1,
    },
    {
      'title': 'Blood Pressure',
      'maxLine': 1,
    },
    {
      'title': 'Allergy',
      'maxLine': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: Column(
            children: [
              for (int i = 0; i < examField.length; i++)
                Expanded(
                  child: TextFormFieldInformationWidget(
                    numberOfLine: examField.elementAt(i)['maxLine'] as int,
                    label: examField.elementAt(i)['title'] as String,
                  ),
                )
            ],
          ),
        ),
        VerticalDivider(
          color: Colors.blueGrey[400],
          width: 15,
          thickness: 0.4,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              for (int i = 0; i < measureField.length; i++)
                Expanded(
                  child: TextFormFieldInformationWidget(
                    numberOfLine: measureField.elementAt(i)['maxLine'] as int,
                    label: measureField.elementAt(i)['title'] as String,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class TextFormFieldInformationWidget extends StatelessWidget {
  const TextFormFieldInformationWidget({
    super.key,
    required this.label,
    required this.numberOfLine,
  });
  final String label;
  final int numberOfLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline4,
        ),
        TextFormField(
          maxLines: numberOfLine,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            border: OutlineInputBorder(
              borderRadius: AppDecoration.primaryRadiusBorder,
              borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
            ),
          ),
        ),
      ],
    );
  }
}
