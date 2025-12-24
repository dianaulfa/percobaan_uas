import 'package:flutter/material.dart';

class GradesScreen extends StatelessWidget {
  const GradesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Nilai")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildGradeItem("Pemrograman Web Lanjut", "Tugas 1", 90),
                  const Divider(),
                  _buildGradeItem("Pemrograman Web Lanjut", "Kuis Bab 1", 85),
                  const Divider(),
                  _buildGradeItem("Kecerdasan Buatan", "Tugas A*", 88),
                  const Divider(),
                  _buildGradeItem("Etika Profesi", "Makalah", 95),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeItem(String course, String task, int score) {
    return ListTile(
      title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(task),
      trailing: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: score >= 85 ? Colors.green[100] : Colors.blue[100],
          shape: BoxShape.circle,
        ),
        child: Text(
          "$score",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: score >= 85 ? Colors.green[800] : Colors.blue[800],
          ),
        ),
      ),
    );
  }
}
