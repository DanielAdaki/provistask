import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/controllers/auth/register_controller.dart';

class RegisterClientWidgets {
  final _controller = Get.put(RegisterController());

  Widget registerHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          registerImage(),
          // registerBackButton(),
        ],
      ),
    );
  }

  Widget registerImage() {
    return Image.asset(
      'assets/images/logo3.png',
      width: Get.width * 0.4,
    );
  }

  // Widget registerBackButton() {
  //   return Align(
  //     alignment: Alignment.topLeft,
  //     child: TextButton(
  //       onPressed: () => Get.back(),
  //       child: const Text(
  //         '< Back',
  //         style: TextStyle(
  //           fontSize: 18,
  //           color: Colors.grey,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget registerFrom() {
    return Form(
      key: _controller.formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(child: registerNameField()),
                Expanded(child: registerSurnameField()),
              ],
            ),
          ),
          registerEmailField(),
          registerPasswordField(),
          registerConfirmPasswordField(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: registerPhoneCodeSelect(),
                ),
                Expanded(
                  child: registerPhoneField(),
                ),
              ],
            ),
          ),
          registerPostalCodeField(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              'Your phone and zip code help us find the right freelancers and get in touch with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          registerButton(),
          // registerPrivacyPolicy(),
          registerLoginButton()
        ],
      ),
    );
  }

  Widget registerNameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _controller.nameController.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Name',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your name';
          return null;
        },
      ),
    );
  }

  Widget registerSurnameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _controller.surnameController.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Surname',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return 'Please enter your surname';
          return null;
        },
      ),
    );
  }

  Widget registerEmailField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      child: TextFormField(
        controller: _controller.emailController.value,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Email',
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

  Widget registerPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
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

  Widget registerConfirmPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.confirmPasswordController.value,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Confirm Password',
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

  /*Widget registerPhoneCodeSelect() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(top: 10),
      child: DropdownButtonFormField(
        value: _controller.phoneCodeRegister.value,
        decoration: const InputDecoration(
          labelText: 'Code',
          labelStyle: TextStyle(
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        items: _controller.phoneCodes!.map((phoneCode) {
          return DropdownMenuItem(
            value: phoneCode.dialCode,
            child: Text(
              phoneCode.dialCode!,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          _controller.phoneCodeRegister.value = value!.toString();
        },
      ),
    );
  }*/
  Widget registerPhoneCodeSelect() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.only(top: 10),
        child: const Text(
          '+1',
          style: TextStyle(
            fontSize: 20,
          ),
        ));
  }

  Widget registerPhoneField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(top: 5),
      child: TextFormField(
        controller: _controller.phoneController.value,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Phone Number',
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

  Widget registerPostalCodeField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
      margin: const EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: _controller.postalCodeController.value,
        enableSuggestions: false,
        autocorrect: false,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          labelText: 'Postal Code',
          labelStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the postal code';
          }
          return null;
        },
      ),
    );
  }

  Widget registerButton() {
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
        child: const Text(
          'Check in',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        onPressed: () async {
          await _controller.register();

          Get.toNamed('/login');
        },
      ),
    );
  }

  Widget registerPrivacyPolicy() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const Text(
            'By registering you accept our',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: null,
            child: Text(
              'Terms of use and our privacy policy',
              style: TextStyle(
                fontSize: 12,
                color: Colors.amber[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget registerLoginButton() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you already have an account?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          InkWell(
            onTap: () => Get.back(),
            child: Text(
              'Log In',
              style: TextStyle(
                fontSize: 16,
                color: Colors.indigo[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
