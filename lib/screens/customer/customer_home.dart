import 'package:delivery_app2/screens/admin/add_location.dart';
import 'package:delivery_app2/screens/customer/confirmation_screen.dart';
import 'package:delivery_app2/screens/customer/create_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({Key? key}) : super(key: key);

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  TextEditingController trackingTextController = TextEditingController();

  @override
  void dispose() {
    trackingTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Panel"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => (CreateOrderScreen()));
                },
                child: Text("Crate Order")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 45,
                  child: TextFormField(
                    controller: trackingTextController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Order Number"),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      String tracking = trackingTextController.text;
                      print(tracking);

                      Dialogs.materialDialog(
                          msg: 'Are you sure? you can\'t undo this action',
                          title: 'Tracking Result',
                          context: context,
                          actions: [
                            IconsOutlineButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              text: 'Cancel',
                              iconData: Icons.cancel_outlined,
                              textStyle: TextStyle(color: Colors.grey),
                              iconColor: Colors.grey,
                            ),
                            IconsButton(
                              onPressed: () {},
                              text: 'Delete',
                              iconData: Icons.delete,
                              color: Colors.red,
                              textStyle: TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                    },
                    child: Text("Track Order")),
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text("Order History")),
          ],
        ),
      ),
    );
  }

  Widget btnTrack(BuildContext context) {
    return MaterialButton(
      minWidth: 300,
      color: Colors.grey[300],
      onPressed: () => Dialogs.bottomMaterialDialog(
          msg: 'Are you sure? you can\'t undo this action',
          title: 'Delete',
          context: context,
          actions: [
            IconsOutlineButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: 'Cancel',
              iconData: Icons.cancel_outlined,
              textStyle: TextStyle(color: Colors.grey),
              iconColor: Colors.grey,
            ),
            IconsButton(
              onPressed: () {},
              text: 'Delete',
              iconData: Icons.delete,
              color: Colors.red,
              textStyle: TextStyle(color: Colors.white),
              iconColor: Colors.white,
            ),
          ]),
      child: Text("Show Bottom Material Dialog"),
    );
  }
}
