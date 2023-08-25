import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/Stomp/socket_handler.dart';
import 'package:teenchat/Model/ChatMessage.dart';

class IndividualPage extends StatefulWidget{
  IndividualPage({Key? key,required this.chatModel}) :super(key: key);
  final ChatModel chatModel;

  @override
   _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  SocketHandler socketHandler = SocketHandler();
  final TextEditingController _chatController = TextEditingController(); // 컨트롤러 추가
  List<ChatMessage> chatHistory = []; // 채팅 기록 리스트

  @override
  void initState() {
    super.initState();
    _initSocketConnection();
  }

  void _initSocketConnection() {
    socketHandler.stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/chatting',
        onConnect: (StompFrame connectFrame) {
          print("Connected to WebSocket server!");
          socketHandler.stompClient.subscribe(
            destination: '/topic/message',
            headers: {},
            callback: (frame) {
              setState(() {
                // 서버로부터 메시지 도착시 chatHistory에 추가
                Map<String, dynamic> messageData = json.decode(frame.body!);
                ChatMessage receivedMessage = ChatMessage(
                  content: messageData['message'],
                  uuid: "상대방 UUID", // 서버에서 받아온 상대방 UUID 사용
                );
                chatHistory.add(receivedMessage);
              });
            },
          );
        },
        webSocketConnectHeaders: {
          "transports": ["websocket"],
        },
      ),
    );
    socketHandler.stompClient.activate();
  }

  void _sendMessage() {
    if (_chatController.text.isNotEmpty) {
      socketHandler.stompClient.send(
        destination: '/app/message',
        body: jsonEncode({
          "message": _chatController.text,
        }),
      );
      _chatController.clear(); //메세지 전송후 초기화
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 222, 226),
      appBar: AppBar(
        leadingWidth: 70,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(children: [
            Icon(
              Icons.arrow_back,
              size: 24,
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 15,
              ),
            )
          ]),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:ListView.builder(
              itemCount: chatHistory.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight, // 내가 보낸 메시지는 오른쪽 정렬
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen, // 밝은 초록색 말풍선
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      chatHistory[index].content, // 메시지 내용만 표시
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          
            


          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: InputDecoration(
                      hintText: 'Enter message...',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socketHandler.stompClient.deactivate();
    super.dispose();
  }
}
