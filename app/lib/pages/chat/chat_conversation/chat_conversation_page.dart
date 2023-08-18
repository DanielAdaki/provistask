import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_widgets.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatConversationPage extends GetView<ChatConversationController> {
  final _widgets = ChatConversationWidgets();

  final _controllerP = Get.put(ChatPropuestaController());

  ChatConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeMainAppBar(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  // Envuelve SingleChildScrollView con un Container
                  height: Get.height * 1, // Define la altura del Container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _widgets.messagesAppBar(),
                      if (controller.task.isNotEmpty &&
                          controller.task['provider'] ==
                              controller.prefs.user?['id']) ...[
                        _widgets.stickerMessage(),
                      ],
                      SizedBox(
                          height: Get.height * 0.0,
                          child: ListView.builder(
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              final message = controller.messages[index];
                              final isUser =
                                  message.author.id == controller.user['id'];
                              return Visibility(
                                visible: false,
                                child: Text(
                                  message.author.id,
                                  style: TextStyle(
                                    color: isUser
                                        ? Colors.green
                                        : Colors.redAccent,
                                  ),
                                ),
                              );
                            },
                          )),
                      Expanded(
                          child: SizedBox(
                        height: Get.height * 1,
                        width: Get.width * 1,
                        child: Chat(
                          key: controller.chatKey,
                          messages: controller.messages,
                          onAttachmentPressed: _widgets.handleAttachmentPressed,
                          onMessageTap: controller.handleMessageTap,
                          onPreviewDataFetched:
                              controller.handlePreviewDataFetched,
                          onSendPressed: controller.handleSendPressed,
                          onEndReached: controller.handleEndReached,
                          isLastPage: controller.isLastPage.value,
                          showUserAvatars: true,
                          showUserNames: true,
                          theme: const DefaultChatTheme(
                            inputBackgroundColor: Color(0xff170591),
                          ),
                          user: types.User(
                            id: controller.prefs.user!["id"].toString(),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
