import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../patient/widgets/custom_text_form_field.dart';

class InputWithHeaderText extends StatelessWidget {
  final String header;
  final String hint;
  final int? maxLines;
  final TextEditingController? controller;
  const InputWithHeaderText({
    Key? key,
    required this.header,
    required this.hint,
    this.maxLines,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 5.0),
        CustomTextFormField(
          controller: controller,
          hint: hint,
          maxLine: maxLines ?? 1,
        ),
      ],
    );
  }
}
