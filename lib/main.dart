import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_page.dart';
import 'places_page.dart';
import 'video_page.dart';
import 'rating_page.dart';

// متغير عالمي لتتبع مشاهدة الفيديو
bool hasWatchedVideo = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    PlacesPage(),
    VideoPage(),
    RatingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'الأماكن',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'الفيديو',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'التقييم',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFCE1126),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
