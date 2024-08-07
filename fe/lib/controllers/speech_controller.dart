import 'package:get/get.dart';
import '../services/speech_to_text_service.dart';

class SpeechController extends GetxController {
  final SpeechToTextService _speechToTextService = SpeechToTextService();
  final RxString recognizedText = ''.obs;
  final RxBool isListening = false.obs;

  Future<void> startListening() async {
    recognizedText.value = '';
    isListening.value = true;
    await _speechToTextService.listen((result) {
      print('ini resuls $result');
      recognizedText.value = result;
    });
  }

  void stopListening() {
    _speechToTextService.stop();
    isListening.value = false;
  }
}
