import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  static const purple = Color(0xFF7650C5);
  static const lightPurple = Color(0xFFF0E9FC);
  static const background = Color(0xFFF9F6FD);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> createAccount() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
    await prefs.setBool('is_registered', true);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    showMessage('Account created successfully.');

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
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
              top: -90,
              right: -65,
              child: Container(
                width: 210,
                height: 210,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8DDF9),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Top inner ring
            Positioned(
              top: -70,
              right: -45,
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

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 45,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),

                    // Back
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                        ),
                        color: const Color(0xFF67547F),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Icon
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: lightPurple,
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
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF332A40),
                      ),
                    ),

                    const SizedBox(height: 9),

                    const Text(
                      'Create your account and start your journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA79BB2),
                      ),
                    ),

                    const SizedBox(height: 36),

                    _buildLabel('Name'),

                    _buildTextField(
                      controller: nameController,
                      hint: 'Enter your name',
                      icon: Icons.person_outline_rounded,
                    ),

                    const SizedBox(height: 18),

                    _buildLabel('Email'),

                    _buildTextField(
                      controller: emailController,
                      hint: 'Enter your email',
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 18),

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

                    const SizedBox(height: 26),

                    // Create button
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
                          onPressed: isLoading ? null : createAccount,
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
                              : const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 19),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA79BB2),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log In',
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textAlign: TextAlign.left,
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