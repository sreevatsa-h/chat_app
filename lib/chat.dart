import 'package:chat_app/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String title = "Chat Page";

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Socket socket;
  TextEditingController messageInput = new TextEditingController();
  var allMessages = [];
  var myUserId;
  String userName = "";
  TextEditingController nameInput = new TextEditingController();
  bool dialogOpened = false;

  @override
  initState() {
    super.initState();
    initialiseSocket();
    print("YES BUILT " + userName);
    if (userName == "") {

      SchedulerBinding.instance.addPostFrameCallback((_) {
      });

    }
  }

  void initialiseSocket() {
    socket = io('https://encryptedchat.live', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on("user_id", (data) {
      myUserId = data;
    });

    socket.on("emit_message", (data) {
      print("Got message from server");
      print(data);
      if (data["user_id"] != myUserId)
        setState(() {
          allMessages.add({"name": data["user_id"], "message": data["message"], "isSelf": false});
        });
    });
    socket.connect();
  }

  void createAlertDialog() {

  }

  void sendMessage() {
    String text = messageInput.text;
    socket.emit('/message', text);
    messageInput.text = "";
    Get.dialog(SimpleDialog());

    setState(() {
      allMessages.add({"name": myUserId, "message": text, "isSelf": true});
    });
  }

  Column renderAllMessages() {
    List<ChatBubble> messages = new List<ChatBubble>();
    allMessages.forEach((element) {
      print("MESSAGE");
      print(element);
      messages.add(new ChatBubble(isSelf: element["isSelf"], text: element["message"], senderName: element["name"],));
    });

    return new Column(children: messages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: renderAllMessages()
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 4.0, left: 4.0, right: 4.0),
                    child: TextField(
                      controller: messageInput,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 0),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                      child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => sendMessage()),
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              )
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}