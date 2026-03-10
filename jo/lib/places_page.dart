import 'package:flutter/material.dart';
import 'place_details_page.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final places = [
      {
        "title": "البتراء",
        "description":
            "البتراء مدينة أثرية تاريخية تقع في محافظة معان جنوب الأردن. "
            "تُعرف بالمدينة الوردية بسبب لون صخورها الوردي، "
            "وهي من عجائب الدنيا السبع الجديدة وتستقطب السياح من جميع أنحاء العالم.",
        "image": "assets/images/petra.jpg",
      },
      {
        "title": "وادي رم",
        "description":
            "وادي رم يُعرف بوادي القمر ويقع في جنوب الأردن. "
            "يتميز بتضاريسه الصحراوية المذهلة وجباله الشاهقة، "
            "ويُعد مكاناً مثالياً للمغامرات والتخييم ومشاهدة النجوم.",
        "image": "assets/images/wadirum.jpg",
      },
      {
        "title": "جرش",
        "description":
            "جرش من أهم المدن الأثرية في الأردن، "
            "وتحتوي على آثار رومانية محفوظة بشكل رائع مثل المدرج الروماني "
            "والأعمدة الحجرية التاريخية.",
        "image": "assets/images/jerash.jpg",
      },
      {
        "title": "إربد",
        "description":
            "إربد مدينة شمالية تُعرف بعروس الشمال، "
            "وتتميز بجامعاتها وأسواقها الشعبية وقربها من المواقع الأثرية "
            "مثل أم قيس وبيت راس.",
        "image": "assets/images/Irbid.jpg",
      },
      {
        "title": "عجلون",
        "description":
            "عجلون مدينة جبلية جميلة تشتهر بقلعة عجلون التاريخية "
            "وغاباتها الخضراء الكثيفة، وهي وجهة رائعة لمحبي الطبيعة والهدوء.",
        "image": "assets/images/Ajloun.jpg",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("الأماكن السياحية في الأردن"),
        backgroundColor: const Color(0xFFCE1126),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFCE1126), Colors.black],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // صورة المعلم
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        place["image"]!,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      title: Text(
                        place["title"]!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCE1126),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          place["description"]!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaceDetailsPage(
                              title: place["title"]!,
                              description: place["description"]!,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
