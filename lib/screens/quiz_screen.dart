import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedAnswer = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kuis Bab 1")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Soal 1 dari 20"),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    "29:45",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Framework PHP yang menggunakan konsep MVC adalah?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            ListTile(
              title: const Text("Laravel"),
              leading: Radio<int>(
                value: 0,
                groupValue: _selectedAnswer,
                onChanged: (val) => setState(() => _selectedAnswer = val!),
              ),
              onTap: () => setState(() => _selectedAnswer = 0),
            ),
            ListTile(
              title: const Text("React"),
              leading: Radio<int>(
                value: 1,
                groupValue: _selectedAnswer,
                onChanged: (val) => setState(() => _selectedAnswer = val!),
              ),
              onTap: () => setState(() => _selectedAnswer = 1),
            ),
            ListTile(
              title: const Text("Flutter"),
              leading: Radio<int>(
                value: 2,
                groupValue: _selectedAnswer,
                onChanged: (val) => setState(() => _selectedAnswer = val!),
              ),
              onTap: () => setState(() => _selectedAnswer = 2),
            ),
            ListTile(
              title: const Text("Spring Boot"),
              leading: Radio<int>(
                value: 3,
                groupValue: _selectedAnswer,
                onChanged: (val) => setState(() => _selectedAnswer = val!),
              ),
              onTap: () => setState(() => _selectedAnswer = 3),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Show result dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Kuis Selesai"),
                      content: const Text(
                        "Nilai Anda: 100\nReview: Jawaban Benar semua.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Back to class
                          },
                          child: const Text("Tutup"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text("Submit & Selesai"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
