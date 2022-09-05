import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminLoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const AdminLoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<AdminLoginWidget> createState() => _AdminLoginWidgetState();
}

class _AdminLoginWidgetState extends State<AdminLoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Login Only")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Email"),
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Enter a valid email"
                      : null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.lock_open_outlined),
              label: const Text("Sign In as Admin"),
              onPressed: signIn,
            ),
            const SizedBox(
              height: 24,
            ),
            // RichText(
            //     text: TextSpan(
            //         style: const TextStyle(color: Colors.black),
            //         text: "Dont have an account?   ",
            //         children: [
            //       TextSpan(
            //           recognizer: TapGestureRecognizer()
            //             ..onTap = widget.onClickedSignUp,
            //           text: "Sign Up",
            //           style: const TextStyle(
            //               decoration: TextDecoration.underline,
            //               color: Colors.blue))
            //     ])),
          ]),
        ),
      ),
    );
  }

  Future signIn() async {
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    String theEmail = emailController.text.trim();

    if (theEmail.compareTo("admin1@delivery.com") == 0 ||
        theEmail.compareTo("admin2@delivery.com") == 0) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: theEmail, password: passwordController.text.trim());
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Ooops", e.message!,
            //e.message ? null : e.message,
            //icon: Icon(Icons.block, color: Colors.black),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("Ooops", "Wrong Email",
          //e.message ? null : e.message,
          //icon: Icon(Icons.block, color: Colors.black),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red);
    }

    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
