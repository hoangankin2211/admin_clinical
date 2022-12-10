import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/comment_card.dart';

class PatientDetailScreen extends StatelessWidget {
  const PatientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Patient List ',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.grey),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          ' Nguyen Minh Hung ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              _profileFiled(),
                              _listMedicalField(),
                            ],
                          ),
                        ),
                        _reviewField(constraints, context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Expanded _reviewField(BoxConstraints constraints, BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.backgroundColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Satisfation Rate: ',
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      const Icon(Icons.star, color: Colors.amber, size: 20.0),
                      Text(
                        ' 4.8',
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'All Reviews',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10.0),
                        ],
                      ),
                      child: ListView(children: const [
                        CommentCard(
                          name: 'Charolette Hanlin',
                          image: 'assets/images/doctor2.png',
                          favCount: 629,
                          title:
                              'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                          day: 6,
                          star: 4,
                          checkLike: true,
                          check: 1,
                        ),
                        Divider(thickness: 1),
                        CommentCard(
                          name: 'Charolette Hanlin',
                          image: 'assets/images/doctor2.png',
                          favCount: 629,
                          title:
                              'Dr.Jenny is very professional in her work and responsive. I have consulted and my problem is solved.',
                          day: 6,
                          star: 4,
                          checkLike: true,
                          check: 1,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColors.backgroundColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        'Taxable',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Spacer(),
                      Text(
                        '\$6,660.00',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        'Additional Charges',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Spacer(),
                      Text(
                        '\$6,660.00',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        'Discount',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Spacer(),
                      Text(
                        '\$6,660.00',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        'Sub total',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const Spacer(),
                      Text(
                        '\$6,660.00',
                        style: TextStyle(
                          color: Colors.blueGrey[400],
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  AppWidget.primaryDivider,
                  Row(
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        'Total Amount',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const Spacer(),
                      Text(
                        '\$6,660.00',
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: AppColors.primaryColor),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'images/signature.png',
                      height: 50,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _listMedicalField() => Expanded(
        flex: 6,
        child: Container(
          margin: const EdgeInsets.only(
              top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.backgroundColor,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 10.0)
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.grey[100],
                    ),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          width: 300.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text(
                            'Upcomming Appointmenst',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          alignment: Alignment.center,
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          width: 230.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Complete Medical',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Row(
                          children: [
                            const Text(
                              'Root Canal Treatment',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.keyboard_arrow_up_rounded,
                                        color: Colors.grey),
                                    Text(
                                      ' Show Pervious Treatment',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 1),
                      Expanded(
                          child: ListView(
                        children: const [
                          MedicalItem(),
                          MedicalItem(),
                          MedicalItem(),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Expanded _profileFiled() => Expanded(
        flex: 5,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10.0)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8.0)
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/doctor2.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Nguyen Minh Hung',
                      style: const TextStyle(
                        color: AppColors.headline1TextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      'hungnguyen.201102ak@gmail.com',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('100',
                                  style: const TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              const SizedBox(height: 5.0),
                              Text(
                                'Medical',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 60, width: 0.5, color: Colors.grey),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('100',
                                  style: const TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0)),
                              const SizedBox(height: 5.0),
                              Text(
                                'Upcomming',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: CustomButton(text: "Edit Profile", onTap: () {}),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 10.0, left: 5.0, right: 10.0, bottom: 5.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.backgroundColor,
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 10.0)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const ProfileItem(
                          header: "Gender",
                          title: "Male",
                        ),
                        ProfileItem(
                          header: "Birthday",
                          title:
                              DateFormat().add_yMMMEd().format(DateTime.now()),
                        ),
                        const ProfileItem(
                          header: "Phone Number",
                          title: '(81) 555-0108',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(thickness: 0.5),
                    const SizedBox(height: 10.0),
                    Row(
                      children: const [
                        ProfileItem(
                          header: "Street Address",
                          title: "22, Chu Van An thi xa An Khe Gia Lai",
                        ),
                        ProfileItem(
                          header: "City",
                          title: 'Ho Chi Minh City',
                        ),
                        ProfileItem(
                          header: "Zip Code",
                          title: '655849',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(thickness: 0.5),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const ProfileItem(
                          header: "Member Status",
                          title: "Active Member",
                        ),
                        ProfileItem(
                          header: "Registerd Date",
                          title:
                              DateFormat().add_yMMMEd().format(DateTime.now()),
                        ),
                        const Expanded(child: SizedBox())
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}

class MedicalItem extends StatelessWidget {
  const MedicalItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 3, color: AppColors.primaryColor),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.only(top: 10.0, bottom: 10, right: 20.0),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat().add_yMMMEd().format(
                                DateTime.now(),
                              ),
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          '09:10 - 10:10',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 60, width: 0.5, color: Colors.grey),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Treatment',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          'Open Access',
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Container(height: 60, width: 0.5, color: Colors.grey),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Doctor',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Nguyen Minh Hung',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.primaryColor.withOpacity(0.3),
                          ),
                          child: Text(
                            '\$300.0',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String header;
  final String title;
  const ProfileItem({
    Key? key,
    required this.header,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          header,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
      ]),
    );
  }
}
