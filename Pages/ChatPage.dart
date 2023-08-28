import 'package:flutter/material.dart';
import 'package:teenchat/CustomUI/CustomCard.dart';
import 'package:teenchat/Model/ChatModel.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key,required this.chatmodels, required this.sourceChat}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => CustomCard(
          chatModel: widget.chatmodels[index],
          sourceChat: widget.sourceChat,
        ),
     )
    );

  }
}
