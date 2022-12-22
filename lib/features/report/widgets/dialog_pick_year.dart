import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../auth/widgets/custom_button.dart';

class DialogPickYear extends StatelessWidget {
  final Function(int) callback;
  DialogPickYear({
    Key? key,
    required this.callback,
  }) : super(key: key);

  RxInt selectYear = DateTime.now().year.obs;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(width: 2, color: AppColors.primaryColor),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(
              () => Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    for (int i = DateTime.now().year;
                        i > DateTime.now().year - 20;
                        i--)
                      InkWell(
                        onTap: () => selectYear.value = i,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: selectYear.value == i
                                ? AppColors.primaryColor
                                : Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              i.toString(),
                              style: TextStyle(
                                  color: selectYear.value == i
                                      ? Colors.white
                                      : AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: CustomButton(
                title: "Select Year",
                onPressed: () {
                  callback(selectYear.value);
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
