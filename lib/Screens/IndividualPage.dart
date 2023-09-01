import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import 'package:teenchat/Model/MessageModel.dart';
import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/Stomp/socket_handler.dart';


class IndividualPage extends StatefulWidget{
  IndividualPage({Key? key,required this.chatModel, required this.sourceChat,required this.roomId}) :super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  final ChatModel roomId;
  @override
   _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  SocketHandler socketHandler = SocketHandler();
  final TextEditingController _chatController = TextEditingController(); // 컨트롤러 추가
   // 채팅 기록 리스트
  List<MessageModel> messages =[];
  @override
  void initState() {
    super.initState();
    _initSocketConnection();
  }

  void _initSocketConnection() {
    socketHandler.stompClient = StompClient(
      config: StompConfig(
        url: 'ws://localhost:8080/ws-stomp',
        onConnect: (StompFrame connectFrame) {
          print("Connected to WebSocket server!");
          socketHandler.stompClient.subscribe(
            destination: '/sub/chat/room/${widget.sourceChat.id}',
            headers: {

            },
            callback: (frame) {
              setState(() {
                // 서버로부터 메시지 도착시 chatHistory에 추가
                Map<String, dynamic> messageData = json.decode(frame.body!);
                MessageModel receivedMessage = MessageModel(
                  message: messageData['message'],
                  type: "source id", 
                );
                messages.add(receivedMessage);
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

  void _sendMessage(String message,String sourceId, String targetId) {
    setMessage("source", message);
    if (_chatController.text.isNotEmpty) {
      print("Sending message: $message, Source ID: $sourceId, Target ID: $targetId");
      socketHandler.stompClient.send(
        destination: '/pub/chat/message',
        body: jsonEncode({
          "message": _chatController.text,
          "sourceId":sourceId,
          "targetId":targetId,
        }),
      );
      _chatController.clear(); //메세지 전송후 초기화
      setState(() {});
    }
  }
void setMessage(String type,String message)
{
  MessageModel messageModel = MessageModel(message: message, type: type);
  setState(() {
    messages.add(messageModel);
  });
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
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final alignment = message.type == "source"
                    ? Alignment.centerRight
                    : Alignment.centerLeft; // 타입에 따라 정렬 위치 설정

                return Align(
                  alignment: alignment,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: message.type == "source"
                          ? Colors.lightGreen // 밝은 초록색 말풍선
                          : Colors.lightBlue, // 밝은 파란색 말풍선
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          message.message,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          message.type,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
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
                  onPressed:() => _sendMessage(_chatController.text,widget.sourceChat.id,widget.chatModel.id),
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
