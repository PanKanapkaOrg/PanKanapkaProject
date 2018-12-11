import 'dart:convert';

import 'package:pankan_appka/api/http_requester.dart';

class LoginProvider {
  final HttpRequester requester;

  LoginProvider(this.requester);

  Future<Map<String, dynamic>> processLoginData(String email, String password) async {
    String response = await requester.getRequest("api/login", { "mail" : email, "password" : password});

    return json.decode(response) as Map<String, dynamic>;
  }
}