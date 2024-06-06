import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mnnit_gpt/Views/sign_up.dart';
import 'package:mnnit_gpt/Widgets/First_button.dart';
import 'package:mnnit_gpt/Widgets/simple_button.dart';
import 'package:mnnit_gpt/utils/constants.dart';
import 'package:mnnit_gpt/functions/Auth.dart';
import 'package:mnnit_gpt/utils/routes.dart';

Future<void> main() async {
  runApp(LoginScreen());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // This is for the Login
  final _formkey = GlobalKey<FormState>();
  String email="";
  String password="";
  bool initialCheckBox = true;
  String passwordStrength = 'Weak';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          reverse: true,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome back to login!',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Login to your account. Get easier than search engines results.',
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
                      validator: (value){
                        if(!value.toString().contains('@')){
                          return "Not a valid email";
                        }
                        else{
                          return null;
                        }
                      },
                      onSaved: (value){
                        setState(() {
                          email=value.toString();
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
                      onSaved: (value){
                        setState(() {
                          password=value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          color: Colors.grey,
                        ),
                        hintText: 'Create your Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  child: Row(
                    children: [
                      _buildPasswordStrengthIndicator(),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.redAccent, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
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
                      Text("Remember login info", style: TextStyle(
              color: Colors.grey, fontSize: 16
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                SimpleButton(text: "Login", backroundcolor: AppColors.Button_background, textcolor: Colors.white, height: 60, onPressed: (){
                  if(_formkey.currentState!.validate()){
                    _formkey.currentState!.save();
                    Sign(email, password);
                  }

                }, borderradius: 10, border_color: AppColors.Button_background),
                SizedBox(height: 10,),
                Center(
                  child: Text("Or sign in with using", style: TextStyle(
                      color: Colors.grey, fontSize: 16
                  ),),
                ),
                SizedBox(height: 10,),
                FirstButton(
                  text: 'Continue with Google',
                  backroundcolor: Colors.white,
                  textcolor: AppColors.Button_background,
                  height: 60,
                  onPressed: () {},
                  borderradius: 10,
                  icon: Icon(Icons.g_mobiledata, color: Colors.white,),
                  circle_avatar_Color: AppColors.Button_background,
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Don't have an account ?",style: TextStyle(
                      fontSize: 16,color: AppColors.text_color
                    ),),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp())
                        );},

                      child:  Text(" Create an Account",style: TextStyle(
                          fontSize: 16,color: AppColors.Button_background
                      ),),
                    )

                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Text and Color Settelement according to type
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
      alignment: Alignment.center,
      child: Text(
        'Password Strength: $passwordStrength',
        style: TextStyle(color: strengthColor),
      ),
    );
  }
}
