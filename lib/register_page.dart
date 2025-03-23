import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartirregation/shared/remote/firebase_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> registerUser() async {
    setState(() => isLoading = true);
    if (passwordController.text != confirmPasswordController.text) {
      showSnackbar('Passwords do not match');
      return;
    }

    try {
      String? errorMessage = await FirebaseHelper.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (errorMessage == null) {
        showSnackbar('Registration successful!');
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(errorMessage.substring(errorMessage.indexOf(' ')))),
        );
      }
    } catch (e) {
      showSnackbar(e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Light background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    'AGRI IRRIGATION REGISTER',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B401D), // Primary color
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Email TextField
                buildTextField('Email', Icons.email, emailController, false),
                const SizedBox(height: 20),

                // Password TextField
                buildTextField(
                    'Password', Icons.lock, passwordController, true),
                const SizedBox(height: 20),

                // Confirm Password TextField
                buildTextField('Confirm Password', Icons.lock,
                    confirmPasswordController, true),
                const SizedBox(height: 20),

                // Register Button
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFF1B401D),
                      ))
                    : ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF1B401D), // Primary color
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 20),

                // Back to Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xFF255929)), // Secondary color
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint, IconData icon,
      TextEditingController controller, bool isObscure) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: isObscure ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon:
            Icon(icon, color: const Color(0xFF255929)), // Secondary color
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
