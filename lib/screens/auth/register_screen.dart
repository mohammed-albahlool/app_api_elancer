import 'package:app_api_elancer/controllers/auth_api_controller.dart';
import 'package:app_api_elancer/model/student.dart';
import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        backgroundColor: Colors.green.shade800,
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children:  [
           Text(
            'Create new account ...',
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
           Text(
            'Enter details blow',
            style: TextStyle(
              color: Colors.green.shade400,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _fullNameTextController,
            decoration: InputDecoration(
              hintText: 'FullName',
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.green.shade200,
                letterSpacing: 1,
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.person,color: Colors.green.shade400,),
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
            controller: _emailTextController,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w300,
                color: Colors.green.shade200,
                letterSpacing: 1,
                fontSize: 14,
              ),
              prefixIcon: Icon(Icons.email,color: Colors.green.shade400,),
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
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  selectedTileColor: Colors.green,
                  title:  Text('Male',style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold),),
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
                  activeColor: Colors.green,
                ),
              ),

              Expanded(
                child: RadioListTile<String>(
                  title:  Text('Female',style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),),
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
                  activeColor: Colors.green,
                ),
              ),



            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async => await performRegister(),
              child: Text('REGISTER'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
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



