import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pr32/service/storage_user_service.dart';
import 'package:pr32/widget/edit_person.dart';
import '../model/person.dart';

class PeopleListViewOffline extends StatefulWidget {
  const PeopleListViewOffline({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PeopleListViewOfflineState();
}

class PeopleListViewOfflineState extends State<PeopleListViewOffline> {
  late Future<List<Person>> _peopleList;

  void loadUsers() {
    setState(() {
      _peopleList = StorageUserService().loadPeopleList();
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
              child: ListView.builder(
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_rounded),
                          onPressed: () async {
                            await snapshot.data![index].removeFromLocal();
                            loadUsers();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditPerson(snapshot.data![index]),
                            ),
                          ).then((value) async {
                            loadUsers();
                          }),
                        ),
                      ],
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
