import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/register_screen.dart';
import 'package:flutter_application_1/screen/widgets/button.global.dart';
import 'package:flutter_application_1/screen/widgets/social.login.dart';
import 'package:flutter_application_1/screen/widgets/text.form.global.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_application_1/screen/Dashboard/dashboard_screen.dart';
import 'package:flutter_application_1/services/auth_services.dart'; // Import AuthServices
import 'dart:convert'; // Import json package

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _passwordVisibilityNotifier = ValueNotifier<bool>(true);

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Form tidak valid, tidak perlu melanjutkan proses login
      return;
    }

    try {
      final response = await AuthServices.login(
        emailController.text,
        passwordController.text,
      );

      if (response.statusCode == 200) {
        // Login berhasil, arahkan ke dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        // Login gagal, tampilkan pesan error
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String errorMessage = responseBody['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An unexpected error occurred. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/logo1.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      color: GlobalColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    textInputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    obscure: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email belum diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  ValueListenableBuilder<bool>(
                    valueListenable: _passwordVisibilityNotifier,
                    builder: (context, obscurePassword, child) {
                      return TextFormGlobal(
                        controller: passwordController,
                        text: 'Password',
                        textInputType: TextInputType.text,
                        obscure: obscurePassword,
                        showPasswordToggle: true,
                        icon: Icons.lock,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _passwordVisibilityNotifier.value = !obscurePassword;
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password belum diisi';
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  ButtonGlobal(
                    text: 'Sign In',
                    onTap: () {
                      login(context);
                    },
                  ),
                  const SizedBox(height: 50),
                  SocialLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an account? '),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
