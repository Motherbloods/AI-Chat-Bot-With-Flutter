import 'package:flutter/material.dart';
import '../controllers/chat_controller.dart';
import '../controllers/speech_controller.dart';
import 'package:get/get.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final ChatController _chatController = Get.find<ChatController>();
  final SpeechController _speechController = Get.find<SpeechController>();

  ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Obx(() {
              _textController.text = _speechController.recognizedText.value;
              _textController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textController.text.length));
              return TextField(
                controller: _textController,
                decoration: InputDecoration(hintText: "Type a message"),
              );
            }),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _chatController.sendMessage(_textController.text);
                _textController.clear();
                _speechController.recognizedText.value = '';
              }
            },
          ),
          Obx(() => IconButton(
                icon: Icon(_speechController.isListening.value
                    ? Icons.mic_off
                    : Icons.mic),
                onPressed: () {
                  if (_speechController.isListening.value) {
                    _speechController.stopListening();
                  } else {
                    _speechController.startListening();
                  }
                },
              )),
        ],
      ),
    );
  }
}
