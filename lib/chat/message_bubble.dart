import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.textMessage, this.userName, this.isMe,
      {super.key, required this.msgKey});

  final String textMessage;
  final String userName;
  final bool isMe;
  final Key msgKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: isMe
                ? Colors.grey[300]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft:
                  !isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight:
                  !isMe ? const Radius.circular(12) : const Radius.circular(0),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe ? Colors.black : Colors.white70),
              ),
              Text(
                textMessage,
                textAlign: isMe ? TextAlign.end : TextAlign.start,
                style: TextStyle(color: isMe ? Colors.black : Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
