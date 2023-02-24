import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:what_is_my_ip/model/ip_entity.dart';
import 'package:what_is_my_ip/model/ip_info_entity.dart';

class APIService {
  static Future<IPEntity> getIpAddress() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org/?format=json'));
    final jsonResponse = jsonDecode(response.body);
    return IPEntity.fromJson(jsonResponse);
  }

  static Future<IPInfoEntity> getIpInfo({required String ip}) async {
    final response = await http.get(Uri.parse('https://ipinfo.io/${ip}/geo'));
    final jsonResponse = jsonDecode(response.body);
    return IPInfoEntity.fromJson(jsonResponse);
  }
}
