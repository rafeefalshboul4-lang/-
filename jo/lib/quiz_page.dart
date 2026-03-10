import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  int? selectedIndex;
  bool answered = false;
  bool quizFinished = false;

  final AudioPlayer player = AudioPlayer();

  final List<Map<String, dynamic>> questions = [
    {
      "question": "ما هي عاصمة الأردن؟",
      "options": ["إربد", "عمان", "الزرقاء", "العقبة"],
      "correct": 1,
    },
    {
      "question": "أين تقع البترا؟",
      "options": ["معان", "عجلون", "السلط", "مادبا"],
      "correct": 0,
    },
    {
      "question": "البحر الميت يقع في؟",
      "options": ["الشمال", "الجنوب", "الشرق", "الغرب"],
      "correct": 1,
    },
    {
      "question": "جرش مشهورة بـ؟",
      "options": ["الآثار الرومانية", "البحر", "الجبال الثلجية", "الصحراء"],
      "correct": 0,
    },
    {
      "question": "قلعة عجلون تقع في؟",
      "options": ["الكرك", "الطفيلة", "عجلون", "العقبة"],
      "correct": 2,
    },
  ];

  void answerQuestion(int index) async {
    if (answered || quizFinished) return;

    setState(() {
      selectedIndex = index;
      answered = true;
    });

    bool isCorrect = index == questions[currentQuestion]["correct"];

    if (isCorrect) {
      score++;
      await player.play(AssetSource('audio/correct.mp3'));
    } else {
      await player.play(AssetSource('audio/wrong.mp3'));
    }

    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedIndex = null;
        answered = false;
      });
    } else {
      setState(() {
        quizFinished = true;
      });

      await player.play(AssetSource('audio/clap.mp3'));
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      selectedIndex = null;
      answered = false;
      quizFinished = false;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (quizFinished) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("النتيجة"),
          backgroundColor: const Color.fromRGBO(224, 209, 174, 1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "نتيجتك: $score / ${questions.length}",
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(224, 209, 174, 1),
                ),
                onPressed: restartQuiz,
                child: const Text("إعادة المحاولة"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("اختبار سياحي"),
        backgroundColor: const Color.fromRGBO(224, 209, 174, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              questions[currentQuestion]["question"],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ...List.generate(questions[currentQuestion]["options"].length, (
              index,
            ) {
              Color buttonColor = const Color.fromRGBO(224, 209, 174, 1);

              if (answered) {
                if (index == questions[currentQuestion]["correct"]) {
                  buttonColor = Colors.green;
                } else if (index == selectedIndex) {
                  buttonColor = Colors.red;
                }
              }

              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () => answerQuestion(index),
                  child: Text(
                    questions[currentQuestion]["options"][index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
