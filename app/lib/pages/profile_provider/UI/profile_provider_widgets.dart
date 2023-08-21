import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
//import 'package:provitask_app/controllers/home/home_controller.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';

class ProfileProviderWidgets {
  final _controller = Get.find<ProfileProviderController>();
  AppBar profileProviderAppBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            if (_controller.profileOptions.value == 0) {
              //  Get.put<HomeController>(HomeController());
              Get.back();
            } else {
              _controller.profileOptions.value = 0;
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber[800],
          )),
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber[800],
      elevation: 0,
    );
  }

  Widget profileProviderOptions() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Text(
            'Profile',
            style: TextStyle(
              color: Colors.indigo[800],
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 15,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Text(
                'Account Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clossing Messages',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Promote Yourself',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Payment',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Support',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 38),
              decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Pause Account',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 25,
            thickness: 1.1,
          ),
          const SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.indigo[800],
                borderRadius: BorderRadius.circular(45),
              ),
              child: const Text(
                'Delete Account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderAccountDetails() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Account Details',
            style: TextStyle(
              color: Colors.indigo[800],
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              Container(
                width: Get.width * 0.5,
                height: Get.width * 0.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 10, spreadRadius: 1),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/images/person.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'NAME PROVIDER',
                  style: TextStyle(
                    color: Colors.amber[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () => _controller.profileOptions.value = 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Mobile Phone',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Text(
                            'numero tlf',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.amber[800],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                height: 20,
                thickness: 1,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Zip Code',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Text(
                            'code zip',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.amber[800],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                height: 20,
                thickness: 1,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Email Address',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Text(
                            'email add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.amber[800],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                height: 20,
                thickness: 1,
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Country',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 3,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.indigo[800],
                            borderRadius: BorderRadius.circular(90),
                          ),
                          child: const Text(
                            'pais',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.amber[800],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
                height: 20,
                thickness: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget profileProviderCalendarSettings() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Calendar Settings',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.sync,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Sync Calendar',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              FlutterSwitch(
                value: true,
                onToggle: (value) {},
                activeColor: Colors.indigo[800]!,
                width: 45,
                height: 25,
              ),
            ],
          ),
          Divider(
            color: Colors.grey[400],
            height: 20,
            thickness: 1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'See app calendar',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Remember that by synchronizing your calendar you will achieve a more efficient work',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderClosingMessages() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Closing Messages',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ongoing closing messages',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Edit your default closing statement to clients for ongoing task',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Closing messages',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Edit your default closing statement to clients',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Container(
              height: 400,
              width: Get.width,
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(),
              child: Image.asset(
                  'assets/images/PROFILE PROVIDER/closing_messages.png'))
        ],
      ),
    );
  }

  Widget profileProviderSupport() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  'Support',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Visit the support center',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'App download page',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contact support',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Visit the support center',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Test push notifications',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Live chat',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Privacy policy',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Horline for emergencies',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Need help reaching your goals',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Terms and conditions',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 30,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget profileProviderPauseAccount() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Pause Account',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Recieve invitation',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              FlutterSwitch(
                value: true,
                onToggle: (value) {},
                activeColor: Colors.indigo[800]!,
                width: 45,
                height: 25,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'According to their schelude and availability that they provideus through the calendar, they will receive invitations for tasks that are according to their times',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderChangePassword() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  'Support',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _profileProviderField(
              'Retype password', '', TextEditingController(), Get.width,
              labelColor: Colors.amber[800]!),
          const SizedBox(
            height: 30,
          ),
          _profileProviderField(
              'Current password', '', TextEditingController(), Get.width,
              labelColor: Colors.amber[800]!),
          const SizedBox(
            height: 30,
          ),
          _profileProviderField(
              'New password', '', TextEditingController(), Get.width,
              labelColor: Colors.amber[800]!),
        ],
      ),
    );
  }

  Widget profileProviderMyBusiness() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'My Business',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.amber[800],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    const Text(
                      'ganancias',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 3),
                  child: const Text(
                    '999,99',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Total earned',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                value: 40 / 100,
                minHeight: 15,
                backgroundColor: Colors.grey,
                color: Colors.indigo[800],
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '30 days left',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$ 9.000',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    Text(
                      'Current Metrics',
                      style: TextStyle(
                        color: Colors.amber[800],
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.indigo[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '95%',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 95 / 100,
                          minHeight: 5,
                          backgroundColor: Colors.grey,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ),
                    const Text(
                      'Response',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '96%',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 95 / 100,
                          minHeight: 5,
                          backgroundColor: Colors.grey,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ),
                    const Text(
                      'Acceptance',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 20,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '95%',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: Get.width * 0.4,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressIndicator(
                          value: 95 / 100,
                          minHeight: 5,
                          backgroundColor: Colors.grey,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ),
                    const Text(
                      'Reliability',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Work to keep your customers satisfied',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderSkills() {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Skills',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.65,
            child: Text(
                'Surprise your customers, it is always important to highlight your skills to stand out from the rest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                )),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Pick up the apply',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
            ),
            child: Text(
              'Carpet Cleaner',
              style: TextStyle(
                color: Colors.amber[800],
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Dolly',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Eco-friendly cleaning products',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Ladder',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Fast',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.amber[800],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderSetAvailability() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Text(
              'Set Availability',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.7,
            child: SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(_getDataSource()),
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              allowViewNavigation: true,
              headerHeight: 100,
              minDate: DateTime.now(),
              maxDate: DateTime(2050),
              showDatePickerButton: true,
              showCurrentTimeIndicator: false,
              showNavigationArrow: true,
              viewNavigationMode: ViewNavigationMode.snap,
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 8,
                endHour: 22,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }

  Widget profileProviderOptionsController() {
    switch (_controller.profileOptions.value) {
      case 0:
        return profileProviderOptions();

      case 1:
        return profileProviderClosingMessages();
      case 2:
        return profileProviderSkills();
      case 3:
        return profileProviderMyBusiness();
      case 4:
        return profileProviderSupport();
      case 5:
        return profileProviderCalendarSettings();
      case 6:
        return profileProviderPauseAccount();
      case 7:
        return profileProviderChangePassword();
      case 8:
        return profileProviderSetAvailability();
      case 9:
        return profileProviderSettings();
      case 10:
        return profileProviderDirectDeposit();
      case 11:
        return profileProviderTextInfo();
      case 12:
        return profileProviderAboutMe();
      case 13:
        return profileProviderHelloPro();
      case 14:
        return profileProviderVehicles();
      case 15:
        return profileProviderAccountDetails();
      case 16:
        return profileProviderAllReviews();

      default:
        return Container();
    }
  }

  /// PANTALLAS NO COORDINADAS

  Widget profileProviderAboutMe() {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'About Me',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Why are you a provider?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Tell us more about yourself, why you decided to join this great community',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Container(
            height: Get.height * 0.4,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: TextEditingController(),
              maxLines: 12,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.amber[800],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderTextInfo() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(90),
            ),
            child: const Text(
              'Text Info',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: Get.width * 0.6,
            margin: const EdgeInsets.only(top: 10),
            child: Text(
              'To comply with all local and federal laws, your data and information is essencial',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'If you do not provide us with the nessesary information, there is a possibility that your payments may be stopped until the requested information is received',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: Colors.amber[800],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  'Update tax info',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderDirectDeposit() {
    return SizedBox(
      width: Get.width * 0.9,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Direct Deposit',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Make sure you enter your bank detail correctly, so you don\'t have any problems when the money is sent directly to your account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          _profileProviderField('Bank account number', '1289719283.....',
              TextEditingController(), Get.width,
              labelColor: Colors.amber[800]!),
          const SizedBox(
            height: 30,
          ),
          _profileProviderField('Confirm bank account number',
              '1289719283.....', TextEditingController(), Get.width,
              labelColor: Colors.amber[800]!),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: _profileProviderField('Bank routing number', '',
                TextEditingController(), Get.width * 0.5,
                labelColor: Colors.amber[800]!),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'All your private information is protected by our privacy policy',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderSettings() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text(
                  'Provider',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'Settigns',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  'Personalize your profile!!!',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'It is important that you can show in your profile that you are the qualified person for the job, it will help you level up and get more clients and reviews.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(90),
            ),
            child: const Text(
              'Name Provider',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Tools',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 11,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.photo,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bussines Photo',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'About me',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.question_mark_outlined,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Quick facts',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () => _controller.profileOptions.value = 14,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.car_repair,
                      color: Colors.amber[800],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Vehicles',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderVehicles() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  'Vehicles',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'How do you get to your destination?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Pick up the apply',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bycicle/Scooter/Motorcycle',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'For transporting small or single items',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Pick up Truck',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.indigo[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'For hauling large-sized items',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Car',
                      style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'For transporting medium-sized items',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      'Minivan/SUV',
                      style: TextStyle(
                        color: Colors.indigo[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'For transporting medium-sized items',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.amber[800],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderHelloPro() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  'Hello Provider',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'We keep you updated on what\'s happening today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'See our safety guidelines for COVID-19',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Same day task',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Container(
            width: Get.width,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Get tasks that need to be done day',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No new messages',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.amber[800],
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            height: 50,
            thickness: 1.1,
          ),
          Container(
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$560,90',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.amber[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'Monthly earning',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.2,
                      child: const Text(
                        'Today you made \$6.70 in tips',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey[400],
                  height: 30,
                  thickness: 1.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '90%',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Reliability Rate',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Icon(
                        Icons.message,
                        color: Colors.indigo[800],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'No task scheduled today',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber[800],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Get.width,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              'Rectify your availability daily so that customers.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileProviderAllReviews() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  'All Reviews',
                  style: TextStyle(
                    color: Colors.indigo[800],
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Text(
                    'Remenber that to improve you have to listen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '4.5 (178) Reviews',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.amber[800],
                      size: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            Container(
                              height: 120 * 0.3,
                              margin: const EdgeInsets.only(top: 120 * 0.7),
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.star,
                            color: Colors.indigo[200],
                            size: 35,
                          ),
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          '(7)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            Container(
                              height: 120 * 0.3,
                              margin: const EdgeInsets.only(top: 120 * 0.7),
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.star,
                            color: Colors.indigo[200],
                            size: 35,
                          ),
                        ),
                        Text(
                          '2',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          '(7)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            Container(
                              height: 120 * 0.3,
                              margin: const EdgeInsets.only(top: 120 * 0.7),
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.star,
                            color: Colors.indigo[200],
                            size: 35,
                          ),
                        ),
                        Text(
                          '3',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          '(7)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            Container(
                              height: 120 * 0.3,
                              margin: const EdgeInsets.only(top: 120 * 0.7),
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.star,
                            color: Colors.indigo[200],
                            size: 35,
                          ),
                        ),
                        Text(
                          '4',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          '(7)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[100],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                            Container(
                              height: 120 * 0.3,
                              margin: const EdgeInsets.only(top: 120 * 0.7),
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.indigo[800],
                                borderRadius: BorderRadius.circular(90),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.star,
                            color: Colors.indigo[200],
                            size: 35,
                          ),
                        ),
                        Text(
                          '5',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Text(
                          '(7)',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/person.jpeg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Name client',
                                style: TextStyle(
                                  color: Colors.indigo[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'Lorem ipsum dolor sit amet, consectetur aaboris nisi ut aliquip ex ea commodo consequat.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'message tag',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RatingBar(
                                initialRating: 4,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Colors.amber[900],
                                  ),
                                  half: Icon(
                                    Icons.star_half,
                                    color: Colors.amber[900],
                                  ),
                                  empty: Icon(
                                    Icons.star_border,
                                    color: Colors.amber[900],
                                  ),
                                ),
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.5),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Review published on February 20, 2020',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/person.jpeg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'Name client',
                                style: TextStyle(
                                  color: Colors.indigo[800],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              'Lorem ipsum dolor sit amet, consectetur aaboris nisi ut aliquip ex ea commodo consequat.',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'message tag',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RatingBar(
                                initialRating: 4,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 18,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Colors.amber[900],
                                  ),
                                  half: Icon(
                                    Icons.star_half,
                                    color: Colors.amber[900],
                                  ),
                                  empty: Icon(
                                    Icons.star_border,
                                    color: Colors.amber[900],
                                  ),
                                ),
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.5),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Review published on February 20, 2020',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileProviderField(String label, String hintText,
      TextEditingController fieldController, double width,
      {void Function()? onTap, Color labelColor = Colors.grey}) {
    return Container(
      width: width,
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 5),
            child: Text(
              label,
              style: TextStyle(
                color: labelColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                color: Colors.grey[400]!,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            child: TextField(
              controller: fieldController,
              onTap: onTap,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
