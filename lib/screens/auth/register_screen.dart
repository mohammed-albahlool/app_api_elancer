import 'package:app_api_elancer/controllers/auth_api_controller.dart';
import 'package:app_api_elancer/model/student.dart';
import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers{

  late TextEditingController _fullNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String _gender = 'M';

  @override
  void initState() {
    super.initState();
    _fullNameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    _fullNameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children:  [
          const Text(
            'Create new account ...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Enter details blow',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          AppTextField(hint: 'Full Name', prefixIcon: Icons.person, controller: _fullNameTextController),
          const SizedBox(height: 10),
          AppTextField(hint: 'Email', prefixIcon: Icons.email, controller: _emailTextController),
          const SizedBox(height: 10),
          AppTextField(hint: 'Password', prefixIcon: Icons.lock, controller: _passwordTextController,obscureText: true),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Male'),
                  contentPadding: EdgeInsets.zero,
                  value: 'M',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    if(value != null){
                      setState(() {
                        _gender = value;
                      });
                    }
                  },
                ),
              ),

              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Female'),
                  contentPadding: EdgeInsets.zero,
                  value: 'F',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    if(value != null){
                      setState(() {
                        _gender = value;
                      });
                    }
                  },
                ),
              ),



            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async => await performRegister(),
              child: Text('REGISTER'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity  , 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ),
        ],
      ),
    );
  }

  Future<void> performRegister() async {
    if(checkData()){
      await register();
    }
  }

  bool checkData() {
    if(_fullNameTextController.text.isNotEmpty &&
       _emailTextController.text.isNotEmpty &&
       _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data !', error: true);
    return false;
  }
  Future<void> register() async  {
    bool status = await AuthApiController().register(context, student: student);
    if(status) Navigator.pop(context);
  }
  Student get student {
    Student student = Student();
    student.fullName = _fullNameTextController.text;
    student.email = _emailTextController.text;
    student.password = _passwordTextController.text;
    student.gender = _gender;
    return student;
  }

}



