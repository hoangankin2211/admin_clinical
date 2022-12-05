import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:flutter/material.dart';

import '../../../models/patient.dart';

class PatientInformationForm extends StatelessWidget {
  PatientInformationForm({super.key, required this.patient});

  final Patient patient;

  late final List<Map<String, dynamic>> fakeData = [
    {
      'title': 'Examination',
      'content': 'Check and Advisory',
    },
    {
      'title': 'Patient Name',
      'content': patient.name,
    },
    {
      'title': 'Phone Number',
      'content': patient.phoneNumber,
    },
    {
      'title': 'Gender',
      'content': patient.gender,
    },
    {
      'title': 'Date of birth',
      'content': patient.dob,
    },
    {
      'title': 'Age',
      'content': 22,
    },
    {
      'title': 'Address',
      'content': patient.address,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patient Information',
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
              for (int i = 0; i < 3; i++) ...[
                Expanded(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'].toString(),
                    label: fakeData.elementAt(i)['title'].toString(),
                  ),
                ),
                const SizedBox(width: 5),
              ]
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 3; i < 5; i++) ...[
                Flexible(
                  flex: i - 2,
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'].toString(),
                    label: fakeData.elementAt(i)['title'].toString(),
                  ),
                ),
                const SizedBox(width: 5),
              ]
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 5; i < 7; i++) ...[
                Flexible(
                  flex: i - 4,
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'].toString(),
                    label: fakeData.elementAt(i)['title'].toString(),
                  ),
                ),
                const SizedBox(width: 5),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

class DisplayInformationWidget extends StatelessWidget {
  const DisplayInformationWidget(
      {super.key, required this.label, required this.content});
  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headline4,
          ),
          Container(
            width: double.infinity,
            decoration: AppDecoration.primaryDecorationContainer,
            padding: const EdgeInsets.all(8),
            child: Text(
              content,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
