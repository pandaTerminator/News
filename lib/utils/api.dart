import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://tool.pandaterminator.com";

class API {
  static Future getNewList() {
    var url = baseUrl + "/home";
    return http.get(url);
  }
}