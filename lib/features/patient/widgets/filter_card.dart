import 'package:flutter/material.dart';

import '../../../constants/app_decoration.dart';

class FilterCategory extends StatelessWidget {
  const FilterCategory({
    super.key,
    required this.title,
    required this.hint,
    required this.iconData,
    this.controller,
    this.onChanged,
    this.onSubmit,
    this.onFieldSubmitted,
  });
  final TextEditingController? controller;
  final String title;
  final String hint;
  final IconData iconData;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Colors.grey[400]!, fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                borderRadius: AppDecoration.primaryRadiusBorder,
                borderSide: BorderSide(
                  color: Colors.grey[300]!,
                  width: 0.05,
                ),
              ),
              suffixIcon: Icon(iconData)),
        ),
      ],
    );
  }
}
