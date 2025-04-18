import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartirregation/shared/remote/firebase_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);
    try {
      String? errorMessage = await FirebaseHelper.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (errorMessage == null)
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(errorMessage.substring(errorMessage.indexOf(' ')))),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // Background color from palette
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Logo or Title
                Center(
                  child: Column(
                    children: [
                      Text(
                        'AGRI IRRIGATION LOGIN',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B401D),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Image
                      Image.asset(
                        'assets/images/login.jpg',
                        width: 200, // Adjust width as needed
                        height: 200, // Adjust height as needed
                        fit: BoxFit.cover, // Adjust fit as needed
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Email Text Field
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email, color: Color(0xFF255929)),
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Text Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF255929)),
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      String? errorMessage =
                          await FirebaseHelper.forgotPassword(
                              email: emailController.text);
                      if (errorMessage == null)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Check your mailbox for the reset password message")),
                        );
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(errorMessage
                                  .substring(errorMessage.indexOf(' ')))),
                        );
                      }
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF255929),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(0xFF0C260E),
                      ))
                    : ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0C260E),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 20),

                // Sign-Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register_page');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFF255929)),
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
}
