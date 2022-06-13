import 'dart:convert';

import '../model/person.dart';
import 'package:http/http.dart' as http;

class RandomUserService {
  static const String randomPersonUrl = "https://randomuser.me/api";
  static Future<List<Person>> fetchUsersFromApi(int numberOfPeople) async {
    http.Response response =
        await http.get(Uri.parse("$randomPersonUrl?results=$numberOfPeople"));

    if (response.statusCode == 200) {
      Map peopleData = jsonDecode(response.body);
      List<dynamic> people = peopleData["results"];
      return people.map((json) => Person.fromJson(json)).toList();
    } else {
      throw Exception("Something went wrong: ${response.statusCode}");
    }
  }
}
