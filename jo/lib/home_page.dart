import 'package:flutter/material.dart';
import 'places_page.dart';
import 'video_page.dart';
import 'quiz_page.dart';
import 'rating_page.dart';

// متغير عالمي لتتبع مشاهدة الفيديو
bool hasWatchedVideo = false;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                context,
                title: "الأماكن السياحية",
                icon: Icons.place,
                page: const PlacesPage(),
              ),
              buildMenuCard(
                context,
                title: "شاهد فيديو",
                icon: Icons.video_collection,
                page: const VideoPage(),
              ),
              buildMenuCard(
                context,
                title: "اختبر معلوماتك",
                icon: Icons.quiz,
                page: const QuizPage(),
                isQuiz: true,
              ),
              buildMenuCard(
                context,
                title: "تقييم التطبيق",
                icon: Icons.star,
                page: const RatingPage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget page,
    bool isQuiz = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: InkWell(
        onTap: () {
          if (isQuiz && !hasWatchedVideo) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('يجب مشاهدة الفيديو قبل الدخول إلى الكويز'),
              ),
            );
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          }
        },
        borderRadius: BorderRadius.circular(18),
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
