import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/pages/payments_methods/UI/payments_metods_controller.dart';

class PaymentMethodsWidgets {
  final _controller =
      Get.put<PaymentMethodsController>(PaymentMethodsController());

  AppBar pmAppBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            if (_controller.optionsController.value > 1) {
              _controller.optionsController.value = 1;
            } else {
              Get.delete<PaymentMethodsController>();
              Get.back();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.amber[800],
          )),
      toolbarHeight: Get.height * 0.1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.amber[800],
      elevation: 0,
    );
  }

  Widget pmOptionsController() {
    switch (_controller.optionsController.value) {
      case 1:
        return _pmOptions();
      case 2:
        return _pmCards();
      default:
        return Container();
    }
  }

  Widget _pmOptions() {
    return Column(
      children: [
        Text(
          'Payment',
          style: TextStyle(
            color: Colors.indigo[800],
            fontSize: 35,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          // onTap: () => _controller.profileOptions.value = 15,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.amber[800],
              borderRadius: BorderRadius.circular(45),
            ),
            child: const Text(
              'Choose your payment method',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        InkWell(
          onTap: () => _controller.optionsController.value = 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Colors.amber[800],
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Credit and debit cards',
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
          height: 40,
          thickness: 1.1,
        ),
        InkWell(
          // onTap: () => _controller.profileOptions.value = 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wallet_membership,
                    color: Colors.amber[800],
                    size: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Wallet',
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
          onTap: () => _editCard(false),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
            margin: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(90),
            ),
            child: const Text(
              'Register new card',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.circular(90),
            ),
            child: const Text(
              'Delete card',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _pmCards() => SizedBox(
        height: Get.height,
        child: Column(
          children: [
            Text(
              'Cards',
              style: TextStyle(
                color: Colors.indigo[800],
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: [
                  _pmCardStyle("Card 1", "xxxx-xxxx-xxxx-1234", "11-22"),
                  _pmCardStyle("1", "xxxx-xxxx-xxxx-1234", "11-22"),
                  _pmCardStyle("1", "xxxx-xxxx-xxxx-1234", "11-22"),
                  _pmCardStyle("1", "xxxx-xxxx-xxxx-1234", "11-22"),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _pmCardStyle(
    String alias,
    String cardNumber,
    String expirationDate,
  ) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.amber[900]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  alias,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  cardNumber,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Expiration: $expirationDate',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80,
              child: IconButton(
                  onPressed: () => _editCard(true),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.indigo[800],
                  )),
            ),
          ],
        ),
      );

  void _editCard(bool edit) => showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actions: [
            InkWell(
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.amber[800],
                    borderRadius: BorderRadius.circular(90)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.indigo[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    '${edit ? 'Edit' : 'Add new'} card',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Card Number:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              maxLength: 20,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Exp Date:',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.30,
                                child: TextField(
                                  controller: _controller.cardNumber.value,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'CVC:',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.30,
                                child: TextField(
                                  controller: _controller.cardNumber.value,
                                  textAlign: TextAlign.left,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner Full Name:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner Country:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner Address:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner City:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner Zip Code:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Owner State:',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.60,
                            child: TextField(
                              controller: _controller.cardNumber.value,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration.collapsed(
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
