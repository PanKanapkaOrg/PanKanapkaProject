import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class HttpRequester
{
  Future<String> post(String url, Map<String, dynamic> jsonMap);
} 

class ApiHttpRequester implements HttpRequester {
  String _baseApiUri = "http://10.0.2.2:5000/";

  Map<String, String> _headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
    };


  Future<String> post(String url, Map<String, dynamic> jsonMap) async {
    var body = json.encode(jsonMap);

    var response = await http.post("$_baseApiUri$url", body: body, headers: _headers);
    return response.body;
  }

}
