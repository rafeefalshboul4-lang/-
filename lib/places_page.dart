import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'place_details_page.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  Future<void> _openMap(double lat, double lng) async {
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final places = [
      {
        "title": "البتراء",
        "description":
            "البتراء مدينة أثرية تاريخية تقع في محافظة معان جنوب الأردن.",
        "image": "assets/images/petra.jpg",
        "lat": 30.3285,
        "lng": 35.4444,
      },
      {
        "title": "وادي رم",
        "description": "وادي رم يُعرف بوادي القمر ويقع في جنوب الأردن.",
        "image": "assets/images/wadirum.jpg",
        "lat": 29.5734,
        "lng": 35.4195,
      },
      {
        "title": "جرش",
        "description": "جرش من أهم المدن الأثرية في الأردن.",
        "image": "assets/images/jerash.jpg",
        "lat": 32.2746,
        "lng": 35.8910,
      },
      {
        "title": "إربد",
        "description": "إربد مدينة شمالية تُعرف بعروس الشمال.",
        "image": "assets/images/Irbid.jpg",
        "lat": 32.5569,
        "lng": 35.8479,
      },
      {
        "title": "عجلون",
        "description": "عجلون مدينة جبلية جميلة تشتهر بقلعة عجلون.",
        "image": "assets/images/Ajloun.jpg",
        "lat": 32.3326,
        "lng": 35.7516,
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
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        place["image"] as String,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      title: Text(
                        place["title"] as String,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCE1126),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          place["description"] as String,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      onTap: () {
                        _openMap(
                          place["lat"] as double,
                          place["lng"] as double,
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
