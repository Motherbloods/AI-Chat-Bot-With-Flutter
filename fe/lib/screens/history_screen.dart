import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  final ChatController _chatController = Get.find<ChatController>();

  HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
        backgroundColor: Color(0xFF81A263),
        foregroundColor: Color(0xFFF8EDE3),
      ),
      body: Container(
        color: Color(0xFFF8EDE3),
        child: Obx(() => ListView.builder(
              itemCount: _chatController.chatSessions.length,
              itemBuilder: (context, index) {
                final session = _chatController.chatSessions[index];
                return ListTile(
                  title: Text('Chat ${index + 1}',
                      style: TextStyle(color: Color(0xFF81A263))),
                  subtitle: Text(session.createdAt.toString(),
                      style:
                          TextStyle(color: Color(0xFF81A263).withOpacity(0.7))),
                  onTap: () {
                    // Handle tapping on a chat session
                  },
                );
              },
            )),
      ),
    );
  }
}
