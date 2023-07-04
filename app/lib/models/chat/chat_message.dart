import 'package:flutter/material.dart';

class ChatMessage {
  String? messageContent;
  String? messageType;
  String? messageTime;
  int? timestamp;
  ChatMessage({
    @required this.messageContent,
    @required this.messageType,
    @required this.messageTime,
    @required this.timestamp,
  });
}
