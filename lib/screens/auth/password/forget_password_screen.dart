import 'package:app_api_elancer/screens/auth/password/reset_password_screen.dart';
import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
           Text(
            'Enter email...',
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
           Text(
            'Reset code will be sent!',
            style: TextStyle(
              color: Colors.green.shade400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _emailTextController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.green.shade200,
                letterSpacing: 1,
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.lock,color: Colors.green.shade400,),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.green.shade100,
                  strokeAlign: StrokeAlign.center,
                ),
              ),

              //************************************
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.green.shade400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async => await performForgetPassword(),
            child: Text('SENT'),
            style: ElevatedButton.styleFrom(
              minimumSize : Size(double.infinity, 50),
              backgroundColor: Colors.green.shade800,
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


