import 'package:flutter/material.dart';
import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/Screens/IndividualPage.dart';


class CustomCard extends StatelessWidget {
  const CustomCard({Key? key,required this.chatModel,required this.sourceChat}):super(key: key);
  final ChatModel chatModel;
  final ChatModel sourceChat;
@override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        IndividualPage(
          chatModel: chatModel,
          sourceChat: sourceChat,)));
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
          Icon(Icons.done_all),
          SizedBox(
            width: 5,
          ),
          Text(
           chatModel.currentMessage,
           style: TextStyle(
          fontSize:13,
        ),
        )
        ]
      ),
      trailing: Text(chatModel.time),
    ),
     Divider(thickness: 1,),
    
      ],
    ), 
   
    );
   
   
  }
}