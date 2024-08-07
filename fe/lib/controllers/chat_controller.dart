import 'package:get/get.dart';
import '../models/message.dart';
import '../models/chat_session.dart';
import '../services/api_service.dart';

class ChatController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxList<ChatSession> chatSessions = <ChatSession>[].obs;
  final RxList<Message> messages = <Message>[].obs;
  final RxString currentSessionId = ''.obs;
  var currentChatTitle = ''.obs;

  bool _isInitialized = false;

  Future<void> initialize() async {
    if (!_isInitialized) {
      await loadChatHistory();
      _isInitialized = true;
      // Set to general chat view
      currentSessionId.value = '';
      currentChatTitle.value = 'New Chat';
      messages.clear();
    }
  }

  Future<void> sendMessage(String content) async {
    if (currentSessionId.isEmpty) {
      await startNewChat();
    }
    final message = Message(content: content, isUser: true);
    messages.add(message);

    try {
      final response =
          await _apiService.sendMessage(currentSessionId.value, content);
      final botMessage = Message(content: response, isUser: false);
      messages.add(botMessage);
      await loadChatHistory(); // Refresh chat history after sending a message
    } catch (e) {
      print('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  Future<void> loadChatHistory() async {
    try {
      final history = await _apiService.getChatHistory();

      chatSessions.assignAll(history);
      if (history.isNotEmpty && currentSessionId.isEmpty) {
        loadChat(history.first.id);
      }
    } catch (e) {
      print('Error fetching chat history from API: $e');
      Get.snackbar('Error', 'Failed to load chat history');
    }
  }

  Future<void> startNewChat() async {
    try {
      final sessionId = await _apiService.startNewChat();
      if (sessionId == null) {
        throw Exception('Received null sessionId from ApiService');
      }
      print('New sessionId: $sessionId');
      currentSessionId.value = sessionId;
      currentChatTitle.value = 'New Chat';
      messages.clear();
      await loadChatHistory();
    } catch (e) {
      print('Error starting new chat: $e');
      Get.snackbar('Error', 'Failed to start new chat');
    }
  }

  void loadChat(String sessionId) {
    currentSessionId.value = sessionId;
    final session = chatSessions.firstWhere((s) => s.id == sessionId);
    currentChatTitle.value = 'Chat ${chatSessions.indexOf(session) + 1}';
    messages.assignAll(session.messages);
  }
}
