import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{

  static Future<http.Response> getJokeTypes() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    print("Response: ${response.body}");
    return response;
  }

  static Future<dynamic> getAllJokesFromType(String type) async{
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      print("Success: ${response.body}");
      var data = jsonDecode(response.body);
      print("data $data");
      return data;
    }
    else{
      throw Exception("Failed to load data!");
    }
  }

  static Future<http.Response> getRandomJoke() async {
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    print("Response: ${response.body}");
    return response;

  }
}