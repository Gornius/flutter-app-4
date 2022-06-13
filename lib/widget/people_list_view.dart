import 'package:flutter/material.dart';
import 'package:pr32/service/random_user_service.dart';
import '../model/person.dart';

class PeopleListView extends StatefulWidget {
  const PeopleListView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PeopleListViewState();
}

class PeopleListViewState extends State<PeopleListView> {
  late Future<List<Person>> _peopleList;

  @override
  void initState() {
    super.initState();
    _peopleList = RandomUserService.fetchUsersFromApi(100);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: _peopleList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: (Text(snapshot.data![index].name!)),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data![index].avatar!),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}
