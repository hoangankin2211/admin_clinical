import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ChangeNumberDataField extends StatelessWidget {
  final Function() addCallback;
  final Function() degCallback;
  final int data;
  final bool checkType;
  const ChangeNumberDataField({
    Key? key,
    required this.addCallback,
    required this.degCallback,
    required this.data,
    required this.checkType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(width: 0.3, color: AppColors.primaryColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${checkType ? '\$' : ''} $data',
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              color: AppColors.primaryColor,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: addCallback,
                  child: const Icon(Icons.add, color: Colors.white, size: 16.0),
                ),
                const Divider(thickness: 1),
                InkWell(
                  onTap: degCallback,
                  child:
                      const Icon(Icons.remove, color: Colors.white, size: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
