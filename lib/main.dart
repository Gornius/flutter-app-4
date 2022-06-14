import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'widget/people_list_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(colorScheme: const ColorScheme.dark().copyWith()),
      home: const PeopleListViewPage(
        title: 'People',
      ),
    );
  }
}

class PeopleListViewPage extends StatefulWidget {
  const PeopleListViewPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() => PeopleListViewPageState();
}

class PeopleListViewPageState extends State<PeopleListViewPage> {
  int _numberOfPeople = 20;
  bool _online = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          !_online
              ? Container()
              : CustomNumberPicker(
                  onValue: (value) {
                    setState(() {
                      _numberOfPeople = value as int;
                    });
                  },
                  initialValue: 20,
                  maxValue: 100,
                  minValue: 5,
                  step: 5,
                  enable: _online,
                  customMinusButton: const Icon(Icons.arrow_downward),
                  customAddButton: const Icon(Icons.arrow_upward),
                ),
          Row(
            children: [
              const Text("Online mode:"),
              Switch(
                  value: _online,
                  onChanged: (value) {
                    setState(() {
                      _online = value;
                    });
                  }),
            ],
          ),
        ],
      ),
      body: PeopleListView(
        numberOfPeople: _numberOfPeople,
      ),
    );
  }
}
