import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screens.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      showSnakBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //logo/svg imageX
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            SizedBox(height: 64),

            //input email text field
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email id!',
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            //input password text field
            TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your password!',
                textInputType: TextInputType.text,
                isPass: true),
            const SizedBox(
              height: 24,
            ),
            //log in button
            InkWell(
              onTap: loginUser,
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      child: const Text('Log in'),
                    ),
            ),
            SizedBox(height: 12),
            //transitioning to signup
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToSignUp,
                  child: Container(
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
