import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app2/models/order_model.dart';
import 'package:delivery_app2/screens/customer/confirmation_screen.dart';
import 'package:delivery_app2/screens/customer/customer_home.dart';
import 'package:delivery_app2/services/database_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  TextEditingController senderNameController = TextEditingController();
  TextEditingController senderPhoneController = TextEditingController();
  TextEditingController senderAddressController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController receiverAddressController = TextEditingController();
  DatabaseService databaseService = DatabaseService();

  var selectedItems;
  var areaSelected;
  var receiverSelectedItems;
  var receiverAreaSelected;
  int stepperIndex = 0;
  late int orderNumber;

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

  // @override
  // void initState() {
  //   getTracking();
  //   print(a);
  //   super.initState();
  // }

  // getTracking() {
  //   return FirebaseFirestore.instance
  //       .collection("tracking")
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((e) => a));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Order")),
      body: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: stepperIndex,
        onStepContinue: () async {
          final isLastStep = stepperIndex == getSteps().length - 1;

          if (isLastStep) {
            // Todo : send data to firebase
            try {
              OrderModel orderModel = OrderModel(
                  senderName: senderNameController.text,
                  senderPhone: senderPhoneController.text,
                  senderAddress: senderAddressController.text,
                  senderState: selectedItems,
                  senderArea: areaSelected,
                  receiverName: receiverNameController.text,
                  receiverPhone: receiverPhoneController.text,
                  receiverAddress: receiverAddressController.text,
                  receiverState: receiverSelectedItems,
                  receiverArea: receiverAreaSelected,
                  orderNumber: orderNumber,
                  status: "New Order",
                  driverAssigned: "No");
              await databaseService.saveOrder(orderModel);
              //TODO(1) : need to increment orderNumber here
              await databaseService.saveTracking(orderNumber);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success')),
              );

              Get.off(() => ConfirmationScreen(
                    theOrder: orderNumber,
                  ));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: Something went wrong')));
            }
          } else {
            setState(() {
              stepperIndex += 1;
            });
          }
        },
        onStepCancel: () {
          setState(() {
            stepperIndex -= 1;
          });
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          final isLastStep = stepperIndex == getSteps().length - 1;
          return Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              if (stepperIndex != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('BACK'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  getTrackingNumber() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("tracking").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            orderNumber = snapshot.data!.docs[0]['orderNumber'];

            //return Text("Order Number: ${orderNumber.toString()}");
            return Text("");
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }

  List<Step> getSteps() => [
        Step(
            state: stepperIndex > 0 ? StepState.complete : StepState.indexed,
            isActive: stepperIndex >= 0,
            title: const Text("Sender Info"),
            content: Column(
              children: [
                buildTextFormField(
                  textController: senderNameController,
                  hint: "Name",
                  errorMessage: "Name cannot be empty",
                  icons: Icons.person,
                  color: Colors.blue[50],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                  textController: senderPhoneController,
                  hint: "Phone",
                  errorMessage: "Phone require 9 numbers",
                  icons: Icons.phone,
                  color: Colors.blue[50],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                  textController: senderAddressController,
                  hint: "Address",
                  errorMessage: "Address cannot be empty",
                  icons: Icons.location_on,
                  color: Colors.blue[50],
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
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
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
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
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
              ],
            )),
        Step(
            state: stepperIndex > 1 ? StepState.complete : StepState.indexed,
            isActive: stepperIndex >= 1,
            title: const Text("Receiver Info"),
            content: Column(
              children: [
                buildTextFormField(
                  textController: receiverNameController,
                  hint: "Receiver Name",
                  errorMessage: "Name cannot be empty",
                  icons: Icons.person,
                  color: Colors.purple[50],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                  textController: receiverPhoneController,
                  hint: "Receiver Phone",
                  errorMessage: "Phone require 9 numbers",
                  icons: Icons.phone,
                  color: Colors.purple[50],
                ),
                const SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                  textController: receiverAddressController,
                  hint: "Receiver Address",
                  errorMessage: "Address cannot be empty",
                  icons: Icons.location_on,
                  color: Colors.purple[50],
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
                          value: receiverSelectedItems,
                          items: items
                              .map((value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (item) {
                            setState(() {
                              receiverSelectedItems = item as String;
                              //setDefaultMake = false;
                              //setDefaultMakeModel = true;
                              receiverAreaSelected = null;
                            });
                          },
                          buttonElevation: 0,
                          dropdownMaxHeight: 300,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.purple[50],
                          ),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.purple[50],
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
                        .where('state', isEqualTo: receiverSelectedItems)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: const Text('Select Area'),
                          value: receiverAreaSelected,
                          items: snapshot.data!.docs
                              .map((e) => DropdownMenuItem<String>(
                                    value: e.get('area'),
                                    child: Text('${e.get('area')}'),
                                  ))
                              .toList(),
                          onChanged: (selected) {
                            setState(() {
                              receiverAreaSelected = selected as String;
                              //setDefaultMakeModel = false;
                            });
                          },
                          buttonElevation: 0,
                          dropdownMaxHeight: 300,
                          buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.purple[50],
                          ),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.purple[50],
                          ),
                        ),
                      );
                    }),
              ],
            )),
        Step(
            state: stepperIndex > 2 ? StepState.complete : StepState.indexed,
            isActive: stepperIndex >= 2,
            title: const Text("Item(s)"),
            content: Container(child: const Text('Content for Step 1'))),
        Step(
            isActive: stepperIndex >= 3,
            title: const Text("Confirmation"),
            content: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.blue[50],
                  ),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Sender",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Name: ${senderNameController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Phone: ${senderPhoneController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Address: ${senderAddressController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("State: ${selectedItems.toString()}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Area: ${areaSelected.toString()}"),
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.purple[50],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Receiver",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Name: ${receiverNameController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Phone: ${receiverPhoneController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Address: ${receiverAddressController.text}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("State: ${receiverSelectedItems.toString()}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Area: ${receiverAreaSelected.toString()}"),
                    ],
                  ),
                ),
                getTrackingNumber()
              ],
            )),
      ];
}

class buildTextFormField extends StatelessWidget {
  const buildTextFormField(
      {Key? key,
      required this.textController,
      required this.hint,
      required this.errorMessage,
      required this.icons,
      required this.color})
      : super(key: key);

  final TextEditingController textController;
  final String hint;
  final String errorMessage;
  final IconData icons;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textController,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          labelText: hint,
          floatingLabelStyle: const TextStyle(
            height: 4,
          ),
          filled: true,
          fillColor: color,
          prefixIcon: Icon(icons),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            value != null && value.length < 1 ? errorMessage : null);
  }
}
