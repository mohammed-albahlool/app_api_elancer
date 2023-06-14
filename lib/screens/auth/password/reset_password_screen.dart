import 'package:app_api_elancer/utils/helpers.dart';
import 'package:app_api_elancer/widgets/app_text_field.dart';
import 'package:app_api_elancer/widgets/code_text_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key , required this.email}) : super(key: key);

  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with Helpers{

  late TextEditingController _newPasswordTextController;
  late TextEditingController _newPasswordConfirmationTextController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  String? _code ;


  @override
  void initState() {
    super.initState();

    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode  = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();

    _newPasswordTextController = TextEditingController();
    _newPasswordConfirmationTextController = TextEditingController();
  }

  @override
  void dispose() {
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    _newPasswordTextController.dispose();
    _newPasswordConfirmationTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RESET PASSWORD'),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children:  [
          const Text(
            'Enter new password...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'Enter new password and received code',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: CodeTextField(
                  textEditingController: _firstCodeTextController,
                  focusNode: _firstFocusNode,
                   onChanged: (value) {
                    if(value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                },),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  textEditingController: _secondCodeTextController,
                  focusNode: _secondFocusNode,
                  onChanged: (value) {
                      value.isNotEmpty
                      ? _thirdFocusNode.requestFocus()
                      : _firstFocusNode.requestFocus();
                    },
                  ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  textEditingController: _thirdCodeTextController,
                  focusNode: _thirdFocusNode,
                  onChanged: (value) {
                    value.isNotEmpty
                        ? _fourthFocusNode.requestFocus()
                        : _secondFocusNode.requestFocus();
                  },),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  textEditingController: _fourthCodeTextController,
                  focusNode: _fourthFocusNode,
                  onChanged: (value) {
                    if(value.isEmpty) _thirdFocusNode.requestFocus();

                      },
                  ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AppTextField(
              hint: 'Password',
              prefixIcon: Icons.lock,
              controller: _newPasswordTextController,
              obscureText: true,
          ),
          const SizedBox(height: 10),
          AppTextField(
            hint: 'Password Confirmation',
            prefixIcon: Icons.lock,
            controller: _newPasswordConfirmationTextController,
            obscureText: true,
          ),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () async => await performForgetPassword(),
              child: Text('SENT'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity  , 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ),
             const SizedBox(height: 15),

        ],
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if(checkData()){
      // await forgetPassword();
    }
  }

  bool checkData() {
    return false;
  }

  bool checkPassword(){
    if(_newPasswordTextController.text.isNotEmpty && _newPasswordConfirmationTextController.text.isNotEmpty){
      if(_newPasswordTextController.text == _newPasswordConfirmationTextController){
        return true;
      }
      showSnackBar(
          context: context,
          message: 'Password confirmation error!',
          error:  true
      );
    }
    showSnackBar(
        context: context,
        message: 'Enter new password!',
        error:  true
    );
    return false;
  }

  bool checkCode(){
    if(_firstCodeTextController.text.isNotEmpty&&
       _secondCodeTextController.text.isNotEmpty&&
       _thirdCodeTextController.text.isNotEmpty&&
       _fourthCodeTextController.text.isNotEmpty){
      getVerificationCode();
      return true;
    }
    showSnackBar(context: context, message: "Enter code", error: true);
    return false;
  }

  void getVerificationCode() {
    _code = _firstCodeTextController.text +
            _secondCodeTextController.text +
            _thirdCodeTextController.text +

            _fourthCodeTextController.text;

  }





  //   showSnackBar(context: context, message: 'Enter required data !', error: true);
  //   return false;
  // }
  // Future<void> forgetPassword() async  {
  //   bool status = await AuthApiController().forgetPassword(
  //       context,
  //       email: _emailTextController.text);
  //   //if(status) Navigator.pushReplacementNamed(context, '/categories_screen');
  //
  //   }
  // }



}





