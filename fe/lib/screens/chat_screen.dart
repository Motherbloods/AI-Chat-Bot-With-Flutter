import 'package:fe/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';
import '../widgets/sidebar.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final ChatController _chatController = Get.find<ChatController>();
  final AuthController _authController = Get.find<AuthController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ChatScreen({Key? key}) : super(key: key) {
    // Initialize chat history when the widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chatController.initialize();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Obx(() => Text(_chatController.currentChatTitle.value)),
        backgroundColor: Color(0xFF81A263),
        foregroundColor: Color(0xFFF8EDE3),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _chatController.startNewChat();
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logout();
            },
          ),
        ],
      ),
      drawer: Sidebar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8EDE3), Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (_chatController.currentSessionId.isEmpty &&
                    _chatController.messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 80, color: Color(0xFF81A263)),
                        SizedBox(height: 20),
                        Text(
                          'Start a new conversation!',
                          style:
                              TextStyle(color: Color(0xFF81A263), fontSize: 18),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    itemCount: _chatController.messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                          message: _chatController.messages[index]);
                    },
                  );
                }
              }),
            ),
            ChatInput(),
          ],
        ),
      ),
    );
  }
}
