import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/E8XAW2ZGzXnfhSigvF7w/messages')
            .snapshots(),
        builder: (ctx, streamSnapshots) {
          if(streamSnapshots.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          final documents = streamSnapshots.data!.docs;
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
            itemCount: streamSnapshots.data!.docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
