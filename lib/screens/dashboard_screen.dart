import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../widgets/bottom_nav_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockService.currentUser;
    final announcements = MockService.announcements.take(3).toList();

    // Find nearest upcoming assignment (not submitted)
    final now = DateTime.now();
    final upcoming =
        (MockService.assignments
                .where((a) => !a.isSubmitted && a.deadline.isAfter(now))
                .toList()
              ..sort((x, y) => x.deadline.compareTo(y.deadline)))
            .cast<dynamic>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Top Red Bar with Search + Notifications
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
                  child: Text(
                    'Selamat Datang, ${user.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/notifications'),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Upcoming Assignment Card
                        _buildUpcomingAssignmentCard(
                          context,
                          upcoming.isNotEmpty ? upcoming.first : null,
                        ),
                        const SizedBox(height: 12),

                        // Shortcuts row (Grades, Calendar)
                        Row(
                          children: [
                            Expanded(
                              child: _buildShortcutCard(
                                context,
                                'Nilai',
                                Icons.grade,
                                '/grades',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildShortcutCard(
                                context,
                                'Kalender',
                                Icons.calendar_today,
                                null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Announcements Section
                        const Text(
                          'Pengumuman Terkini',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...announcements
                            .map((a) => _buildAnnouncementTile(context, a))
                            .toList(),
                        const SizedBox(height: 16),

                        // Class Progress section
                        const Text(
                          'Progres Kelas',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.horizontal,
                            itemCount: MockService.myCourses.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) {
                              final c = MockService.myCourses[index];
                              return _buildCourseProgressCard(
                                context,
                                c.id,
                                c.name,
                                c.progress,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
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

  Widget _buildUpcomingAssignmentCard(
    BuildContext context,
    dynamic assignment,
  ) {
    if (assignment == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.assignment, size: 36, color: Color(0xFFD32F2F)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tidak ada tugas mendatang',
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final deadline = assignment.deadline as DateTime;
    final days = deadline.difference(DateTime.now()).inDays;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFD32F2F),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.assignment,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignment.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Deadline: ${deadline.toString().split(' ')[0]} • ${days} hari lagi',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/assignment-submission',
                  arguments: assignment.id,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD32F2F),
              ),
              child: const Text('Buka'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutCard(
    BuildContext context,
    String title,
    IconData icon,
    String? route,
  ) {
    return InkWell(
      onTap: () {
        if (route != null)
          Navigator.pushNamed(context, route);
        else
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Halaman belum tersedia')),
          );
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 4),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFD32F2F)),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnnouncementTile(BuildContext context, dynamic a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: const Icon(Icons.campaign, color: Color(0xFFD32F2F)),
        title: Text(
          a.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('${a.date.day}/${a.date.month}/${a.date.year}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () => Navigator.pushNamed(context, '/announcements'),
      ),
    );
  }

  Widget _buildCourseProgressCard(
    BuildContext context,
    String courseId,
    String title,
    double progress,
  ) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/course-detail', arguments: courseId),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: const Color(0xFFD32F2F),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% selesai',
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
