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

  final _nameFieldController = TextEditingController();
  final _phoneFieldController = TextEditingController();
  final _cityFieldController = TextEditingController();

  @override
  void initState() {
    _person = widget.person;
    _nameFieldController.text = _person.name ?? "";
    _phoneFieldController.text = _person.phoneNumber ?? "";
    _cityFieldController.text = _person.city ?? "";
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Name",
                  icon: Icon(Icons.person),
                ),
                controller: _nameFieldController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Phone",
                  icon: Icon(Icons.phone),
                ),
                controller: _phoneFieldController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "City",
                  icon: Icon(Icons.location_city),
                ),
                controller: _cityFieldController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  } else {
                    return null;
                  }
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  if (_formKey.currentState!.validate()) {
                    _person.name = _nameFieldController.text;
                    _person.phoneNumber = _phoneFieldController.text;
                    _person.city = _cityFieldController.text;
                    await _person.editFromLocal();
                    navigator.pop();
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
