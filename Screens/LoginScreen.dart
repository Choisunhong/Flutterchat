import 'package:flutter/material.dart';
import 'package:teenchat/Model/ChatModel.dart';
import 'package:teenchat/CustomUI/ButtonCard.dart';
import 'package:teenchat/Screens/Homescreen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) :super(key:key) ;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chatmodels=[
    ChatModel(
      name:"Test 01",
      isGroup: false,
      currentMessage: "Hello World1",
      time:"4:00",
      icon:"person.svg",
      id:"Park",
    ),
    ChatModel(
      name:"Test 02",
      isGroup: false,
      currentMessage: "Hello World2",
      time:"5:00",
      icon:"person.svg",
      id: "Choi",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context,index)=>InkWell(
          onTap: (){
           sourceChat= chatmodels.removeAt(index);// 만약 test01 을 선택하면 test01 의 index인 1 을 삭제하고 나머지 chat model을 구동
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Homescreen(//child 클래스인 홈스크린에 chatmodels를 path한다
             chatmodels: chatmodels,
             sourceChat: sourceChat,
           )));
          },
          child: ButtonCard(
            name: chatmodels[index].name,
            icon: Icons.person),
        )),
    );
  }
}