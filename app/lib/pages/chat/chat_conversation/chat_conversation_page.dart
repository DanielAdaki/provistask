import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provitask_app/components/provitask_bottom_bar.dart';
import 'package:provitask_app/components/main_app_bar.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_controller.dart';
import 'package:provitask_app/pages/chat/chat_conversation/UI/chat_conversation_widgets.dart';
import 'package:provitask_app/pages/chat/chat_conversation/propuestas/chat_propuesta_controller.dart';

class ChatConversationPage extends GetView<ChatConversationController> {
  final _widgets = ChatConversationWidgets();

  final _controller = Get.put(ChatConversationController());
  final _controllerP = Get.put(ChatPropuestaController());

  ChatConversationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeMainAppBar(),
      bottomNavigationBar: const ProvitaskBottomBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _controller.getMessages();
            await _controller.getTaskConversation();
            await _controllerP.getTaskConversation();
          },
          child: Obx(
            () => _controller.isLoading.value
                ? const CircularProgressIndicator()
                : SizedBox(
                    // Envuelve SingleChildScrollView con un Container
                    height: Get.height * 1, // Define la altura del Container
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _widgets.messagesAppBar(),
                        if (_controller.task.isNotEmpty &&
                            _controller.task['provider'] ==
                                _controller.prefs.user?['id']) ...[
                          _widgets.stickerMessage(),
                        ],
                        Expanded(
                          child: _widgets.bodyChat(),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
