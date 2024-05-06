import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController extends GetxController {
  Future<String> getSection() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("section").toString();
  }
}