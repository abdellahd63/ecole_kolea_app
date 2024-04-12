import 'package:ecole_kolea_app/Constant.dart';
import 'package:encrypt/encrypt.dart';

class Encryption{
  static final key = Key.fromUtf8(Constant.Key);
  static final iv = IV.fromUtf8('16byteslongIV000');

  static encryptAES(plainText) {
    if (plainText.toString().isEmpty) return '';
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static decryptAES(encryptedText) {
    if (encryptedText.toString().isEmpty) return '';
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}