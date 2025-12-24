import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class AnnouncementsListScreen extends StatelessWidget {
  const AnnouncementsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock announcement data
    final announcements = [
      {
        'title': 'Maintenance Pro UAS Semester Genap 2020/2021',
        'date': '12 Maret 2021',
      },
      {
        'title': 'Pengumuman Wisuda',
        'date': '10 Maret 2021',
      },
      {
        'title': 'Maintenance Pro UAS Semester Genap 2020/2021',
        'date': '8 Maret 2021',
      },
    ];

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
          title: const Text('Pengumuman'),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.campaign, color: Color(0xFFD32F2F)),
                title: Text(
                  announcement['title']!,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(announcement['date']!),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/announcement-detail',
                    arguments: announcement,
                  );
                },
              ),
            );
          },
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      ),
    );
  }
}
