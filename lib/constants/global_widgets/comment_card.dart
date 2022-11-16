import 'package:flutter/material.dart';

import '../app_colors.dart';

class CommentCard extends StatelessWidget {
  final String image;
  final int star;
  final String name;
  final String title;
  final bool checkLike;
  final int favCount;
  final int day;
  final int? check;
  const CommentCard({
    Key? key,
    required this.image,
    required this.star,
    required this.name,
    required this.title,
    required this.checkLike,
    required this.favCount,
    required this.day,
    this.check = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              check == 1
                  ? Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color:
                                AppColors.headline1TextColor.withOpacity(0.2),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(image),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color:
                                AppColors.headline1TextColor.withOpacity(0.2),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                width: 65,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                      size: 15,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      star.toString(),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Icon(Icons.more_horiz,
                    color: AppColors.headline1TextColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.headline1TextColor, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: checkLike
                    ? const Icon(Icons.favorite, color: AppColors.primaryColor)
                    : const Icon(
                        Icons.favorite_border,
                        color: AppColors.primaryColor,
                      ),
              ),
              const SizedBox(width: 10),
              Text(
                favCount.toString(),
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$day days ago',
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
