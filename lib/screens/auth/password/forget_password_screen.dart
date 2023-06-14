import 'package:app_api_elancer/screens/auth/password/reset_password_screen.dart';
import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import '../../../controllers/auth_api_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helpers {

  late TextEditingController _emailTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
  }


  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FORGET PASSWORD'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'Enter email...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Reset code will be sent!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          AppTextField(hint: 'Email',
              prefixIcon: Icons.email,
              controller: _emailTextController),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () async => await performForgetPassword(),
            child: Text('SENT'),
            style: ElevatedButton.styleFrom(
              minimumSize : Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 15),

        ],
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
        context: context, message: 'Enter required data !', error: true);
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await AuthApiController().forgetPassword(
        context,
        email: _emailTextController.text);
    // if(status) Navigator.pushReplacementNamed(context, '/reset_password_screen');

    if (status) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            ResetPasswordScreen(email: _emailTextController.text),
        ),
      );
    }
  }
}


