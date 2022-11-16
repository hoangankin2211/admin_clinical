import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/fake_data.dart';
import '../../../constants/global_widgets/comment_card.dart';

class DialogViewAllComment extends StatelessWidget {
  DialogViewAllComment({
    Key? key,
  }) : super(key: key);
  RxInt selectTop = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.backgroundColor,
        border: Border.all(width: 1, color: Colors.blue),
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
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
                    const SizedBox(width: 10),
                    for (int i = 0; i < FakeData.rating.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: (i == selectTop.value)
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
                                    color: (i == selectTop.value)
                                        ? Colors.white
                                        : AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              children: const [
                CommentCard(
                  name: 'Charolette Hanlin',
                  image: 'assets/images/google.png',
                  favCount: 629,
                  title:
                      'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                  day: 6,
                  star: 4,
                  checkLike: true,
                  check: 1,
                ),
                CommentCard(
                  name: 'Nguyen Minh Hung',
                  image: 'assets/images/fake_avatar.jpg',
                  favCount: 300,
                  title: 'Doctors who are very skilled and fast in service',
                  day: 8,
                  star: 3,
                  checkLike: true,
                  check: 1,
                ),
              ],
            ),
          ])),
    );
  }
}
