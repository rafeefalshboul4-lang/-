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
  final TextEditingController noteController = TextEditingController();

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

  void sendNote() {
    if (noteController.text.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("تم إرسال الملاحظة ✅")));
      noteController.clear();
    }
  }

  @override
  void dispose() {
    player.dispose();
    noteController.dispose();
    super.dispose();
  }

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
      child: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFCE1126),
              width: double.infinity,
              child: const Text(
                "تقييم التطبيق",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) => buildStar(index)),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 40),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "اكتب ملاحظتك:",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 8),

                    TextField(
                      controller: noteController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: "اكتب ملاحظتك هنا...",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: sendNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            202,
                            15,
                            15,
                          ),
                        ),
                        child: const Text("إرسال"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
