import 'message.dart';

class ChatSession {
  final String id;
  final List<Message> messages;
  final DateTime createdAt;

  ChatSession({
    required this.id,
    required this.messages,
    required this.createdAt,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['_id'],
      messages: (json['messages'] as List?)
              ?.map((m) => Message(
                    content: m['content'],
                    isUser: m['isUser'],
                    timestamp: DateTime.parse(m['timestamp']),
                  ))
              .toList() ??
          [],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
