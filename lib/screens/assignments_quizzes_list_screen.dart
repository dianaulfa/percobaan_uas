import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../models/models.dart';
import '../widgets/bottom_nav_bar.dart';

class AssignmentsQuizzesListScreen extends StatelessWidget {
  const AssignmentsQuizzesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assignments = MockService.assignments;
    final quizzes = MockService.getQuizzes('c1');

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/dashboard'),
          ),
          title: const Text('Daftar Tugas & Kuis'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Assignments Section
            const Text(
              'Tugas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...assignments.map((assignment) {
              final submission = MockService.getSubmissionByAssignmentId(
                assignment.id,
              );
              final isCompleted =
                  submission?.status == SubmissionStatus.submitted;
              final daysRemaining = assignment.deadline
                  .difference(DateTime.now())
                  .inDays;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/assignment-submission',
                      arguments: assignment.id,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Blue progress bar
                          Container(
                            width: 8,
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),

                          // Content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.assignment,
                                        size: 20,
                                        color: Colors.red[400],
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          assignment.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    assignment.description,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Deadline: ${assignment.deadline.toString().split(' ')[0]} ($daysRemaining hari lagi)',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: daysRemaining < 2
                                          ? Colors.red
                                          : Colors.grey[500],
                                      fontWeight: daysRemaining < 2
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Checkmark
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              isCompleted
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isCompleted
                                  ? Colors.green
                                  : Colors.grey[300],
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Quizzes Section
            const Text(
              'Kuis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ...quizzes.map((quiz) {
              final hasResult =
                  MockService.getQuizResultByQuizId(quiz.id) != null;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    if (hasResult) {
                      Navigator.pushNamed(
                        context,
                        '/quiz-results',
                        arguments: quiz.id,
                      );
                    } else {
                      Navigator.pushNamed(context, '/quiz');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(13),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Blue bar
                          Container(
                            width: 8,
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),

                          // Content
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.quiz,
                                        size: 20,
                                        color: Colors.orange[400],
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          quiz.title,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${quiz.durationMinutes} menit • ${quiz.questionCount} soal',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Checkmark or start icon
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              hasResult
                                  ? Icons.check_circle
                                  : Icons.play_circle_outline,
                              color: hasResult
                                  ? Colors.green
                                  : Colors.blue[400],
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
