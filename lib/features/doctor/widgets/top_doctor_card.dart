import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../constants/app_colors.dart';

class TopDoctorCard extends StatelessWidget {
  final String name;
  final String image;
  final String description;
  final String type;
  final double ratings;
  const TopDoctorCard({
    Key? key,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.ratings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Text(
              "Dr.$name",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
          ),
          Container(
            width: 300,
            height: 450,
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                left: BorderSide(width: 10, color: AppColors.primaryColor),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.2),
                  blurRadius: 10.0,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        image,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "HEAD OF THE DEPARTMENT",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(FontAwesome.twitter,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {},
                        child: const Icon(FontAwesome.facebook,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {},
                        child: const Icon(FontAwesome.google,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    description,
                    maxLines: 4,
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                  ),
                ),
                const Spacer(),
                const Divider(thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.yellowAccent),
                          Text(
                            '$ratings rating',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
