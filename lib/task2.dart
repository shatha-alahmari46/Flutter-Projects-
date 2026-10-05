import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 21,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFB69AEF),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/pa.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Shatha Mohammed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF20202A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'AI Student',
                  style: TextStyle(
                    fontSize: 19,
                    color: Color(0xFF7044C6),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF7044C6),
                      size: 21,
                    ),
                    const SizedBox(width: 5),
                    const Flexible(
                      child: Text(
                        'Jeddah, Saudi Arabia',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Container(
                      height: 22,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 9),
                      color: Colors.grey,
                    ),
                    const Icon(
                      Icons.school_outlined,
                      color: Color(0xFF7044C6),
                      size: 21,
                    ),
                    const SizedBox(width: 5),
                    const Flexible(
                      child: Text(
                        'University of Jeddah',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E9FB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF7044C6),
                        size: 21,
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Passionate about Artificial Intelligence\n'
                          'and always eager to learn new things.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xFF4F4A58),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 220,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7044C6),
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(
                          Icons.arrow_forward,
                          size: 21,
                        ),
                      ],
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
}