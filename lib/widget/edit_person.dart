import 'package:flutter/material.dart';
import '../model/person.dart';

class EditPerson extends StatefulWidget {
  const EditPerson(this.person, {Key? key}) : super(key: key);

  final Person person;

  @override
  State<StatefulWidget> createState() => EditPersonState();
}

class EditPersonState extends State<EditPerson> {
  late Person _person;
  final _formKey = GlobalKey<FormState>();

  final _nameFieldController = GlobalKey<FormFieldState>();
  final _phoneFieldController = GlobalKey<FormFieldState>();
  final _cityFieldController = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _person = widget.person;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editing ${_person.name}"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
