import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../models/models.dart' as models;

class ClassDetailScreen extends StatelessWidget {
  final String courseId;
  const ClassDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Find course or return a placeholder if not found
    final course = MockService.myCourses.firstWhere(
      (c) => c.id == courseId,
      orElse: () => models.Course(
        id: '0',
        name: 'Unknown',
        code: '000',
        progress: 0,
        instructorName: 'Unknown',
      ),
    );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(course.name),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Materi"),
              Tab(text: "Tugas"),
              Tab(text: "Kuis"),
              Tab(text: "Peserta"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _MateriTab(courseId: courseId),
            _TugasTab(courseId: courseId),
            _KuisTab(courseId: courseId),
            _PesertaTab(courseId: courseId),
          ],
        ),
      ),
    );
  }
}

class _MateriTab extends StatelessWidget {
  final String courseId;
  const _MateriTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final materials = MockService.getMaterials(courseId);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        final item = materials[index];
        IconData icon;
        Color color;

        switch (item.type) {
          case models.CourseMaterialType.pdf:
            icon = Icons.picture_as_pdf;
            color = Colors.red;
            break;
          case models.CourseMaterialType.video:
            icon = Icons.play_circle_fill;
            color = Colors.blue;
            break;
          case models.CourseMaterialType.zoom:
            icon = Icons.video_camera_front;
            color = Colors.blueAccent;
            break;
          case models.CourseMaterialType.link:
            icon = Icons.link;
            color = Colors.green;
        }

        return Card(
          child: ListTile(
            leading: Icon(icon, color: color, size: 32),
            title: Text(item.title),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Simulated open action
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Opening ${item.title}...")),
              );
            },
          ),
        );
      },
    );
  }
}

class _TugasTab extends StatelessWidget {
  final String courseId;
  const _TugasTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Basic filter simulation (assuming all assignments belong to the course in mock)
    // Real implementation would filter by courseId
    final assignments = MockService.assignments
        .where((a) => a.courseId == courseId || a.courseId == 'c1')
        .toList();

    if (assignments.isEmpty) {
      return const Center(child: Text("Belum ada tugas"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final item = assignments[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.assignment, color: Color(0xFFD32F2F)),
            title: Text(item.title),
            subtitle: Text(
              "Deadline: ${item.deadline.toString().split(' ')[0]}",
            ),
            trailing: item.isSubmitted
                ? const Icon(Icons.check_circle, color: Colors.green)
                : const Icon(Icons.circle_outlined, color: Colors.grey),
            onTap: () {
              Navigator.pushNamed(context, '/assignment-submission');
            },
          ),
        );
      },
    );
  }
}

class _KuisTab extends StatelessWidget {
  final String courseId;
  const _KuisTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final quizzes = MockService.getQuizzes(courseId);
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        final item = quizzes[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.timer, color: Colors.orange),
            title: Text(item.title),
            subtitle: Text(
              "${item.durationMinutes} menit • ${item.questionCount} soal",
            ),
            onTap: () {
              Navigator.pushNamed(context, '/quiz');
            },
          ),
        );
      },
    );
  }
}

class _PesertaTab extends StatelessWidget {
  final String courseId;
  const _PesertaTab({required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Hardcoded participants
    final participants = [
      "Ahmad Dani",
      "Siti Aminah",
      "Budi Santoso (You)",
      "Citra Kirana",
      "Doni Tata",
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: participants.length,
      separatorBuilder: (c, i) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text(participants[index][0]),
          ),
          title: Text(participants[index]),
          subtitle: const Text("Mahasiswa"),
        );
      },
    );
  }
}
