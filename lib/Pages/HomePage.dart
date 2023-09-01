import 'package:flutter/material.dart';
import 'package:teenchat/CustomUI/FriendCard.dart';
import 'package:teenchat/Model/ChatModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key,required this.chatmodels, required this.sourceChat,required this.roomId}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;
  final ChatModel roomId;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: widget.chatmodels.length,
        itemBuilder: (context, index) => FriendCard(
          chatModel: widget.chatmodels[index],
          sourceChat: widget.sourceChat,
          roomId: widget.roomId,
        ),
     )
    );

  }
}
