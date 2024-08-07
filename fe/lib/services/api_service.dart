import 'package:fe/controllers/auth_controller.dart';
import 'package:fe/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/chat_session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ApiService {
  final String baseUrl = dotenv.env['URL'] ?? '';
  final AuthController _authController = Get.find<AuthController>();

  Future<String> sendMessage(String sessionId, String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/message'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authController.user.value!.token}',
      },
      body: json.encode({'sessionId': sessionId, 'message': message}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['botResponse'];
    } else {
      throw Exception('Failed to send message');
    }
  }

  Future<List<ChatSession>> getChatHistory() async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat/history'),
      headers: {'Authorization': 'Bearer ${_authController.user.value!.token}'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => ChatSession.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load chat history');
    }
  }

  Future<String> startNewChat() async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/start'),
      headers: {'Authorization': 'Bearer ${_authController.user.value!.token}'},
    );

    if (response.statusCode == 201) {
      return json.decode(response.body)['sessionId'];
    } else {
      throw Exception('Failed to start new chat');
    }
  }
}
