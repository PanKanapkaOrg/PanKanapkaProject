import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class HttpRequester
{
  Future<String> post(String url, Map<String, dynamic> jsonMap);
  Future<String> getRequest(String url, Map<String,String> parameters);
} 

class ApiHttpRequester implements HttpRequester {
  Uri _baseApiUri = Uri(scheme: "http", host: "10.0.2.2", port: 5000);
  
  Map<String, String> _headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
    };

  Future<String> post(String url, Map<String, dynamic> jsonMap) async {
    var body = json.encode(jsonMap);

    var response = await http.post(_baseApiUri.replace(path: url), body: body, headers: _headers);
    return response.body;
  }

  Future<String> getRequest(String url, Map<String,String> parameters) async {
    var response = await http.get(_baseApiUri.replace(path: url, queryParameters: parameters));
    return response.body;
  }
}
