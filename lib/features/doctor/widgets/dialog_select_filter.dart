import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/fake_data.dart';
import '../../auth/widgets/custom_button.dart';

class DialogSelectFilter extends StatelessWidget {
  final Function(String) callBack;
  DialogSelectFilter({
    Key? key,
    required this.callBack,
  }) : super(key: key);
  RxInt selectTop = 0.obs;
  RxInt selectRating = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.backgroundColor,
        border: Border.all(width: 1, color: Colors.blue),
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Ratings",
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < FakeData.rating.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            selectRating.value = i;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (i == selectRating.value)
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: (i == selectRating.value)
                                      ? Colors.white
                                      : AppColors.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  FakeData.rating[i] == 6
                                      ? 'All'
                                      : FakeData.rating[i].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: (i == selectRating.value)
                                        ? Colors.white
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Medical Department",
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (int i = 0; i < FakeData.topData.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            selectTop.value = i;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (i == selectTop.value)
                                    ? AppColors.primaryColor
                                    : Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.primaryColor)),
                            child: Text(
                              FakeData.topData[i],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: (i == selectTop.value)
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
                width: double.infinity,
                height: 35.0,
                child: CustomButton(
                    title: "Apply",
                    onPressed: () {
                      callBack(FakeData.topData[selectTop.value]);
                    }))
          ])),
    );
  }
}
