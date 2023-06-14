import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_api_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{

  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = navigateToRegisterScreen;

  }

  void navigateToRegisterScreen(){
    Navigator.pushNamed(context, '/register_screen');
  }
  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children:  [
          const Text(
            'Welcome back...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Enter your email & password',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          AppTextField(hint: 'Email', prefixIcon: Icons.email, controller: _emailTextController),
          const SizedBox(height: 10),
          AppTextField(hint: 'Password', prefixIcon: Icons.lock, controller: _passwordTextController,obscureText: true),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async => await performLogin(),
              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity  , 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ),
             SizedBox(height: 15),
             RichText(
               textAlign: TextAlign.center,
                 text: TextSpan(
                   text: 'Don\'t hava  an account ? ',
                   style: const TextStyle(
                     color: Colors.black,
                   ),
                   children: [
                     const TextSpan(text: ''),
                     TextSpan(
                       recognizer: _tapGestureRecognizer,
                       text: 'Create Now!',
                       style: const TextStyle(
                         color: Colors.blue,
                       )
                     )
                   ],
                 ),
             ),
             TextButton(onPressed: () => Navigator.pushNamed(context, '/forget_password_screen'),
                 child: const Text('Forget Password?'))
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if(checkData()){
      await login();
    }
  }

  bool checkData() {
    if(_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data !', error: true);
    return false;
  }
  Future<void> login() async  {
    bool status = await AuthApiController().login(
        context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if(status) Navigator.pushReplacementNamed(context, '/categories_screen');
  }



}



