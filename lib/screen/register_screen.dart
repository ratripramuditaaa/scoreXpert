import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/widgets/button.global.dart';
import 'package:flutter_application_1/screen/widgets/social.login.dart';
import 'package:flutter_application_1/screen/widgets/text.form.global.dart';
import 'package:flutter_application_1/utils/global.color.dart';
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/services/auth_services.dart'; // Import AuthServices
import 'dart:convert';
import 'package:flutter_application_1/utils/password_visibility_notifier.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final PasswordVisibilityNotifier passwordVisibilityNotifier = PasswordVisibilityNotifier(true);
  final PasswordVisibilityNotifier confirmPasswordVisibilityNotifier = PasswordVisibilityNotifier(true);

  Future<void> register(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await AuthServices.register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String errorMessage =
            responseBody['message'] ?? 'Registration failed. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
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
                  'Create a new account',
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                TextFormGlobal(
                  controller: nameController,
                  text: 'Name',
                  textInputType: TextInputType.text,
                  icon: Icons.person,
                  obscure: false,
                ),
                const SizedBox(height: 10),
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  textInputType: TextInputType.emailAddress,
                  icon: Icons.email,
                  obscure: false,
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: passwordVisibilityNotifier,
                  builder: (context, obscurePassword, child) {
                    return TextFormGlobal(
                      controller: passwordController,
                      text: 'Password',
                      textInputType: TextInputType.text,
                      icon: Icons.lock,
                      obscure: obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          passwordVisibilityNotifier.toggle();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ValueListenableBuilder<bool>(
                  valueListenable: confirmPasswordVisibilityNotifier,
                  builder: (context, obscureConfirmPassword, child) {
                    return TextFormGlobal(
                      controller: confirmPasswordController,
                      text: 'Confirm Password',
                      textInputType: TextInputType.text,
                      icon: Icons.lock,
                      obscure: obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          confirmPasswordVisibilityNotifier.toggle();
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  text: 'Sign Up',
                  onTap: () {
                    register(context);
                  },
                ),
                const SizedBox(height: 25),
                SocialLogin(),
              ],
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
            const Text("Already have an account? "),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Sign In',
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
