import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/components/spinner.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_controller.dart';
import 'package:provitask_app/pages/chat/chat_home/UI/chat_home_widgets.dart';

class ChatHomePage extends GetView<ChatHomeController> {
  ChatHomePage({Key? key}) : super(key: key);
  final _widgets = ChatHomeWidgets();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: const HomeMainAppBar(),
          bottomNavigationBar: const ProvitaskBottomBar(),
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () async {
              controller.isLoading.value = true;
              await Future.wait<void>([
                controller.getConversation(),
              ]);
              controller.isLoading.value = false;
            },
            child: controller.isLoading.value == true
                ? const SpinnerWidget()
                : SingleChildScrollView(
                    child: SafeArea(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.isLoading.value = true;
                          await controller.getConversation();
                          controller.isLoading.value = false;
                        },
                        child: Column(
                          children: [
                            //  _widgets.chatHomeSearchBar(),
                            const SizedBox(
                              height: 20,
                            ),
                            if (controller.conversation.isEmpty) ...[
                              Container(
                                width: Get.width * 0.9,
                                height: Get.height * 0.6,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 5),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'You have no conversations yet',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Start a conversation with a freelancer to get started',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              _widgets.chatHomeChats(),
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ));
  }
}
