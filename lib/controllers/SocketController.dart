import 'package:ecole_kolea_app/Constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late IO.Socket socket;

  @override
  void onInit() async{
    // Initialize variables or perform other setup operations
    super.onInit();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    socket = IO.io(Constant.URL, <String,dynamic>{
      "transports":["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", preferences.getString("id").toString());
  }

  @override
  void onClose() {
    // Clean up resources when the controller is closed
    super.onClose();
    socket.disconnect();
  }
}