import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat/new_message.dart';
import '../chat/messages.dart';

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
      body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
