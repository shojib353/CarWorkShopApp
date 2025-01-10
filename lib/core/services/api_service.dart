import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiService {
  Future fetchData(String url) async {
    //* STEP 01 : SEND REQUEST AND ACCEPT RESPONSE
    try {
      final response = await http.get(Uri.parse(url));

      //* STEP 02 : VALIDATE RESPONSE AND DECODE JSON
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to fetch posts');
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}