import 'package:delivery_app2/main.dart';
import 'package:delivery_app2/screens/admin/admin_home.dart';
import 'package:delivery_app2/screens/admin/admin_auth_screen.dart';
import 'package:delivery_app2/screens/driver/driver_auth_screen.dart';
import 'package:delivery_app2/screens/driver/driver_home.dart';
import 'package:delivery_app2/widgets/login_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({Key? key}) : super(key: key);

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.hasData) {
              return DriverHome();
            } else {
              //return LoginWidget();
              return DriverAuthPage();
            }
          }),
    );
  }
}
