import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../models/models.dart' as models;

class MaterialDetailScreen extends StatefulWidget {
  final String materialId;
  const MaterialDetailScreen({super.key, required this.materialId});

  @override
  State<MaterialDetailScreen> createState() => _MaterialDetailScreenState();
}

class _MaterialDetailScreenState extends State<MaterialDetailScreen> {
  int _selectedTab = 0; // 0 = Lompatan Materi, 1 = Tugas dan Kuis

  @override
  Widget build(BuildContext context) {
    // Find material by searching through all courses/modules
    models.Material? material;
    for (var course in MockService.myCourses) {
      for (var module in course.modules) {
        try {
          material = module.materials.firstWhere(
            (m) => m.id == widget.materialId,
          );
          break;
        } catch (e) {
          continue;
        }
      }
      if (material != null) break;
    }

    if (material == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Material Not Found')),
        body: const Center(child: Text('Material not found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Detail Materi'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    material.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Tabs
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  _buildTab('Lompatan Materi', 0),
                  _buildTab('Tugas dan Kuis', 1),
                ],
              ),
            ),

            const Divider(height: 1),
            const SizedBox(height: 16),

            // Tab Content
            _selectedTab == 0
                ? _buildLompatanMateriTab(material)
                : _buildTugasKuisTab(material),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? const Color(0xFFD32F2F)
                    : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? const Color(0xFFD32F2F) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLompatanMateriTab(models.Material material) {
    if (material.contents.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(child: Text('Tidak ada konten tersedia')),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: material.contents.length,
      itemBuilder: (context, index) {
        final content = material.contents[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              if (content.type == models.ContentType.assignment) {
                Navigator.pushNamed(
                  context,
                  '/assignment-submission',
                  arguments:
                      content.id, // Using content ID as assignment ID for mock
                );
              } else if (content.type == models.ContentType.quiz) {
                Navigator.pushNamed(context, '/quiz', arguments: content.id);
              } else if (content.type == models.ContentType.video) {
                Navigator.pushNamed(
                  context,
                  '/video-player',
                  arguments: content.id,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(
                    _getIconForContentType(content.type),
                    size: 22,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      content.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(
                    content.isCompleted
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: content.isCompleted
                        ? Colors.green
                        : Colors.grey[400],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTugasKuisTab(models.Material material) {
    if (!material.hasAssignments && !material.hasQuizzes) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.assignment_outlined, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text(
              'Tidak Ada Tugas Dan Kuis Hari Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Show assignments/quizzes from material contents
    final assignments = material.contents
        .where(
          (c) =>
              c.type == models.ContentType.assignment ||
              c.type == models.ContentType.quiz,
        )
        .toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final content = assignments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              if (content.type == models.ContentType.assignment) {
                Navigator.pushNamed(
                  context,
                  '/assignment-submission',
                  arguments: content.id,
                );
              } else if (content.type == models.ContentType.quiz) {
                Navigator.pushNamed(context, '/quiz', arguments: content.id);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  Icon(
                    content.type == models.ContentType.assignment
                        ? Icons.assignment
                        : Icons.quiz,
                    size: 22,
                    color: Colors.blue[400],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      content.title,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(
                    content.isCompleted
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: content.isCompleted
                        ? Colors.green
                        : Colors.grey[400],
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForContentType(models.ContentType type) {
    return switch (type) {
      models.ContentType.zoom => Icons.video_camera_front,
      models.ContentType.document => Icons.description,
      models.ContentType.video => Icons.play_circle_outline,
      models.ContentType.assignment => Icons.assignment,
      models.ContentType.quiz => Icons.quiz,
      models.ContentType.reading => Icons.menu_book,
    };
  }
}
