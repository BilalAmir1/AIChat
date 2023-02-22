enum ChatMessageType { user, bot }

class ChatMessages {
  final String text;
  final ChatMessageType chatMessageType;

  ChatMessages({required this.text, required this.chatMessageType});
}
