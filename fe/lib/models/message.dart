class Message {
  final String content;
  final bool isUser;
  final DateTime? timestamp;

  Message({
    required this.content,
    required this.isUser,
    this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] ?? '', // Default to empty string if null
      isUser: json['isUser'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
