class User {
  final String id;
  final String name;
  final String email;
  final String role; // 'student' or 'lecturer'

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
}

class Course {
  final String id;
  final String name;
  final String code;
  final double progress; // 0.0 to 1.0
  final String instructorName;
  final String instructorPhoto; // URL or asset path
  final List<Module> modules;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.progress,
    required this.instructorName,
    this.instructorPhoto = '',
    this.modules = const [],
  });
}

class Module {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final List<Material> materials;

  Module({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    this.materials = const [],
  });
}

class Material {
  final String id;
  final String moduleId;
  final String title;
  final String description;
  final bool isCompleted;
  final List<Content> contents;
  final bool hasAssignments;
  final bool hasQuizzes;

  Material({
    required this.id,
    required this.moduleId,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.contents = const [],
    this.hasAssignments = false,
    this.hasQuizzes = false,
  });
}

class Content {
  final String id;
  final String title;
  final ContentType type;
  final bool isCompleted;
  final String url;

  Content({
    required this.id,
    required this.title,
    required this.type,
    this.isCompleted = false,
    this.url = '#',
  });
}

enum ContentType { zoom, document, video, assignment, quiz, reading }

class Announcement {
  final String title;
  final String description;
  final DateTime date;

  Announcement({
    required this.title,
    required this.description,
    required this.date,
  });
}

class Assignment {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final DateTime deadline;
  final bool isSubmitted;

  Assignment({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.deadline,
    this.isSubmitted = false,
  });
}

enum CourseMaterialType { pdf, video, link, zoom }

class CourseMaterial {
  final String id;
  final String courseId;
  final String title;
  final CourseMaterialType type;
  final String url;

  CourseMaterial({
    required this.id,
    required this.courseId,
    required this.title,
    required this.type,
    required this.url,
  });
}

class Quiz {
  final String id;
  final String courseId;
  final String title;
  final int durationMinutes;
  final int questionCount;

  Quiz({
    required this.id,
    required this.courseId,
    required this.title,
    required this.durationMinutes,
    required this.questionCount,
  });
}

// New models for assignments, quizzes, and notifications

enum NotificationType { assignment, announcement, classUpdate, quiz }

class Notification {
  final String id;
  final String title;
  final String description;
  final NotificationType type;
  final DateTime timestamp;
  final bool isRead;
  final String? relatedId;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.timestamp,
    this.isRead = false,
    this.relatedId,
  });
}

enum SubmissionStatus { submitted, draft, late, notSubmitted }

enum GradingStatus { graded, pending, notGraded }

class AssignmentSubmission {
  final String assignmentId;
  final SubmissionStatus status;
  final GradingStatus gradingStatus;
  final DateTime? submittedAt;
  final DateTime? lastModified;
  final List<String> uploadedFiles;
  final double? grade;

  AssignmentSubmission({
    required this.assignmentId,
    required this.status,
    required this.gradingStatus,
    this.submittedAt,
    this.lastModified,
    this.uploadedFiles = const [],
    this.grade,
  });
}

class QuestionResult {
  final int questionNumber;
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;

  QuestionResult({
    required this.questionNumber,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
}

class QuizResult {
  final String quizId;
  final double score;
  final int totalQuestions;
  final int correctAnswers;
  final Duration duration;
  final DateTime completedAt;
  final List<QuestionResult> answers;

  QuizResult({
    required this.quizId,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.duration,
    required this.completedAt,
    this.answers = const [],
  });
}

class VideoContent {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final Duration duration;

  VideoContent({
    required this.id,
    required this.title,
    required this.description,
    this.thumbnailUrl = '',
    this.videoUrl = '#',
    required this.duration,
  });
}
