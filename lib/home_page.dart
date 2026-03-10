import 'package:flutter/material.dart';
import 'places_page.dart';
import 'video_page.dart';
import 'rating_page.dart';
import 'quiz_page.dart';
import 'main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCE1126), Colors.black],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "اكتشف الأردن 🇯🇴",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Jordan Tourism App",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            buildMenuCard(
              title: "الأماكن السياحية",
              icon: Icons.place,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlacesPage()),
                );
              },
            ),
            buildMenuCard(
              title: "شاهد فيديو",
              icon: Icons.video_collection,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideoPage()),
                );
              },
            ),
            buildMenuCard(
              title: "تقييم التطبيق",
              icon: Icons.star,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RatingPage()),
                );
              },
            ),
            buildMenuCard(
              title: "الكويز",
              icon: Icons.quiz,
              onTap: () {
                if (hasWatchedVideo) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يجب مشاهدة الفيديو قبل الدخول إلى الكويز'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 10),
            Icon(icon, size: 22, color: const Color(0xFFCE1126)),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
