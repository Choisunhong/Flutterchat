class ChatModel {
  final String name;
  final String icon;
  final bool isGroup;
  final String time;
  final String currentMessage;
  final String id;
  ChatModel({
    this.name = '',
    this.icon = '',
    this.isGroup = false,
    this.time = '',
    this.currentMessage = '',
    required this.id,
  });
}