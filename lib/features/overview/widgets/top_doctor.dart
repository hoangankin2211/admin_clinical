import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class TopDoctor2 extends StatelessWidget {
  final String image;
  final String name;
  final double price;
  const TopDoctor2({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.primaryColor.withOpacity(0.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        image,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    " Dr.$name",
                    style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.trending_up_outlined, color: Colors.green),
              Text(
                " \$$price",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopDoctor1 extends StatelessWidget {
  final String name;
  final String image;
  final double price;
  const TopDoctor1({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
              color: AppColors.headline1TextColor.withOpacity(0.2),
              blurRadius: 7.0)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        image,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 3.0,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    " Dr.$name",
                    style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.trending_up_outlined, color: Colors.green),
              Text(
                " \$$price",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
