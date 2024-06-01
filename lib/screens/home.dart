import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:machine_test_hive/models/person_details_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box _personDetailsBox = Hive.box("personDetailsBox");

  List personDetailsList = [];

  // Add person details dialog form text controllers
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController ageFieldController = TextEditingController();
  String? sex = "Male"; // Default sex value is set to male

  // Update dialog form text controllers
  TextEditingController editNameFieldController = TextEditingController();
  TextEditingController editAgeFieldController = TextEditingController();
  String? editSex = "Male"; // Default sex value is set to male

  @override
  Widget build(BuildContext context) {
    personDetailsList = _personDetailsBox.values.toList();
    return Scaffold(
      body: personDetailsList.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(100.0),
                child: Text(
                  "Person details empty. Add by tapping the floating button and filling form.",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
              itemCount: personDetailsList.length,
              itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: ListTile(
                        leading: personDetailsList[index].sex == 'Male'
                            ? const Icon(
                                Icons.boy,
                                size: 40,
                                color: Colors.grey,
                              )
                            : personDetailsList[index].sex == 'Female'
                                ? const Icon(
                                    Icons.girl,
                                    size: 40,
                                    color: Colors.grey,
                                  )
                                : const Icon(Icons.error,
                                    size: 40, color: Colors.red),
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
                            Text(
                              "Sex: ${personDetailsList[index].sex}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        trailing: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      editNameFieldController.text =
                                          personDetailsList[index].name;
                                      editAgeFieldController.text =
                                          "${personDetailsList[index].age}";
                                      editSex = personDetailsList[index].sex;
                                      return AlertDialog(
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextField(
                                                keyboardType:
                                                    TextInputType.text,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                controller:
                                                    editNameFieldController,
                                                decoration: const InputDecoration(
                                                    hintText: "Name",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))))),
                                            const SizedBox(height: 10),
                                            TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                controller:
                                                    editAgeFieldController,
                                                decoration: const InputDecoration(
                                                    hintText: "Age",
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))))),
                                            const SizedBox(height: 10),
                                            DropdownButtonFormField(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              decoration: const InputDecoration(
                                                  hintText: "Age",
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)))),
                                              value: editSex,
                                              items: ["Male", "Female"]
                                                  .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) =>
                                                          DropdownMenuItem<
                                                                  String>(
                                                              value: value,
                                                              child: Text(
                                                                value,
                                                              )))
                                                  .toList(),
                                              onSaved: (value) {
                                                editSex = value;
                                              },
                                              onChanged: (value) {
                                                editSex = value;
                                              },
                                            ),
                                            const SizedBox(height: 20),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _personDetailsBox.putAt(
                                                        index,
                                                        PersonDetailsModel(
                                                            name:
                                                                editNameFieldController
                                                                    .value.text,
                                                            age: int.parse(
                                                                editAgeFieldController
                                                                    .value
                                                                    .text),
                                                            sex: sex ?? ''));
                                                  });
                                                  // clear input field values
                                                  editNameFieldController
                                                      .clear();
                                                  editAgeFieldController
                                                      .clear();
                                                  if (!context.mounted) {
                                                    return;
                                                  }
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Update"))
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
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
                          ],
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
                            textCapitalization: TextCapitalization.words,
                            controller: nameFieldController,
                            decoration: const InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))))),
                        const SizedBox(height: 10),
                        TextField(
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: ageFieldController,
                            decoration: const InputDecoration(
                                hintText: "Age",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))))),
                        const SizedBox(height: 10),
                        DropdownButtonFormField(
                          borderRadius: BorderRadius.circular(12),
                          decoration: const InputDecoration(
                              hintText: "Age",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          value: sex,
                          items: ["Male", "Female"]
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      )))
                              .toList(),
                          onSaved: (value) {
                            sex = value;
                          },
                          onChanged: (value) {
                            sex = value;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _personDetailsBox.add(PersonDetailsModel(
                                    name: nameFieldController.value.text,
                                    age: int.parse(
                                        ageFieldController.value.text),
                                    sex: sex ?? ''));
                              });
                              // clear input field values
                              nameFieldController.clear();
                              ageFieldController.clear();
                              if (!context.mounted) {
                                return;
                              }
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
