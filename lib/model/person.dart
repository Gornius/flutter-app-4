import 'package:pr32/service/storage_user_service.dart';

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

    people.add(this);
    await storageUserService.savePeopleList(people);
    return people;
  }
}
