import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 34,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Instagram',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width < 600 ? 8 : 20,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        return const Column(
                          children: [
                            Stories(),
                            SizedBox(height: 18),
                            Post(),
                            SizedBox(height: 20),
                            Suggested(),
                            SizedBox(height: 80),
                          ],
                        );
                      }

                      return Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Stories(),
                                SizedBox(height: 18),
                                Post(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Expanded(
                            child: Suggested(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 62,
            decoration: BoxDecoration(
              color: const Color(0xFF202428),
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            Expanded(
              child: Story(
                name: 'Your story',
                image: 'assets/avatar1.jpeg',
                myStory: true,
              ),
            ),
            Expanded(
              child: Story(
                name: 'elegaant1_',
                image: 'assets/avatar2.jpeg',
              ),
            ),
            Expanded(
              child: Story(
                name: 'gmldusttm',
                image: 'assets/avatar3.jpeg',
              ),
            ),
            Expanded(
              child: Story(
                name: 'raff_book',
                image: 'assets/avatar4.jpeg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Story extends StatelessWidget {
  final String name;
  final String image;
  final bool myStory;

  const Story({
    super.key,
    required this.name,
    required this.image,
    this.myStory = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 78,
          height: 78,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.yellow,
                Colors.orange,
                Colors.pink,
                Colors.purple,
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
          ),
        ),
        const SizedBox(height: 7),
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage:
                    AssetImage('assets/profile.jpeg'),
              ),
              const SizedBox(width: 10),
              const Text(
                'redseafilm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 17,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const Icon(
                Icons.more_horiz,
                color: Colors.white,
                size: 27,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Image.asset(
          'assets/post.jpeg',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              ),
              const SizedBox(width: 5),
              const Text(
                '39',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 5),
              const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.repeat,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 5),
              const Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.send_outlined,
                color: Colors.white,
                size: 27,
              ),
              const SizedBox(width: 5),
              const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              const Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'redseafilm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'تبارك للمخرجة ماشيري إكوا...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'منذ 3 ساعات',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: Colors.blue,
                size: 8,
              ),
              SizedBox(width: 6),
              Icon(
                Icons.circle,
                color: Colors.grey,
                size: 7,
              ),
              SizedBox(width: 6),
              Icon(
                Icons.circle,
                color: Colors.grey,
                size: 7,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Suggested extends StatelessWidget {
  const Suggested({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 5,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 23,
              backgroundImage:
                  AssetImage('assets/avatar5.jpeg'),
            ),
            const SizedBox(width: 5),
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                  
                    children: [
                      Text(
                        'locabeautysa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Follow',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}