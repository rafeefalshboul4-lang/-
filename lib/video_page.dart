import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'quiz_page.dart';
import 'main.dart'; // للوصول للمتغير العالمي

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/jordan.mp4')
      ..initialize().then((_) {
        setState(() {}); // إعادة بناء الواجهة بعد التحميل
        _controller.setLooping(false); // بدون تكرار
      });

    // نضيف Listener لمراقبة نهاية الفيديو
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_controller.value.isPlaying) {
        setState(() {
          hasWatchedVideo = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goToQuiz() {
    if (hasWatchedVideo) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizPage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('يجب مشاهدة الفيديو أولاً')));
    }
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
                "Tourism Video",
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
            child: Center(
              child: _controller.value.isInitialized
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCE1126),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                          ),
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: goToQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFCE1126),
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 20,
                            ),
                          ),
                          child: const Text(
                            'اذهب إلى الكويز',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
