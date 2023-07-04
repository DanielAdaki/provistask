import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/profile_provider/UI/profile_provider_controller.dart';
import 'package:provitask_app/pages/verification_provider/UI/verification_provider_controller.dart';
import 'package:provitask_app/pages/verification_provider/UI/verification_provider_widget.dart';

class VerificationProviderPage extends GetView<VerificationProviderController> {
  final _widgets = VerificationProviderWidgets();

  VerificationProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            _widgets.verifyProviderTop(),
            _widgets.verifyProviderTitleSubtitle('Remaining Steps',
                'Start recieving tasks by adding detail about your business and verify your personal information.'),
            _widgets.verifyProviderRemaining(),
            _widgets.verifyProviderTitleSubtitle(
                'Pendding Approval', 'These items are under review.'),
            _widgets.verifyProviderApproval(),
            _widgets.verifyProviderTitleSubtitle('Complete',
                'These are done! You can always edit if you\'d like.'),
            _widgets.verifyProviderComplete(),
            InkWell(
              onTap: () {
                Get.put<ProfileProviderController>(ProfileProviderController());
                Get.offAllNamed('/profile_provider');
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.indigo[800],
                  borderRadius: BorderRadius.circular(90),
                ),
                child: const Text(
                  'Go Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
