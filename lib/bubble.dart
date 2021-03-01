import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  var isSelf;
  var backgroundColor;
  var alignment;
  var text;
  var senderName;

  ChatBubble({this.isSelf = true, this.text = "", this.senderName = ""}) {
    if (this.isSelf == true) {
      this.backgroundColor = Colors.greenAccent;
      this.alignment = Alignment.centerRight;
    } else {
      this.backgroundColor = Colors.lightBlueAccent;
      this.alignment = Alignment.centerLeft;
    }
  }

  Alignment testFunction() {
    return Alignment.centerRight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Align(
          child: Column(
            children: [
              Wrap(children: [
                Container(
                  child: Text(
                    this.senderName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  decoration: BoxDecoration(color: this.backgroundColor),
                  margin: EdgeInsets.only(top: 10),
                  constraints: BoxConstraints(maxWidth: 300),
                  alignment: this.alignment,
                ),
                Container(
                  child: Text(this.text),
                  decoration: BoxDecoration(color: this.backgroundColor),
                  constraints: BoxConstraints(maxWidth: 300),
                  padding: EdgeInsets.only(top: 4),
                  alignment: this.alignment,
                ),
              ]),
            ],
          ),
          alignment: this.alignment,
        ),
      ]),
    );
  }
}
