import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int rating = 0;
  final AudioPlayer player = AudioPlayer();
  String message = "";

  void setRating(int value) async {
    setState(() {
      rating = value;

      if (rating == 1) {
        message = "ضعيف 😕";
      } else if (rating == 2) {
        message = "مقبول 🙂";
      } else if (rating == 3) {
        message = "جيد 😃";
      } else if (rating == 4) {
        message = "رائع 😍";
      } else if (rating == 5) {
        message = "ممتاز 🔥";
      }
    });

    // الصوت يشتغل فقط إذا التقييم 5
    if (rating == 5) {
      await player.play(AssetSource('audio/correct.mp3'));
    }
  }

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: index < rating ? Colors.amber : Colors.grey,
        size: 50,
      ),
      onPressed: () => setRating(index + 1),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تقييم التطبيق"),
        backgroundColor: const Color.fromARGB(255, 202, 15, 15),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) => buildStar(index)),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
