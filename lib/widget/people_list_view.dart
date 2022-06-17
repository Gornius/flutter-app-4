import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pr32/service/random_user_service.dart';
import '../model/person.dart';

class PeopleListView extends StatefulWidget {
  const PeopleListView({Key? key, required this.numberOfPeople})
      : super(key: key);

  final int numberOfPeople;

  @override
  State<StatefulWidget> createState() => PeopleListViewState();
}

class PeopleListViewState extends State<PeopleListView> {
  late Future<List<Person>> _peopleList;

  void loadUsers() {
    setState(() {
      _peopleList = RandomUserService.fetchUsersFromApi(widget.numberOfPeople);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: _peopleList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: () async {
              loadUsers();
            },
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (MediaQuery.of(context).size.width / 666 + 1).toInt(),
                  mainAxisExtent: 75,
                ),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: (Text(snapshot.data![index].name!)),
                    subtitle:
                        Text("Phone: ${snapshot.data![index].phoneNumber!}"),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index].avatar!),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.save),
                      onPressed: () async {
                        await snapshot.data![index].saveToLocal();
                      },
                    ),
                  ),
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
