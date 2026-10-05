import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  static const purple = Color(0xFF7650C5);
  static const background = Color(0xFFF9F6FD);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showMessage('Please enter your email and password.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    final savedEmail = prefs.getString('user_email');
    final savedPassword = prefs.getString('user_password');

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (email == savedEmail && password == savedPassword) {
      showMessage('Login successful.');

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      Navigator.pop(context);
    } else {
      showMessage('Incorrect email or password.');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            // Top decoration
            Positioned(
              top: -95,
              right: -65,
              child: Container(
                width: 215,
                height: 215,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8DDF9),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              top: -73,
              right: -43,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),

            // Bottom decoration
            Positioned(
              bottom: -95,
              left: -65,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5D8F8),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              bottom: -72,
              left: -42,
              child: Container(
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
            ),

            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 45,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                        ),
                        color: const Color(0xFF67547F),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Icon
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E9FC),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: purple.withOpacity(0.22),
                            blurRadius: 28,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        size: 36,
                        color: purple,
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF332A40),
                      ),
                    ),

                    const SizedBox(height: 9),

                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA79BB2),
                      ),
                    ),

                    const SizedBox(height: 39),

                    _buildLabel('Email'),

                    _buildTextField(
                      controller: emailController,
                      hint: 'Enter your email',
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),

                    _buildLabel('Password'),

                    _buildTextField(
                      controller: passwordController,
                      hint: 'Enter your password',
                      icon: Icons.lock_outline_rounded,
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: const Color(0xFF9A8BAA),
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          showMessage('Password reset is not available yet.');
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 11,
                            color: purple,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF9569E0),
                              Color(0xFF7146BD),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: purple.withOpacity(0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 21,
                                  height: 21,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account? ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA79BB2),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: purple,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 7),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF70647B),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE1D8EA),
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF4B4055),
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFFC0B5C9),
            fontSize: 12,
          ),
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF9B85B5),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
        ),
      ),
    );
  }
}