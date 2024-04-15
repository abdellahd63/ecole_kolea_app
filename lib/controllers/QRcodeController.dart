import 'package:get/get.dart';

class QRcodeController extends GetxController {
  var QrCodeData = ''.obs;
  var QrOpacity = 0.5.obs;

  void Clear(){
    QrCodeData.value = '';
    QrOpacity.value = 0.5;
  }
}