import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children:  [
            Text(
            'Welcome back...',
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
           Text(
            'Enter your email & password',
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
          const SizedBox(height: 15),
          TextField(
            controller: _passwordTextController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
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
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () async  {await performLogin();
                print("tttt");
                },

              child: Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity  , 50),
                backgroundColor: Colors.green.shade800,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),

                ),
              ),
              ),
             SizedBox(height: 25),
             RichText(
               textAlign: TextAlign.center,
                 text: TextSpan(
                   text: 'Don\'t hava  an account ? ',
                   style:  TextStyle(
                     color: Colors.green.shade400,
                   ),
                   children: [
                     const TextSpan(text: ''),
                     TextSpan(
                       recognizer: _tapGestureRecognizer,
                       text: 'Create Now!',
                       style:  TextStyle(
                         color: Colors.green.shade800,
                         fontWeight: FontWeight.bold
                       )
                     )
                   ],
                 ),
             ),
             TextButton(onPressed: () => Navigator.pushNamed(context, '/forget_password_screen'),
                 child:   Text('Forget Password?', style: TextStyle(
                     color: Colors.green.shade800,
                   fontWeight: FontWeight.bold
                     ),
                 ),
             )
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



