import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationProviderWidgets {
  Widget verifyProviderTop() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: Get.width * 0.65,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Welcome to',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Image(
                image: AssetImage('assets/images/provitask.png'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.amber[800],
                borderRadius: BorderRadius.circular(90),
              ),
              child: const Text(
                'Name Freelancer',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget verifyProviderTitleSubtitle(String title, String subtitle) {
    return SizedBox(
      width: Get.width * 0.8,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.amber[800],
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget verifyProviderRemaining() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            _verifyProviderOption(
                Icons.warning_amber_rounded, 'Set up direct deposit'),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 20,
            ),
            _verifyProviderOption(
                Icons.warning_amber_rounded, 'Finalize skills & rates'),
          ],
        ),
      ),
    );
  }

  Widget verifyProviderApproval() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            _verifyProviderOption(Icons.av_timer, 'Background checks'),
          ],
        ),
      ),
    );
  }

  Widget verifyProviderComplete() {
    return SizedBox(
      width: Get.width * 0.8,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
            ),
          ],
        ),
        child: Column(
          children: [
            _verifyProviderOption(
                Icons.check_circle_outline_outlined, 'Verify your identity'),
            Divider(
              color: Colors.grey[300],
              thickness: 1,
              height: 20,
            ),
            _verifyProviderOption(
                Icons.check_circle_outline_outlined, 'Add profile photo'),
          ],
        ),
      ),
    );
  }

  Widget _verifyProviderOption(IconData icon, String title) {
    return InkWell(
      onTap: () => Get.toNamed('/profile_provider'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                child: Icon(
                  icon,
                  color: Colors.amber[800],
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.indigo[800],
                  fontSize: 16,
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
    );
  }
}
