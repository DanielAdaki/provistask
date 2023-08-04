import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';
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
          body: SingleChildScrollView(
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.getConversation();
                },
                child: Column(
                  children: [
                    //  _widgets.chatHomeSearchBar(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (controller.conversation.isEmpty) ...[
                      const Center(
                        child: Text(
                          'Not chats yet',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 20,
                          ),
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
        ));
  }
}
