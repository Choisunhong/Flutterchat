import 'package:flutter/material.dart';
import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/Screens/IndividualPage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class FriendCard extends StatelessWidget {

  const FriendCard({Key? key,required this.chatModel,required this.sourceChat,required this.roomId}):super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
  final ChatModel roomId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showCreateChatRoomDialog(context);
      },
      child: Column(
        children: [
         ListTile(
           leading: CircleAvatar(
            radius: 30,
            child: Icon(
            Icons.account_circle,
             color: Colors.white,
             size: 40,),
      ),
      title:Text(
        chatModel.name,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      )
      ),
      subtitle: Row(
        children:[
          ]
      ),
      
    ),
     Divider(thickness: 1,),
    
        ],
      ),
    );
  }

  void _showCreateChatRoomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("채팅방 생성"),
          content: Text("1:1 채팅방을 생성하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                
                _createChatRoom(context);
                Navigator.of(context).pop(); 
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  IndividualPage(chatModel: chatModel, sourceChat: sourceChat, roomId: roomId,),
                ));
              },
              child: Text("생성"),
            ),
          ],
        );
      },
    );
  }

  void _createChatRoom(BuildContext context) async {
    try {
      // 채팅방 생성 요청을 보낼 URL
      Uri createRoomUrl = Uri.parse('http://localhost:8080/chat/room');

      // 채팅방 생성 요청
      final response = await http.post(createRoomUrl,body: {});

      if (response.statusCode == 200) {
        // 채팅방 생성 성공
        final roomId = ChatModel(roomId:''); // 서버에서 반환한 룸 ID

        // IndividualPage로 이동하며 ChatModel과 생성한 채팅방의 룸 ID 전달
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualPage(
              chatModel: chatModel,
              sourceChat: sourceChat,
              roomId: roomId,
            ),
          ),
        );
      } else {
        // 채팅방 생성 실패
        print('Failed to create chat room');
      }
    } catch (error) {
      print('Error during chat room creation: $error');
    }
  }
}