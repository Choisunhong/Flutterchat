import 'package:flutter/material.dart';
import 'package:teenchat/CustomUI/CustomCard.dart';
import 'package:teenchat/Model/ChatModel.dart';

class ChatPage extends StatefulWidget{

  ChatPage({Key? key}) : super(key: key);
  @override
   _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<ChatPage>{

  List<ChatModel> chats=[
    ChatModel(
      name:"Test 01",
      isGroup: false,
      currentMessage: "Hello World1",
      time:"4:00",
      icon:"person.svg",
    ),
    ChatModel(
      name:"Test 02",
      isGroup: false,
      currentMessage: "Hello World2",
      time:"5:00",
      icon:"person.svg",
    )
  ];
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.chat),),
      body: ListView.builder(
       
          itemCount: chats.length,
          itemBuilder:(context,index)=>CustomCard(
            chatModel: chats[index],
          ),
          
        ),
    ) ;
  }
}