import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/spark.dart';

class CreateSparkPage extends StatefulWidget {
  const CreateSparkPage({super.key});

  @override
  State<CreateSparkPage> createState() => _CreateSparkPageState();
}

class _CreateSparkPageState extends State<CreateSparkPage> {
  // Form
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  // Category
  String? selectedCategory;

  final List<String> categories = [
    'Idea',
    'Project',
    'Inspiration',
    'Note',
  ];

  // MUSE colors
  static const Color backgroundColor = Color(0xFFFFFCF8);
  static const Color textColor = Color(0xFF30343B);
  static const Color secondaryText = Color(0xFF989CA1);
  static const Color hintColor = Color(0xFFB2B5B8);
  static const Color borderColor = Color(0xFFE3DFDA);

  static const Color coral = Color(0xFFE99A88);
  static const Color blue = Color(0xFF78BCD2);
  static const Color yellow = Color(0xFFE7B957);

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  // Submit form
Future<void> submitForm() async {
  FocusScope.of(context).unfocus();

  if (!_formKey.currentState!.validate()) {
    return;
  }

  final Spark spark = Spark(
    title: titleController.text.trim(),
    details: detailsController.text.trim(),
    category: selectedCategory!,
  );

  final SharedPreferences prefs =
      await SharedPreferences.getInstance();

  // Get existing sparks
  final List<String> savedSparks =
      prefs.getStringList('sparks') ?? [];

  // Add the new spark
  savedSparks.add(
    jsonEncode(spark.toMap()),
  );

  // Save all sparks
  await prefs.setStringList(
    'sparks',
    savedSparks,
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Spark added to MUSE ✨',
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );

  // Clear the form
  titleController.clear();
  detailsController.clear();

  setState(() {
    selectedCategory = null;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // App Bar
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: textColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'MUSE',
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: textColor,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            30,
          ),
          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ─────────────────────────
                // Header
                // ─────────────────────────

                const Text(
                  'Create a Spark',
                  style: TextStyle(
                    fontFamily: 'serif',
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Capture that little thought before it disappears.',
                  style: TextStyle(
                    fontFamily: 'sans-serif',
                    fontSize: 13,
                    color: secondaryText,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 34),

                // ─────────────────────────
                // Title
                // ─────────────────────────

                _buildLabel(
                  'Title',
                  blue,
                ),

                const SizedBox(height: 9),

                TextFormField(
                  controller: titleController,

                  textInputAction: TextInputAction.next,

                  maxLength: 50,

                  decoration: _inputDecoration(
                    hintText: 'What is on your mind?',
                    icon: Icons.lightbulb_outline_rounded,
                    iconColor: blue,
                  ).copyWith(
                    counterText: '',
                  ),

                  validator: (value) {
                    final title = value?.trim() ?? '';

                    if (title.isEmpty) {
                      return 'Please enter a title.';
                    }

                    if (title.length < 3) {
                      return 'Title must be at least 3 characters.';
                    }

                    if (title.length > 50) {
                      return 'Title must be 50 characters or less.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // ─────────────────────────
                // Details
                // ─────────────────────────

                _buildLabel(
                  'Details',
                  yellow,
                ),

                const SizedBox(height: 9),

                TextFormField(
                  controller: detailsController,

                  textInputAction: TextInputAction.newline,

                  minLines: 3,
                  maxLines: 4,

                  maxLength: 300,

                  decoration: _inputDecoration(
                    hintText: 'Tell us a little more...',
                    icon: Icons.notes_rounded,
                    iconColor: yellow,
                    alignIconTop: true,
                  ).copyWith(
                    counterText: '',
                  ),

                  validator: (value) {
                    final details = value?.trim() ?? '';

                    if (details.isEmpty) {
                      return 'Please add some details.';
                    }

                    if (details.length < 5) {
                      return 'Details must be at least 5 characters.';
                    }

                    if (details.length > 300) {
                      return 'Details must be 300 characters or less.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // ─────────────────────────
                // Category
                // ─────────────────────────

                _buildLabel(
                  'Category',
                  coral,
                ),

                const SizedBox(height: 9),

                DropdownButtonFormField<String>(
                  value: selectedCategory,

                  decoration: _inputDecoration(
                    hintText: 'Choose a category',
                    icon: Icons.auto_awesome_rounded,
                    iconColor: coral,
                  ),

                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: secondaryText,
                  ),

                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,

                      child: Text(
                        category,
                        style: const TextStyle(
                          fontFamily: 'sans-serif',
                          fontSize: 14,
                          color: textColor,
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please choose a category.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 38),

                // ─────────────────────────
                // Submit Button
                // ─────────────────────────

                SizedBox(
                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(
                    onPressed: submitForm,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: coral,
                      foregroundColor: Colors.white,

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: const Text(
                      'Add to MUSE',
                      style: TextStyle(
                        fontFamily: 'sans-serif',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ─────────────────────────
                // Footer
                // ─────────────────────────

                const Center(
                  child: Text(
                    'Your little ideas deserve a space.',
                    style: TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 12,
                      color: hintColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────
  // Label Widget
  // ─────────────────────────

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

        const SizedBox(width: 7),

        Text(
          text,
          style: const TextStyle(
            fontFamily: 'serif',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }

  // ─────────────────────────
  // Input Decoration
  // ─────────────────────────

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    required Color iconColor,
    bool alignIconTop = false,
  }) {
    return InputDecoration(
      hintText: hintText,

      hintStyle: const TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 13,
        color: hintColor,
      ),

      prefixIcon: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 10,
          top: alignIconTop ? 14 : 0,
        ),

        child: Icon(
          icon,
          size: 21,
          color: iconColor,
        ),
      ),

      prefixIconConstraints: const BoxConstraints(
        minWidth: 48,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),

      // Normal border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),

      // Enabled
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),

      // Focused
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: coral,
          width: 1.3,
        ),
      ),

      // Error
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1,
        ),
      ),

      // Focused + Error
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Colors.redAccent,
          width: 1.3,
        ),
      ),

      errorStyle: const TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 11,
        color: Colors.redAccent,
      ),
    );
  }
}