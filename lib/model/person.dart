class Person {
  int? id;
  String? name;
  String? city;
  String? phoneNumber;
  String? avatar;

  Person({this.id, this.name, this.city, this.phoneNumber, this.avatar});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name:
          "${json["name"]["title"]} ${json["name"]["first"]} ${json["name"]["last"]}",
      phoneNumber: json["phone"],
      avatar: json["picture"]["large"],
    );
  }
}
