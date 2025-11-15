import 'package:flutter_secure_storage/flutter_secure_storage.dart';

 class Storagehelper {

final storage = FlutterSecureStorage(
  
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true, 
  ),
);

  Future saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future getToken() async {
    final token = await storage.read(key: 'token');
    return token;
  }

  Future deleteToken() async {
    await storage.delete(key: 'token');
  }
}
