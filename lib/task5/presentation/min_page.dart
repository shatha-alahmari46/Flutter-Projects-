import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/spark.dart';
import 'create_spark.dart';

class MinPage extends StatefulWidget {
  const MinPage({super.key});

  @override
  State<MinPage> createState() => _MinPageState();
}

class _MinPageState extends State<MinPage> {
  List<Spark> sparks = [];

  // ─────────────────────────
  // MUSE Colors
  // ─────────────────────────

  static const Color backgroundColor = Color(0xFFFFFCF8);
  static const Color textColor = Color(0xFF30343B);
  static const Color secondaryText = Color(0xFF989CA1);
  static const Color hintColor = Color(0xFFB2B5B8);
  static const Color borderColor = Color(0xFFE3DFDA);

  static const Color coral = Color(0xFFE99A88);
  static const Color blue = Color(0xFF78BCD2);
  static const Color yellow = Color(0xFFE7B957);
  static const Color lavender = Color(0xFFB6A4CF);

  @override
  void initState() {
    super.initState();
    loadSparks();
  }

  // ─────────────────────────
  // Load Sparks
  // ─────────────────────────

  Future<void> loadSparks() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    final List<String> savedSparks =
        prefs.getStringList('sparks') ?? [];

    final List<Spark> loadedSparks = savedSparks.map((item) {
      final Map<String, dynamic> data =
          jsonDecode(item) as Map<String, dynamic>;

      return Spark.fromMap(data);
    }).toList();

    if (!mounted) return;

    setState(() {
      sparks = loadedSparks;
    });
  }

  // ─────────────────────────
  // Delete Spark
  // ─────────────────────────

  Future<void> deleteSpark(int index) async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    final List<String> savedSparks =
        prefs.getStringList('sparks') ?? [];

    if (index >= savedSparks.length) return;

    savedSparks.removeAt(index);

    await prefs.setStringList(
      'sparks',
      savedSparks,
    );

    if (!mounted) return;

    setState(() {
      sparks.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Spark removed from MUSE.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ─────────────────────────
  // Open Create Spark
  // ─────────────────────────

  Future<void> openCreateSpark() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSparkPage(),
      ),
    );

    await loadSparks();
  }

  // ─────────────────────────
  // Category
  // ─────────────────────────

  Color categoryColor(String category) {
    switch (category) {
      case 'Idea':
        return blue;

      case 'Project':
        return coral;

      case 'Inspiration':
        return yellow;

      case 'Note':
        return lavender;

      default:
        return blue;
    }
  }

  IconData categoryIcon(String category) {
    switch (category) {
      case 'Idea':
        return Icons.lightbulb_outline_rounded;

      case 'Project':
        return Icons.rocket_launch_outlined;

      case 'Inspiration':
        return Icons.auto_awesome_rounded;

      case 'Note':
        return Icons.notes_rounded;

      default:
        return Icons.auto_awesome_rounded;
    }
  }

  // ─────────────────────────
  // Build
  // ─────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            // ─────────────────────────
            // Header
            // ─────────────────────────

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  25,
                  24,
                  0,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // Brand
                    const Text(
                      'MUSE',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3.2,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 6),

               

                    const SizedBox(height: 36),

                    // Main title
                    const Text(
                      'Your little space',
                      style: TextStyle(
                        fontFamily: 'serif',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.1,
                        color: textColor,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ─────────────────────────
                    // Quote
                    // ─────────────────────────

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        15,
                        13,
                        15,
                        13,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F1ED),
                        borderRadius:
                            BorderRadius.circular(14),
                      ),

                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            '“',
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 25,
                              height: 0.8,
                              color: coral,
                            ),
                          ),

                          const SizedBox(width: 8),

                          const Expanded(
                            child: Text(
                              'Some ideas are meant to stay a little longer.',
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 13,
                                fontStyle: FontStyle.italic,
                                height: 1.35,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // ─────────────────────────
                    // Sparks Header
                    // ─────────────────────────

                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,

                      children: [
                        const Expanded(
                          child: Text(
                            'Your Sparks',
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                        ),

                        if (sparks.isNotEmpty)
                          _buildCountBadge(),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      sparks.isEmpty
                          ? 'A quiet space waiting for your ideas.'
                          : 'Little thoughts you decided to keep.',
                      style: const TextStyle(
                        fontFamily: 'serif',
                        fontSize: 11.5,
                        color: secondaryText,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // ─────────────────────────
            // Empty State
            // ─────────────────────────

            if (sparks.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(),
              )

            // ─────────────────────────
            // Sparks
            // ─────────────────────────

            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  24,
                  0,
                  24,
                  110,
                ),

                sliver: SliverList(
                  delegate:
                      SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildSparkCard(
                        sparks[index],
                        index,
                      );
                    },
                    childCount: sparks.length,
                  ),
                ),
              ),
          ],
        ),
      ),

      // ─────────────────────────
      // Create Spark Button
      // ─────────────────────────

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: openCreateSpark,

        backgroundColor: coral,
        foregroundColor: Colors.white,

        elevation: 2,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17),
        ),

        icon: const Icon(
          Icons.auto_awesome_rounded,
          size: 18,
        ),

        label: const Text(
          'Create a Spark',
          style: TextStyle(
            fontFamily: 'sans-serif',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ─────────────────────────
  // Count Badge
  // ─────────────────────────

  Widget _buildCountBadge() {
    return Container(
      width: 31,
      height: 31,

      alignment: Alignment.center,

      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
        ),
      ),

      child: Text(
        '${sparks.length}',
        style: const TextStyle(
          fontFamily: 'sans-serif',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: secondaryText,
        ),
      ),
    );
  }

  // ─────────────────────────
  // Spark Card
  // ─────────────────────────

  Widget _buildSparkCard(
    Spark spark,
    int index,
  ) {
    final Color color =
        categoryColor(spark.category);

    return GestureDetector(
      onTap: () {
        _showSparkDetails(
          spark,
          index,
        );
      },

      child: Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(20),

          border: Border.all(
            color: borderColor,
          ),
        ),

        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(20),

          child: Column(
            children: [
              // Category accent
              Container(
                height: 4,
                width: double.infinity,
                color: color.withValues(
                  alpha: 0.8,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.fromLTRB(
                  18,
                  16,
                  18,
                  17,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    // Category
                    Row(
                      children: [
                        Icon(
                          categoryIcon(
                            spark.category,
                          ),
                          size: 16,
                          color: color,
                        ),

                        const SizedBox(width: 7),

                        Text(
                          spark.category
                              .toUpperCase(),

                          style: TextStyle(
                            fontFamily:
                                'sans-serif',
                            fontSize: 9.5,
                            fontWeight:
                                FontWeight.w700,
                            letterSpacing: 1,
                            color: color,
                          ),
                        ),

                        const Spacer(),

                        Text(
                          '#${(index + 1).toString().padLeft(2, '0')}',
                          style:
                              const TextStyle(
                            fontFamily:
                                'sans-serif',
                            fontSize: 10,
                            color:
                                hintColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    // Title
                    Text(
                      spark.title,

                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontFamily: 'serif',
                        fontSize: 19,
                        fontWeight:
                            FontWeight.w600,
                        color: textColor,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Details
                    Text(
                      spark.details,

                      maxLines: 3,
                      overflow:
                          TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontFamily:
                            'sans-serif',
                        fontSize: 12.5,
                        height: 1.5,
                        color:
                            secondaryText,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Open hint
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Tap to open',
                            style: TextStyle(
                              fontFamily:
                                  'sans-serif',
                              fontSize: 10,
                              color:
                                  hintColor,
                            ),
                          ),
                        ),

                        Icon(
                          Icons
                              .arrow_forward_rounded,
                          size: 15,
                          color: color,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────
  // Spark Details
  // ─────────────────────────

  void _showSparkDetails(
    Spark spark,
    int index,
  ) {
    final Color color =
        categoryColor(spark.category);

    showModalBottomSheet(
      context: context,

      backgroundColor:
          backgroundColor,

      isScrollControlled: true,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),

      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(
              24,
              12,
              24,
              24,
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                // Handle
                Center(
                  child: Container(
                    width: 38,
                    height: 4,

                    decoration:
                        BoxDecoration(
                      color: borderColor,
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Category
                Row(
                  children: [
                    Icon(
                      categoryIcon(
                        spark.category,
                      ),
                      size: 18,
                      color: color,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      spark.category
                          .toUpperCase(),

                      style: TextStyle(
                        fontFamily:
                            'sans-serif',
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 1,
                        color: color,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Title
                Text(
                  spark.title,

                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w600,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 12),

                // Details
                Text(
                  spark.details,

                  style: const TextStyle(
                    fontFamily:
                        'sans-serif',
                    fontSize: 14,
                    height: 1.6,
                    color: secondaryText,
                  ),
                ),

                const SizedBox(height: 28),

                // Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );

                          _confirmDelete(
                            index,
                            spark.title,
                          );
                        },

                        icon: const Icon(
                          Icons
                              .delete_outline_rounded,
                          size: 19,
                        ),

                        label: const Text(
                          'Delete Spark',
                        ),

                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              coral,

                          side:
                              const BorderSide(
                            color: coral,
                          ),

                          minimumSize:
                              const Size(
                            0,
                            50,
                          ),

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─────────────────────────
  // Delete Confirmation
  // ─────────────────────────

  void _confirmDelete(
    int index,
    String title,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: backgroundColor,

          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),

          title: const Text(
            'Remove this Spark?',
            style: TextStyle(
              fontFamily: 'serif',
              fontSize: 20,
              fontWeight:
                  FontWeight.w600,
              color: textColor,
            ),
          ),

          content: Text(
            '"$title" will be removed from MUSE.',
            style: const TextStyle(
              fontFamily: 'sans-serif',
              fontSize: 13,
              height: 1.5,
              color: secondaryText,
            ),
          ),

          actionsPadding:
              const EdgeInsets.fromLTRB(
            18,
            0,
            18,
            18,
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: secondaryText,
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await deleteSpark(index);
              },

              child: const Text(
                'Remove',
                style: TextStyle(
                  color: coral,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─────────────────────────
  // Empty State
  // ─────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.fromLTRB(
          35,
          20,
          35,
          100,
        ),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 72,
              height: 72,

              decoration:
                  BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,

                border: Border.all(
                  color: borderColor,
                ),
              ),

              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 27,
                color: coral,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'A blank space, for now.',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 20,
                fontWeight:
                    FontWeight.w600,
                color: textColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Every idea starts somewhere.',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontFamily:
                    'sans-serif',
                fontSize: 13,
                color: secondaryText,
              ),
            ),

            const SizedBox(height: 18),

            TextButton(
              onPressed:
                  openCreateSpark,

              child: const Text(
                'Create your first Spark  →',

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
    );
  }
}