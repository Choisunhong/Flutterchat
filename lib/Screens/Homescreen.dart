import 'package:flutter/material.dart';
import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/Pages/ChatPage.dart';
import 'package:teenchat/Pages/HomePage.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key,required this.chatmodels,required this.sourceChat,required this.roomId}) : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourceChat;
  final ChatModel roomId;
  @override
   _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> with SingleTickerProviderStateMixin{
  late TabController _controller;
  @override
  void initState(){

    super.initState();
    _controller=TabController(length: 4, vsync: this,initialIndex: 1);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("TeenTalk"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("New group"),
                  value: "New group",
                ),
                PopupMenuItem(
                  child: Text("New broadcast"),
                  value: "New broadcast",
                ),
                PopupMenuItem(
                  child: Text("Whatsapp Web"),
                  value: "Whatsapp Web",
                ),
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        
      ),
      body: TabBarView(
        controller:_controller,
        children: [
           HomePage(
            chatmodels: widget.chatmodels,
            sourceChat: widget.sourceChat,
            roomId: widget.roomId,
          ),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourceChat: widget.sourceChat,
            roomId: widget.roomId,
          ),
          Center(child: Text("Tab 3 Content")),
          Center(child: Text("Tab 4 Content")),
      ],),
       bottomNavigationBar: TabBar(
          controller: _controller,
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: "Home"),
            Tab(text: "CHATS"),
            Tab(text: "MYPAGE"),
            Tab(text: "SETTINGS"),
          ],
        ),
    );
  }
}
