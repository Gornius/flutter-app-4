import 'dart:convert';
import 'package:pr32/service/storage_user_service.dart';
import 'package:http/http.dart' as http;

class Person {
  String? id;
  String? name;
  String? city;
  String? phoneNumber;
  String? avatar;

  Person({this.id, this.name, this.city, this.phoneNumber, this.avatar});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json["login"]["uuid"],
      name:
          "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
      phoneNumber: json["phone"],
      avatar: json["picture"]["thumbnail"],
      city: json["location"]["city"],
    );
  }

  Map<String, dynamic> toLocalJson() {
    return {
      "id": id,
      "name": name,
      "city": city,
      "phoneNumber": phoneNumber,
      "avatar": avatar,
    };
  }

  factory Person.fromLocalJson(Map<String, dynamic> json) {
    return Person(
      id: json["id"],
      name: json["name"],
      city: json["city"],
      phoneNumber: json["phoneNumber"],
      avatar: json["avatar"],
    );
  }

  saveToLocal() async {
    StorageUserService storageUserService = StorageUserService();
    List<Person> people = await storageUserService.loadPeopleList();

    if (!people.any((element) => element.id == id)) {
      // Download and save avatar as base64
      String avatarUrl = avatar!;
      http.Response response = await http.get(Uri.parse(avatarUrl));
      String base64Avatar = base64Encode(response.bodyBytes);
      avatar = base64Avatar;

      people.add(this);

      // Restore original avatar (url)
      avatar = avatarUrl;

      await storageUserService.savePeopleList(people);
    }

    return people;
  }

  removeFromLocal() async {
    StorageUserService storageUserService = StorageUserService();
    List<Person> people = await storageUserService.loadPeopleList();

    people.remove(people.firstWhere((element) => element.id == id));
    await storageUserService.savePeopleList(people);
  }

  editFromLocal() async {
    StorageUserService storageUserService = StorageUserService();
    List<Person> people = await storageUserService.loadPeopleList();

    Person person = people.firstWhere((element) => element.id == id);
    person.name = name!;
    person.phoneNumber = phoneNumber!;
    person.city = city!;

    await storageUserService.savePeopleList(people);
  }
}
