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
    try{
      if (encryptedText.toString().isEmpty || encryptedText.toString() == '-1') return '';
      final encrypter = Encrypter(AES(key));
      final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
      return decrypted;
    }catch(err){
      print('Error decrypting: $err');
      return '';
    }
  }
}