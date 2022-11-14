import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../constants/app_colors.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                        size: 20,
                      ),
                      hintText: 'Search Appointment, Patient, etc',
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const Icon(
                  Icons.notifications_outlined,
                  size: 25,
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.18,
                  child: const ListTile(
                    horizontalTitleGap: 10,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 217, 236, 246),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "Stephen Conley",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Staff Admin',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text(
                              'My Patient >> Consulation Note >>',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              ' Monitoring Plan',
                              style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Monitoring Plan',
                          style: TextStyle(
                            color: AppColors.headline1TextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 22.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Clinic Consulation @Medsy',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          '11/07/2022 @ 11:11',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Dr.Sphen Conley',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'A negative test result only means that you did not have COVID at the time of testing.However, that does not mean you will not get Covid -19.0',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Clinical Summary',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'An after-visit summary that prvides a patient with relvant and actionable inforamtion and instructions containing the patient name, providers\'s office contact information, date and location of visit, and updated medication list updated vitals, reason(s) for visit',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 30.0),
                        const Text(
                          'Prescribed Monitoring Plan',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Stephen Cury (1 Month)',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          '11/07/2021',
                          style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Amount \$300',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.blue.withOpacity(0.5),
                                ),
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        'Monitored Trackers',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Reporting Time & Reminder',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Frequency amd Review',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const ProfileRowItem(
                                mt: "Blod Pessure",
                                rt: "Thirce Time @ 8:00 am, 3:00 pm, 8:00 pm",
                                far:
                                    "The only way to know if you have high blood pressure have high blood pressure",
                              ),
                              const SizedBox(height: 10.0),
                              const ProfileRowItem(
                                mt: "Exercise",
                                rt: "Daily @ 06:00=8:00 am",
                                far:
                                    "Your doctor will probably order an have nerurolgical changes",
                              ),
                              const SizedBox(height: 10.0),
                              const ProfileRowItem(
                                mt: "Food",
                                rt: "Thirce Time @ 8:00 am, 3:00 pm, 8:00 pm",
                                far:
                                    "Your doctor will probably order an have nerurolgical changes",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      // margin: const EdgeInsets.only(left: 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.headline1TextColor.withOpacity(0.2),
                            blurRadius: 10.0,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/fake_avatar.jpg',
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.headline1TextColor
                                      .withOpacity(0.2),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Mr.Minh Hung',
                            style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 22.0),
                          ),
                          const SizedBox(height: 5.0),
                          const Text(
                            '22 Years, Male',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          const SizedBox(height: 10.0),
                          const Divider(thickness: 0.6),
                          const SizedBox(height: 20.0),
                          const ProfileRow(
                            mainTitle: "Email",
                            title: 'hungnguyen.201102ak@gmail.com',
                          ),
                          const SizedBox(height: 25.0),
                          const ProfileRow(
                            mainTitle: "Phone",
                            title: '(704) 555-0127',
                          ),
                          const SizedBox(height: 25.0),
                          const ProfileRow(
                            mainTitle: "Date of Birth",
                            title: '14 February 2001',
                          ),
                          const SizedBox(height: 25.0),
                          const ProfileRow(
                            mainTitle: "Diseases",
                            title: 'Cardiology',
                          ),
                          const SizedBox(height: 20.0),
                          const Divider(thickness: 0.6),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: ContainerProcess(
                                  mainTitle: "Blood Pessure",
                                  total: 900,
                                  data: 400,
                                  color: Colors.red,
                                  backgroundColor: Colors.red.withOpacity(0.2),
                                  des: "141/90 mmhg",
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: ContainerProcess(
                                  mainTitle: "Body Temperature",
                                  total: 500,
                                  data: 400,
                                  color: Colors.purple,
                                  backgroundColor:
                                      Colors.purple.withOpacity(0.2),
                                  des: "29'C",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Expanded(
                                child: ContainerProcess(
                                  mainTitle: "Body Height",
                                  total: 1000,
                                  data: 300,
                                  color: Colors.orange,
                                  backgroundColor:
                                      Colors.orange.withOpacity(0.2),
                                  des: "5.6\"inc",
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: ContainerProcess(
                                  mainTitle: "Body Weight",
                                  total: 1000,
                                  data: 400,
                                  color: Colors.blue,
                                  backgroundColor: Colors.blue.withOpacity(0.2),
                                  des: "78Kg",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProfileRowItem extends StatelessWidget {
  final String mt;
  final String rt;
  final String far;
  const ProfileRowItem({
    Key? key,
    required this.mt,
    required this.rt,
    required this.far,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              mt,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              rt,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              far,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerProcess extends StatelessWidget {
  final String mainTitle;
  final int total;
  final int data;
  final Color color;
  final Color backgroundColor;
  final String des;
  const ContainerProcess({
    Key? key,
    required this.mainTitle,
    required this.total,
    required this.data,
    required this.color,
    required this.backgroundColor,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10.0),
          Text('${(data / total * 100).round()}%',
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0)),
          const SizedBox(height: 10.0),
          LinearPercentIndicator(
            lineHeight: 5,
            percent: data / total,
            progressColor: color,
            backgroundColor: Colors.white.withOpacity(0.2),
            animation: true,
            animationDuration: 1000,
            barRadius: const Radius.circular(20),
          ),
          const SizedBox(height: 10.0),
          Text(
            des,
            style: TextStyle(
                color: color, fontSize: 16.0, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String mainTitle;
  final String title;
  const ProfileRow({
    Key? key,
    required this.mainTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainTitle,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.w500),
          ),
          Text(
            title,
            style: const TextStyle(
                color: AppColors.headline1TextColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
