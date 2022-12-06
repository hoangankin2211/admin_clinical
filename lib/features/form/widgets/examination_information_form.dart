import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';
import '../controller/medical_form_controller.dart';

// ignore: must_be_immutable
class ExaminationInformationForm extends StatelessWidget {
  ExaminationInformationForm({super.key});

  var medicalFormController = Get.find<MedicalFormController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: medicalFormController.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0;
                    i < medicalFormController.measureField.length;
                    i++) ...[
                  Expanded(
                    child: TextFormFieldInformationWidget(
                      inputFormatters: medicalFormController.measureField
                          .elementAt(i)['inputFormatters'],
                      suffixIcon: Icon(medicalFormController.measureField
                          .elementAt(i)['icon'] as IconData),
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
            flex: 10,
            child: Column(
              children: [
                for (int i = 0; i < medicalFormController.examField.length; i++)
                  Expanded(
                    child: TextFormFieldInformationWidget(
                      titleIcon:
                          medicalFormController.examField.elementAt(i)['icon'],
                      textEditingController: medicalFormController.examField
                          .elementAt(i)['textController'],
                      numberOfLine: medicalFormController.examField
                          .elementAt(i)['maxLine'] as int,
                      label: medicalFormController.examField
                          .elementAt(i)['title'] as String,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
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
    this.suffixIcon,
    this.titleIcon,
    this.inputFormatters,
  });
  final String label;
  final int? numberOfLine;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;
  final IconData? titleIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(titleIcon),
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
        Expanded(
          child: TextFormField(
            inputFormatters: inputFormatters,
            textAlignVertical: TextAlignVertical.center,
            controller: textEditingController,
            validator: validator,
            maxLines: numberOfLine,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: AppDecoration.primaryRadiusBorder,
                borderSide: BorderSide(color: Colors.grey[350]!, width: 0.4),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
