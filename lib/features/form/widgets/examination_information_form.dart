import 'package:admin_clinical/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_decoration.dart';

// ignore: must_be_immutable
class ExaminationInformationForm extends StatelessWidget {
  const ExaminationInformationForm({
    super.key,
    required this.examField,
    required this.formKey,
    required this.measureField,
    required this.textController,
  });

  final List<Map<String, dynamic>> examField;
  final GlobalKey<FormState> formKey;
  final List<Map<String, dynamic>> measureField;
  final Map<String, TextEditingController> textController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxHeight * 0.8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0; i < measureField.length; i++) ...[
                        Flexible(
                          child: TextFormFieldInformationWidget(
                            isDense: true,
                            inputFormatters:
                                measureField.elementAt(i)['inputFormatters'],
                            suffixIcon: Icon(
                                measureField.elementAt(i)['icon'] as IconData),
                            textEditingController:
                                textController[measureField.elementAt(i)['key']]
                                    as TextEditingController,
                            keyboardType: TextInputType.number,
                            label: measureField.elementAt(i)['title'] as String,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field can not be empty';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Not a number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Divider(
              color: Colors.blueGrey[400],
              thickness: 0.4,
            ),
          ),
          Flexible(
            flex: 11,
            child: Column(
              children: [
                for (int i = 0; i < Utils.examField.length; i++)
                  Expanded(
                    child: TextFormFieldInformationWidget(
                      titleIcon: examField.elementAt(i)['icon'],
                      textEditingController:
                          textController[examField.elementAt(i)['key']]
                              as TextEditingController,
                      numberOfLine: examField.elementAt(i)['maxLine'] as int,
                      label: examField.elementAt(i)['title'] as String,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field can not be empty';
                        }
                        return null;
                      },
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
    this.isDense,
  });
  final String label;
  final int? numberOfLine;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? textEditingController;
  final Widget? suffixIcon;
  final IconData? titleIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isDense;

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
            if (titleIcon != null) Icon(titleIcon),
            const SizedBox(width: 1),
            Expanded(
              child: Text(
                overflow: TextOverflow.ellipsis,
                label,
                style: Theme.of(context).textTheme.headline4,
              ),
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
              suffixIconConstraints:
                  const BoxConstraints(minWidth: 2, minHeight: 0),
              isDense: isDense,
              contentPadding:
                  const EdgeInsets.only(top: 18, left: 10, right: 10),
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
