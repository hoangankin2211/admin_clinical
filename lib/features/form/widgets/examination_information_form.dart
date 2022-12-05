import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';
import '../controller/medical_form_controller.dart';

class ExaminationInformationForm extends StatelessWidget {
  ExaminationInformationForm({super.key});

  var medicalFormController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 3,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0;
                  i < medicalFormController.measureField.length;
                  i++) ...[
                Expanded(
                  child: TextFormFieldInformationWidget(
                    textEditingController: medicalFormController.measureField
                        .elementAt(i)['textController'],
                    numberOfLine: 4,
                    keyboardType: TextInputType.number,
                    label: medicalFormController.measureField
                        .elementAt(i)['title'] as String,
                    validator: (value) {
                      if (int.tryParse(value!) == null) {
                        return 'not a number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
              ]
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(
            color: Colors.blueGrey[400],
            thickness: 0.4,
          ),
        ),
        Flexible(
          flex: 25,
          child: Column(
            children: [
              for (int i = 0;
                  i < medicalFormController.examField.length;
                  i++) ...[
                Expanded(
                  child: TextFormFieldInformationWidget(
                    textEditingController: medicalFormController.measureField
                        .elementAt(i)['textController'],
                    numberOfLine: medicalFormController.examField
                        .elementAt(i)['maxLine'] as int,
                    label: medicalFormController.examField.elementAt(i)['title']
                        as String,
                  ),
                ),
                const SizedBox(height: 5),
              ]
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
    this.numberOfLine,
    this.keyboardType,
    this.validator,
    this.textEditingController,
  });
  final String label;
  final int? numberOfLine;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;

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
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            validator: validator,
            maxLines: numberOfLine,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: AppDecoration.primaryRadiusBorder,
                borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
