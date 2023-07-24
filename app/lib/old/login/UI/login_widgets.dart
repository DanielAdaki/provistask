import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/auth/login_controller.dart';
import 'package:provitask_app/pages/register_client/UI/register_client_controller.dart';

class LoginWidgets {
  final _controller = Get.find<LoginController>();

  Widget loginHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          loginImage(),
          // loginBackButton(),
        ],
      ),
    );
  }

  Widget loginImage() {
    return Image.asset(
      'assets/images/logo3.png',
      width: Get.width * 0.6,
    );
  }

  Widget loginBackButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: TextButton(
        onPressed: () => _controller.loginController.value = 0,
        child: const Text(
          '< Back',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget loginFrom() {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      child: Form(
        child: Column(
          children: [
            loginHeader(),
            loginEmailField(),
            loginPasswordField(),
            loginForgottPassword(),
            loginButton(),
            loginRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget loginEmailField() {
    _controller.emailController.value =
        TextEditingController(text: "anchorquery@gmail.com");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
      child: TextFormField(
        // VALOR PREDETERMINADO

        controller: _controller.emailController.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Email',
          //valor predeterminado

          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your email';
          if (!value.isValidEmail()) return 'Please enter a valid email';
          return null;
        },
      ),
    );
  }

  Widget loginPasswordField() {
    _controller.passwordController.value =
        TextEditingController(text: "Daniel1995=");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.passwordController.value,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the password';
          }
          return null;
        },
      ),
    );
  }

  Widget loginForgottPassword() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const Text(
            'Have you forgotten your password?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () => _controller.loginForgottPassword(),
            child: Text(
              'Get a new one',
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
      margin: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 40)),
          backgroundColor: MaterialStateProperty.all(Colors.indigo[900]),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        ),
        // ignore: prefer_const_constructors
        child: Text(
          'Login',
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () => _controller.login(),
      ),
    );
  }

  Widget loginRegisterButton() {
    return TextButton(
      onPressed: () {
        Get.put<RegisterCLientController>(RegisterCLientController());
        Get.toNamed('/register_client');
      },
      child: Text(
        'Register',
        style: TextStyle(
          fontSize: 18,
          fontStyle: FontStyle.italic,
          color: Colors.amber[800],
        ),
      ),
    );
  }
}
