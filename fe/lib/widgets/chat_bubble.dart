import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: message.isUser ? Color(0xFF81A263) : Color(0xFF006D5B),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Positioned(
              top: -8,
              right: message.isUser ? -8 : null,
              left: message.isUser ? null : -8,
              child: CustomPaint(
                size: Size(24, 24),
                painter: CornerPainter(
                    isUser: message.isUser,
                    color:
                        message.isUser ? Color(0xFF81A263) : Color(0xFF006D5B)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CornerPainter extends CustomPainter {
  final bool isUser;
  final Color color;

  CornerPainter({required this.isUser, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    if (isUser) {
      path.moveTo(size.width, size.height * 0.25);
      path.quadraticBezierTo(size.width * 0.5, 0, 0, size.height * 0.5);
      path.lineTo(size.width * 0.5, size.height);
      path.quadraticBezierTo(
          size.width, size.height * 0.75, size.width, size.height * 0.25);
    } else {
      path.moveTo(0, size.height * 0.25);
      path.quadraticBezierTo(
          size.width * 0.5, 0, size.width, size.height * 0.5);
      path.lineTo(size.width * 0.5, size.height);
      path.quadraticBezierTo(0, size.height * 0.75, 0, size.height * 0.25);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
