import 'package:delivery_app2/widgets/login_widget.dart';
import 'package:delivery_app2/widgets/signup_widget.dart';
import 'package:flutter/material.dart';

class DriverAuthPage extends StatefulWidget {
  const DriverAuthPage({Key? key}) : super(key: key);

  @override
  State<DriverAuthPage> createState() => _DriverAuthPageState();
}

class _DriverAuthPageState extends State<DriverAuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(
          onClickedSignUp: toggle,
        )
      : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
