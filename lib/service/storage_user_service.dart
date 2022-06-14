import 'dart:convert';
import 'dart:io';
import '../model/person.dart';

import 'package:path_provider/path_provider.dart';

const dataVersion = '1.0';
const String fileName = "json_data$dataVersion.json";

class StorageUserService {
  Future<String> _loadFromFile() async {
    final docDir = await getApplicationDocumentsDirectory();
    final docDirPath = docDir.path;
    final file = File("$docDirPath/$fileName");
    return file.readAsString();
  }

  _writeToFile(String contents) async {
    final docDir = await getApplicationDocumentsDirectory();
    final docDirPath = docDir.path;
    final file = File("$docDirPath/$fileName");
    file.writeAsString(contents);
  }

  Future<List<Person>> loadPeopleList() async {
    final fileContents = await _loadFromFile();
    List<Person> people = jsonDecode(fileContents);

    return people;
  }

  savePeopleList(List<Person> people) async {
    var peopleList = people.map((e) => e.toLocalJson()).toList();
    _writeToFile(peopleList.toString());
  }
}
