import 'package:flutter/cupertino.dart';

class MessageNotifier extends ChangeNotifier {
  List<String> messageReceivers = [];

  void addMessageReceiver(String userId) {
    messageReceivers.add(userId);
    notifyListeners();
  }

  void removeMessageReceiver(String userId) {
    messageReceivers.remove(userId);
    notifyListeners();
  }
}