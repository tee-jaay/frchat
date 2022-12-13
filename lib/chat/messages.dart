import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userdata = Future.value(FirebaseAuth.instance.currentUser);
    return FutureBuilder(
        future: userdata,
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy(
                    'created_at',
                    descending: true,
                  )
                  .snapshots(),
              builder: (ctx, chatSnapshots) {
                if (chatSnapshots.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var chatDocs = chatSnapshots.data?.docs ?? [];

                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                    chatDocs[index]['text'],
                    chatDocs[index]['username'],
                    chatDocs[index]['userId'] == futureSnapshot.data?.uid,
                    msgKey: ValueKey(chatDocs[index].id),
                  ),
                );
              });
        });
  }
}
