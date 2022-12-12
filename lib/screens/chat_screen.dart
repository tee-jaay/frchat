import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Loby'),
        actions: [
          DropdownButton(
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,
            icon: const Icon(Icons.more_vert),
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Logout'),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/E8XAW2ZGzXnfhSigvF7w/messages')
            .snapshots(),
        builder: (ctx, streamSnapshots) {
          if (streamSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
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
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/E8XAW2ZGzXnfhSigvF7w/messages')
              .add({'text': 'Plus button chat'});
        },
      ),
    );
  }
}
