import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/login/login_page.dart';
import 'package:provitask_app/pages/welcome/UI/welcome_controller.dart';

class WelcomeWidgets {
  final _controller = WelcomeController();

  AppBar welcomeAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.indigo[900]),
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Provi',
            style: TextStyle(
              fontSize: 35,
              color: Colors.indigo[900],
            ),
          ),
          Text(
            'Task',
            style: TextStyle(
              fontSize: 35,
              color: Colors.amber[800],
            ),
          ),
        ],
      ),
      actions: [
        Visibility(
          visible: _controller.stepWelcome.value > 1,
          child: TextButton(
            onPressed: () => Get.off(() => LoginPage()),
            child: const Text('Skip >', style: TextStyle(color: Colors.grey)),
          ),
        )
      ],
    );
  }

  Widget welcomePresentation1() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: Image.asset(
            'assets/images/WELCOME/welcome_1.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Perform your tasks successfully in one step',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.height * 0.04,
              color: Colors.amber[800],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomePresentation2() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: Image.asset(
            'assets/images/WELCOME/welcome_2.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Choose the easiest way to play your tasks with 100% safe help',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.height * 0.04,
              color: Colors.amber[800],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomePresentation3() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          child: Image.asset(
            'assets/images/WELCOME/welcome_3.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Find Professionals with verified reviews and honest prices',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.height * 0.04,
              color: Colors.amber[800],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomePresentation4() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset(
            'assets/images/WELCOME/welcome_4.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Chat with your professional ans check all the details of the task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.height * 0.04,
              color: Colors.amber[800],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomePresentation5() {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(Get.context!).size.height * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset(
            'assets/images/WELCOME/welcome_5.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Organize your tasks and create your own team of professionals',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Get.height * 0.04,
              color: Colors.amber[800],
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget welcomeStepIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _controller.stepWelcome.value == 1
                  ? Colors.grey[500]
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
          ),
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _controller.stepWelcome.value == 2
                  ? Colors.grey[500]
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
          ),
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _controller.stepWelcome.value == 3
                  ? Colors.grey[500]
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
          ),
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _controller.stepWelcome.value == 4
                  ? Colors.grey[500]
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
          ),
          Container(
            width: 15,
            height: 15,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: _controller.stepWelcome.value == 5
                  ? Colors.grey[500]
                  : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeStepPresentationController() {
    switch (_controller.stepWelcome.value) {
      case 1:
        return welcomePresentation1();
      case 2:
        return welcomePresentation2();
      case 3:
        return welcomePresentation3();
      case 4:
        return welcomePresentation4();
      case 5:
        return welcomePresentation5();
      default:
        return Container();
    }
  }

  Widget welcomeFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (_controller.stepWelcome.value < 5) {
          _controller.stepWelcome.value++;
        } else {
          Get.offAllNamed('/login');
        }
      },
      label: _controller.stepWelcome > 1
          ? const Row(
              children: [
                Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined),
              ],
            )
          : const Row(
              children: [
                Text(
                  'Get Stared',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_outlined),
              ],
            ),
      backgroundColor: Colors.indigo[900],
    );
  }
}
