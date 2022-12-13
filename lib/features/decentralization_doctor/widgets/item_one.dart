import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class Item1 extends StatelessWidget {
  final String header;
  final int data;
  final bool check;
  final int data1;
  final double size;
  const Item1({
    Key? key,
    required this.header,
    required this.data,
    required this.check,
    required this.data1,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size / 2,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 170, 217, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                data.toString(),
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: check ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Text(
                      '${data1.toString()}%',
                      style: TextStyle(
                          color: check ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
