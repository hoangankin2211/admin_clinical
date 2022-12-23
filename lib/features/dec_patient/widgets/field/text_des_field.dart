import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../auth/widgets/custom_button.dart';

class TextDesField extends StatelessWidget {
  const TextDesField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth / 8,
                  bottom: constraints.maxHeight / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Providing the best \nOnline medical',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 70.0,
                    ),
                  ),
                  const Text(
                    'Special Care and \nBest Treatment',
                    style: TextStyle(
                      color: Color.fromARGB(255, 5, 89, 128),
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'I must explain to you how all this mistaken idea of \ndenouncing pleasure and praising pain was born\nand i will give you a complete',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  SizedBox(
                    width: 250.0,
                    height: 50,
                    child: CustomButton1(title: "Contact Us", onPressed: () {}),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
