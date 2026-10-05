import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'min_page.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color background =
      Color(0xFFFFFCF8);

  static const Color textColor =
      Color(0xFF30343B);

  static const Color secondaryText =
      Color(0xFF989CA1);

  static const Color hintColor =
      Color(0xFFB2B5B8);

  static const Color borderColor =
      Color(0xFFE3DFDA);

  static const Color coral =
      Color(0xFFE99A88);

  static const Color yellow =
      Color(0xFFE7B957);

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final prefs =
          await SharedPreferences.getInstance();

      final savedEmail =
          prefs.getString('user_email');

      final savedPassword =
          prefs.getString('user_password');

      final enteredEmail =
          emailController.text.trim();

      final enteredPassword =
          passwordController.text;

      if (savedEmail == null ||
          savedPassword == null) {
        setState(() {
          isLoading = false;
        });

        _showMessage(
          'No account found. Create your space first.',
        );

        return;
      }

      if (enteredEmail != savedEmail ||
          enteredPassword != savedPassword) {
        setState(() {
          isLoading = false;
        });

        _showMessage(
          'Email or password is incorrect.',
        );

        return;
      }

      // Save login state
      await prefs.setBool(
        'is_logged_in',
        true,
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Welcome back to MUSE ✨',
      );

      await Future.delayed(
        const Duration(milliseconds: 700),
      );

      if (!mounted) return;

      // ==========================================================
      // GO TO HOME PAGE
      // ==========================================================

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const MinPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      _showMessage(
        'Something went wrong. Please try again.',
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 12,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            14,
            24,
            28,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ==================================================
                // BACK
                // ==================================================

                Align(
                  alignment:
                      Alignment.centerRight,

                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    padding: EdgeInsets.zero,

                    constraints:
                        const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                    ),

                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 22,
                    ),

                    color: textColor,
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // BRAND
                // ==================================================

                Center(
                  child: Column(
                    children: [

                      const Text(
                        'MUSE',

                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 29,
                          height: 1,
                          letterSpacing: 3.2,
                          fontWeight:
                              FontWeight.w500,
                          color: textColor,
                        ),
                      ),

                      const SizedBox(height: 9),

                      const Text(
                        'Your little space for ideas',

                        style: TextStyle(
                          fontFamily:
                              'serif',
                          fontSize: 13,
                          height: 1.3,
                          color:
                              secondaryText,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // ==================================================
                // HEADING
                // ==================================================

                const Text(
                  'Welcome back',

                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 22,
                    height: 1.15,
                    fontWeight:
                        FontWeight.w500,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Your little space is waiting for you.',

                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 12,
                    height: 1.45,
                    color: secondaryText,
                  ),
                ),

                const SizedBox(height: 28),

                // ==================================================
                // EMAIL
                // ==================================================

                _buildLabel(
                  'Email',
                  yellow,
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  controller:
                      emailController,

                  hint:
                      'Enter your email',

                  icon:
                      Icons.mail_outline_rounded,

                  iconColor:
                      yellow,

                  keyboardType:
                      TextInputType.emailAddress,

                  textInputAction:
                      TextInputAction.next,

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final email =
                        value.trim();

                    if (!email.contains('@') ||
                        !email.contains('.')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 33),

                // ==================================================
                // PASSWORD
                // ==================================================

                _buildLabel(
                  'Password',
                  coral,
                ),

                const SizedBox(height: 8),

                _buildTextField(
                  controller:
                      passwordController,

                  hint:
                      'Enter your password',

                  icon:
                      Icons.lock_outline_rounded,

                  iconColor:
                      coral,

                  obscureText:
                      obscurePassword,

                  textInputAction:
                      TextInputAction.done,

                  suffixIcon:
                      IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword =
                            !obscurePassword;
                      });
                    },

                    icon: Icon(
                      obscurePassword
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,

                      size: 20,

                      color:
                          secondaryText,
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },

                  onFieldSubmitted: (_) {
                    if (!isLoading) {
                      login();
                    }
                  },
                ),

                const SizedBox(height: 38),

                // ==================================================
                // LOGIN BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed:
                        isLoading
                            ? null
                            : login,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          coral,

                      foregroundColor:
                          Colors.white,

                      disabledBackgroundColor:
                          coral.withOpacity(
                        0.55,
                      ),

                      elevation: 0,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),

                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,

                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color:
                                  Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            children: [
                              Text(
                                'Enter my space',

                                style:
                                    TextStyle(
                                  fontFamily:
                                      'sans-serif',
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                              SizedBox(
                                width: 10,
                              ),

                              Icon(
                                Icons
                                    .arrow_forward_rounded,
                                size: 18,
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // SIGN UP
                // ==================================================

                Center(
                  child: Wrap(
                    alignment:
                        WrapAlignment.center,

                    children: [
                      const Text(
                        "Don't have an account? ",

                        style: TextStyle(
                          fontFamily:
                              'sans-serif',
                          fontSize: 13,
                          color:
                              secondaryText,
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const SignUpPage(),
                            ),
                          );
                        },

                        child: const Text(
                          'Create one',

                          style: TextStyle(
                            fontFamily:
                                'sans-serif',
                            fontSize: 13,
                            fontWeight:
                                FontWeight.w600,
                            color: coral,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(
    String text,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,

          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 8),

        Text(
          text,

          style: const TextStyle(
            fontFamily: 'serif',
            fontSize: 15,
            height: 1.2,
            fontWeight:
                FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
    required String? Function(String?) validator,

    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
    Widget? suffixIcon,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller:
          controller,

      keyboardType:
          keyboardType,

      textInputAction:
          textInputAction,

      obscureText:
          obscureText,

      onFieldSubmitted:
          onFieldSubmitted,

      style: const TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 13,
        color: textColor,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 12.5,
          fontWeight:
              FontWeight.w400,
          color: hintColor,
        ),

        prefixIcon: Icon(
          icon,
          size: 20,
          color: iconColor,
        ),

        suffixIcon:
            suffixIcon,

        filled: true,

        fillColor:
            Colors.white.withOpacity(0.58),

        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              const BorderSide(
            color: borderColor,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              const BorderSide(
            color: borderColor,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              BorderSide(
            color: iconColor,
            width: 1.2,
          ),
        ),

        errorBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(15),

          borderSide:
              const BorderSide(
            color: Colors.redAccent,
            width: 1.2,
          ),
        ),
      ),

      validator:
          validator,
    );
  }
}