import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  Future<void> listen(Function(String) onResult) async {
    if (await initialize()) {
      await _speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
        listenFor: Duration(seconds: 30),
        pauseFor: Duration(seconds: 5),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
      );
    }
  }

  void stop() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}
