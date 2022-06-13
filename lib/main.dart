import 'package:flutter/material.dart';
import 'widget/people_list_view.dart';

void main() {
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

class PeopleListViewPage extends StatelessWidget {
  const PeopleListViewPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const PeopleListView(),
    );
  }
}
