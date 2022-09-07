import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grouped_list/grouped_list.dart';

class SelectLocationWidget extends StatefulWidget {
  const SelectLocationWidget({Key? key}) : super(key: key);

  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location")),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('location').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading...");
            } else {
              return GroupedListView(
                elements: snapshot.data!.docs.toList(),
                groupBy: (value) {
                  if (snapshot.hasData) {
                    return value;
                  } else {
                    return null;
                  }
                },
                // groupSeparatorBuilder: (String value) => Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     value,
                //     textAlign: TextAlign.center,
                //     style: const TextStyle(
                //         fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
                itemBuilder: (c, element) {
                  return Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: SizedBox(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: const Icon(Icons.account_circle),
                        //title: Text(element),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  );
                },
                order: GroupedListOrder.ASC,
              );
            }
          }),
    );
  }
}
