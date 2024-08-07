import 'package:fe/controllers/auth_controller.dart';
import 'package:fe/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/chat_screen.dart';
import 'controllers/chat_controller.dart';
import 'controllers/speech_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');
  await GetStorage.init();

  Get.put(AuthController());
  Get.put(ChatController());
  Get.put(SpeechController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Get.find<AuthController>().checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() => Get.find<AuthController>().isLoggedIn.value
                ? ChatScreen()
                : LoginScreen());
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
