import 'package:fe/models/user.dart';
import 'package:fe/screens/chat_screen.dart';
import 'package:fe/screens/login_screen.dart';
import 'package:fe/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<User?> user = Rx<User?>(null);
  final RxBool isLoggedIn = false.obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Check if user is logged in on app start
    final storedUser = _storage.read('user');

    if (storedUser != null) {
      user.value = User.fromJson(storedUser);
      isLoggedIn.value = true;
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final loggedInUser = await _authService.login(username, password);
      user.value = loggedInUser;
      isLoggedIn.value = true;
      _storage.write('user', loggedInUser.toJson());
      Get.off(() => ChatScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to login: $e');
    }
  }

  Future<void> register(String username, String password) async {
    try {
      await _authService.register(username, password);
      Get.snackbar('Success', 'Registration successful. Please login.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to register: $e');
    }
  }

  void logout() {
    user.value = null;
    isLoggedIn.value = false;
    _storage.remove('user');
    Get.offAll(() => LoginScreen());
  }

  Future<void> checkLoginStatus() async {
    final storedUser = _storage.read('user');
    if (storedUser != null) {
      user.value = User.fromJson(storedUser);
      isLoggedIn.value = true;
    }
  }
}
