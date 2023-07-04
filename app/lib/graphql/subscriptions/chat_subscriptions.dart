class ChatSubscriptions {
  final newMessage = '''
  subscription newMessage {
    newMessage {
      id
      message
      createdAt
      user {
        id
        name
        avatar
      }
    }
  }
''';
}
