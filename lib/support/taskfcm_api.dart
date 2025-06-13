import 'package:awas_ace/repositories/url_apilocal.dart';
import 'package:awas_ace/repositories/url_apipublish.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskSendMsgURL {
  static Future<String> get host async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt("idServer") ?? 1;

    final baseUrl = id == 1 ? urlApiPublish() : urlApiLocal();
    // print(baseUrl);
    return "${baseUrl}fcm/Send";
  }
}
