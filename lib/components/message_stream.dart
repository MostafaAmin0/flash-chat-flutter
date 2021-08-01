import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageStream extends StatelessWidget {
  MessageStream(this._fireStore);

  final CollectionReference<Map<String, dynamic>> _fireStore;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _fireStore.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('something went wrong !');
          }
          var messages = snapshot.requireData;
          return ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: messages.size,
            itemBuilder: (context, index) {
              return MessageBubble(
                sender: messages.docs[index]['sender'],
                text: messages.docs[index]['text'],
              );
            },
          );
        },
      ),
    );
  }
}

