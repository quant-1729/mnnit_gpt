import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/login_page.dart';
import 'package:mnnit_gpt/Widgets/First_button.dart';
import 'package:mnnit_gpt/Widgets/simple_button.dart';
import 'package:mnnit_gpt/models/user_model.dart';
import 'package:mnnit_gpt/utils/constants.dart';
import 'package:mnnit_gpt/functions/Auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SignUpPage());
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserModel userModel = UserModel();
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool initialCheckBox = true;
  String passwordStrength = 'Weak';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 40,),
                    Text(
                      'Create an Account',
                      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Sign Up for a free Account. Get easier than search engines results.',
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFCCCBFE)),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1),
                        child: TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (!value.toString().contains('@')) {
                              return "Not a valid email";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            setState(() {
                              email = value.toString();
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              CupertinoIcons.mail,
                              color: Colors.grey,
                            ),
                            suffixIcon: Icon(
                              CupertinoIcons.eye,
                              color: Colors.grey,
                            ),
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFCCCBFE)),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(1),
                        child: TextFormField(
                          key: ValueKey('password'),
                          obscureText: true,
                          onChanged: (value) {
                            final strength = _calculatePasswordStrength(value);
                            setState(() {
                              passwordStrength = strength;
                            });
                            print('Password strength: $strength');
                          },
                          onSaved: (value) {
                            setState(() {
                              password = value.toString();
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Colors.grey,
                            ),
                            hintText: 'Enter Your Password',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    _buildPasswordStrengthIndicator(),
                    SizedBox(height: 16.0),
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: initialCheckBox,
                            onChanged: (bool? value) {
                              setState(() {
                                initialCheckBox = value!;
                              });
                            },
                            checkColor: Colors.grey,
                          ),
                          SizedBox(width: 8,),
                          Text("Save password", style: TextStyle(
                              color: Colors.grey, fontSize: 16
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    SimpleButton(text: "Create Account", backroundcolor: AppColors.Button_background, textcolor: Colors.white, height: 60, onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        userModel.email = email;
                        Sign_Up(email, password, context);
                      }
                    }, borderradius: 10, border_color: AppColors.Button_background),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add some space before the bottom widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Already have an account ?", style: TextStyle(
                      fontSize: 16, color: AppColors.text_color
                  ),),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()
                        ),
                      );
                    },
                    child: Text("SignIn Instead", style: TextStyle(
                        fontSize: 16, color: AppColors.Button_background
                    ),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _calculatePasswordStrength(String password) {
    if (password.length < 8) {
      return 'Weak';
    } else if (password.length >= 8 && password.length <= 11) {
      if (_containsCommonPatterns(password)) {
        return 'Medium';
      } else {
        return 'Strong';
      }
    } else {
      if (_containsCommonPatterns(password)) {
        return 'Medium';
      } else if (_containsAllCharacterTypes(password)) {
        return 'Strong';
      } else {
        return 'Medium';
      }
    }
  }

  bool _containsCommonPatterns(String password) {
    final commonPatterns = ['password', '123456', 'qwerty'];
    return commonPatterns.any((pattern) => password.toLowerCase().contains(pattern));
  }

  bool _containsAllCharacterTypes(String password) {
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*()\-_=+[\]{}|;:\,.<>?/`~]'));
    return hasLowercase && hasUppercase && hasNumber && hasSpecialChar;
  }

  Widget _buildPasswordStrengthIndicator() {
    Color strengthColor;
    switch (passwordStrength) {
      case 'Weak':
        strengthColor = Colors.red;
        break;
      case 'Medium':
        strengthColor = Colors.yellow;
        break;
      case 'Strong':
        strengthColor = Colors.green;
        break;
      default:
        strengthColor = Colors.grey;
    }

    return Container(
      child: Text(
        'Password Strength: $passwordStrength',
        style: TextStyle(color: strengthColor),
      ),
    );
  }
}
