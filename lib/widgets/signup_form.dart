import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/controller/location_controller.dart';
import 'package:delivery_app2/models/driver_model.dart';
import 'package:delivery_app2/models/location_model.dart';
import 'package:delivery_app2/screens/admin/view_location_screen.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpDataForm extends StatefulWidget {
  final String userId;
  const SignUpDataForm({Key? key, required this.userId}) : super(key: key);

  @override
  State<SignUpDataForm> createState() => _SignUpDataFormState();
}

class _SignUpDataFormState extends State<SignUpDataForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final LocationController locationController = Get.put(LocationController());
  DatabaseService databaseService = DatabaseService();

  String dropdownValue = "Select State";
  var selectedItems;
  var areaSelected;
  var setDefaultMake = true;
  var setDefaultMakeModel = true;
  String hintAreaSelect = "Select Area";

  final formKey = GlobalKey<FormState>();

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
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Driver Information")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                  controller: nameController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "Name"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.isEmpty
                      ? "Name cannot be empty"
                      : null),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                // inputFormatters: [
                //   new WhitelistingTextInputFormatter(new RegExp(r'^[0-9]*$')),
                // ],
                decoration: const InputDecoration(labelText: "Phone"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 9
                    ? "Phone number require 9 numbers"
                    : null,
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    // if (setDefaultMake) {
                    //   selectedItems = "Select Statesss";
                    // }
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: const Text('Select State'),
                        value: selectedItems,
                        items: items
                            .map((value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedItems = item as String;
                            //setDefaultMake = false;
                            //setDefaultMakeModel = true;
                            areaSelected = null;
                          });
                        },
                        buttonElevation: 0,
                        dropdownMaxHeight: 300,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('location')
                      .where('state', isEqualTo: selectedItems)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // if (setDefaultMakeModel) {
                    //   areaSelected = null;
                    //   //debugPrint('setDefault make: $carMake');
                    // }
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: const Text('Select Area'),
                        value: areaSelected,
                        items: snapshot.data!.docs
                            .map((e) => DropdownMenuItem<String>(
                                  value: e.get('area'),
                                  child: Text('${e.get('area')}'),
                                ))
                            .toList(),
                        // items: items
                        //     .map((value) => DropdownMenuItem<String>(
                        //           child: Text(value),
                        //           value: value,
                        //         ))
                        //     .toList(),
                        onChanged: (selected) {
                          setState(() {
                            areaSelected = selected as String;
                            //setDefaultMakeModel = false;
                          });
                        },
                        buttonElevation: 0,
                        dropdownMaxHeight: 300,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
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
                    );
                  }),
              Text(widget.userId),
              ElevatedButton.icon(
                icon: const Icon(Icons.lock_open_outlined),
                label: const Text("Save Data"),
                onPressed: () {
                  //check if anything is null such as location, dont save it
                  areaSelected ??= "Not available";
                  print(selectedItems);
                  print(areaSelected);
                  if (nameController.text != null && selectedItems != null) {
                    DriverModel driverModel = DriverModel(
                        userId: widget.userId,
                        name: nameController.text,
                        phone: phoneController.text,
                        status: "available",
                        jobCompleted: 0,
                        state: selectedItems,
                        area: areaSelected,
                        onGoingJob: "none",
                        currentJobID: "");
                    databaseService.saveDriverInfo(driverModel);
                    // nameController.text,
                    // widget.userId,
                    // phoneController.text,
                    // 0,
                    // selectedItems,
                    // areaSelected,
                    // "available");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Success')),
                    );
                    Get.back();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Something went wrong')),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
