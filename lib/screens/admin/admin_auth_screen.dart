import 'package:delivery_app2/widgets/admin_login_widget.dart';
import 'package:delivery_app2/widgets/login_widget.dart';
import 'package:delivery_app2/widgets/signup_widget.dart';
import 'package:flutter/material.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({Key? key}) : super(key: key);

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? AdminLoginWidget(
          onClickedSignUp: toggle,
        )
      : SignUpWidget(onClickedSignIn: toggle);

  void toggle() => setState(() {
        isLogin = !isLogin;
      });
}
