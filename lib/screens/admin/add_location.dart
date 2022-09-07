import 'package:delivery_app2/services/database_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AddLocationScreen extends StatefulWidget {
  AddLocationScreen({Key? key}) : super(key: key);

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  String dropdownValue = "Select State";
  String? selectedItems;
  TextEditingController areaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();

  List<String> items = [
    'Perlis',
    'Kedah',
    'Penang',
    'Perak',
    'Kelantan',
    'Terengganu',
    'Selangor',
    'Kuala Lumpur',
    'Putrajaya',
    'Negeri Sembilan',
    'Melaka',
    'Pahang',
    'Johor',
    'Sabah',
    'Sarawak',
    'Labuan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Location"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          child: Center(
            child: Column(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: const Text('Select State'),
                    value: selectedItems,
                    items: items
                        .map((value) => DropdownMenuItem<String>(
                              child: Text(value),
                              value: value,
                            ))
                        .toList(),
                    onChanged: (item) {
                      setState(() {
                        selectedItems = item as String;
                      });
                    },
                    buttonElevation: 0,
                    dropdownMaxHeight: 300,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.blue[50],
                    ),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.blue[50],
                    ),
                  ),
                ),
                //Text(selectedItems ?? "test"),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(25)),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: areaController,
                      decoration: const InputDecoration(
                        labelText: "Operation Area",
                        isDense: true,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.blue,
                        ),
                        contentPadding: EdgeInsets.only(left: 10),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Operation area is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (selectedItems.toString() != "null") {
                        if (_formKey.currentState!.validate()) {
                          String state = selectedItems!;
                          databaseService.saveNewLocation(
                              state, areaController.text);

                          areaController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Success')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select a state')),
                        );
                      }
                    },
                    child: const Text("Save"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
