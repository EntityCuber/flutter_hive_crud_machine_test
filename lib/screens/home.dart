import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_test_hive/models/person_detail_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box _personDetailsBox = Hive.box("personDetailsBox");

  List personDetailsList = [];

  TextEditingController nameFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();
  String? gender = "Male";

  @override
  Widget build(BuildContext context) {
    personDetailsList = _personDetailsBox.values.toList();
    return Scaffold(
      body: personDetailsList.isEmpty
          ? const Center(
              child: Text("Person Details Empty"),
            )
          : ListView.builder(
              itemCount: personDetailsList.length,
              itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                      child: ListTile(
                        leading: personDetailsList[index].gender == 'Male'
                            ? const Icon(
                                Icons.boy,
                                size: 40,
                                color: Colors.blue,
                              )
                            : const Icon(
                                Icons.girl,
                                size: 40,
                                color: Colors.pink,
                              ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(personDetailsList[index].name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            Text(
                              "Age: ${personDetailsList[index].age}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _personDetailsBox.deleteAt(index);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                            keyboardType: TextInputType.text,
                            controller: nameFieldController,
                            decoration: const InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))))),
                        const SizedBox(height: 10),
                        TextField(
                            keyboardType: TextInputType.number,
                            controller: ageFieldController,
                            decoration: const InputDecoration(
                                hintText: "Age",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))))),
                        const SizedBox(height: 10),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(
                              hintText: "Age",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          value: gender,
                          items: ["Male", "Female"]
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      )))
                              .toList(),
                          onSaved: (value) {
                            gender = value;
                          },
                          onChanged: (value) {
                            gender = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _personDetailsBox.add(PersonDetailModel(
                                    name: nameFieldController.value.text,
                                    age: int.parse(
                                        ageFieldController.value.text),
                                    gender: gender ?? ''));
                              });
                              // clear input field values
                              nameFieldController.clear();
                              ageFieldController.clear();
                              print(_personDetailsBox.values);
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
                            child: const Text("Add"))
                      ],
                    ),
                  ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
