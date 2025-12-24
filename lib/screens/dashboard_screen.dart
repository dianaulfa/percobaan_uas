import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockService.currentUser;
    final announcements = MockService.announcements.take(3).toList();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Top Red Bar with Search
          Container(
            color: const Color(0xFFD32F2F),
            padding: const EdgeInsets.only(
              top: 40,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notifications');
                  },
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Welcome Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Selamat Datang, ${user.name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Colorful Cards Section
                  _buildColorfulCard(
                    'Tugas Mendatang',
                    const Color(0xFFD32F2F),
                    Icons.assignment,
                    context,
                  ),
                  _buildColorfulCard(
                    'Kelas Saya',
                    const Color(0xFFE57373),
                    Icons.book,
                    context,
                  ),
                  _buildColorfulCard(
                    'Pengumuman',
                    const Color(0xFF757575),
                    Icons.campaign,
                    context,
                  ),
                  _buildColorfulCard(
                    'Nilai',
                    const Color(0xFF9E9E9E),
                    Icons.grade,
                    context,
                  ),
                  _buildColorfulCard(
                    'Kalender Akademik',
                    const Color(0xFFBDBDBD),
                    Icons.calendar_today,
                    context,
                  ),
                  _buildColorfulCard(
                    'E-Library',
                    const Color(0xFF616161),
                    Icons.library_books,
                    context,
                  ),
                  _buildColorfulCard(
                    'Forum Diskusi',
                    const Color(0xFFEF5350),
                    Icons.forum,
                    context,
                  ),

                  const SizedBox(height: 16),

                  // Recent Announcements
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Pengumuman Terbaru",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...announcements.map(
                    (a) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.campaign,
                            color: Color(0xFFD32F2F),
                          ),
                          title: Text(
                            a.title,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(
                            '${a.date.day}/${a.date.month}/${a.date.year}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/announcements');
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildColorfulCard(
    String title,
    Color color,
    IconData icon,
    BuildContext context,
  ) {
    // Map titles to routes
    final routes = {
      'Tugas Mendatang': '/assignments-quizzes',
      'Kelas Saya': '/my-classes',
      'Pengumuman': '/announcements',
      'Nilai': '/grades',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () {
          final route = routes[title];
          if (route != null) {
            Navigator.pushNamed(context, route);
          }
        },
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: color.withAlpha(26),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
