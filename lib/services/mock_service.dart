import '../models/models.dart';

class MockService {
  static final User currentUser = User(
    id: 'u1',
    name: 'Budi Santoso',
    email: 'budi@student.university.ac.id',
    role: 'student',
  );

  static final List<Course> myCourses = [
    Course(
      id: 'c1',
      name: 'User Interface Design',
      code: 'UX',
      progress: 0.75,
      instructorName: 'Dandy Candra Pratama',
      instructorPhoto: 'instructor_photo',
      modules: [
        Module(
          id: 'm1',
          courseId: 'c1',
          title: 'Pertemuan 1',
          description:
              'MATERI MINGGU PERTAMA DAN ILUSTRASI COURSE - IF-43-GL [UXD]',
          materials: [
            Material(
              id: 'mat1',
              moduleId: 'm1',
              title: 'Pengantar User Interface Design',
              description:
                  'Pertemuan pertama membahas konsep dasar UI/UX Design.',
              isCompleted: true,
              hasAssignments: true,
              hasQuizzes: true,
              contents: [
                Content(
                  id: 'c1',
                  title: 'Zoom Meeting SYNCHRONOUS',
                  type: ContentType.zoom,
                  isCompleted: true,
                ),
                Content(
                  id: 'c2',
                  title: 'Pengantar User Interface Design',
                  type: ContentType.document,
                  isCompleted: true,
                ),
                Content(
                  id: 'c3',
                  title: 'Pretest Awal Desain Antarmuka Pengguna',
                  type: ContentType.quiz,
                  isCompleted: false,
                ),
                Content(
                  id: 'c4',
                  title: 'Pretest Teori Dasar Antarmuka Pengguna',
                  type: ContentType.quiz,
                  isCompleted: true,
                ),
                Content(
                  id: 'c5',
                  title: 'User Interface Design for Beginner',
                  type: ContentType.reading,
                  isCompleted: true,
                ),
                Content(
                  id: 'c6',
                  title: 'UI Principle Design',
                  type: ContentType.assignment,
                  isCompleted: true,
                ),
                Content(
                  id: 'c7',
                  title: 'Best Practice UI Design',
                  type: ContentType.reading,
                  isCompleted: true,
                ),
              ],
            ),
            Material(
              id: 'mat2',
              moduleId: 'm1',
              title: 'Design Thinking Process',
              description: 'Memahami proses design thinking dalam UI/UX.',
              isCompleted: false,
              hasAssignments: false,
              hasQuizzes: false,
              contents: [
                Content(
                  id: 'c8',
                  title: 'Introduction to Design Thinking',
                  type: ContentType.video,
                  isCompleted: false,
                ),
                Content(
                  id: 'c9',
                  title: 'Design Thinking Framework',
                  type: ContentType.document,
                  isCompleted: false,
                ),
              ],
            ),
          ],
        ),
        Module(
          id: 'm2',
          courseId: 'c1',
          title: 'Pertemuan 2',
          description: 'DESIGN FUNDAMENTALS - TYPOGRAPHY DAN ICONOGRAPHY',
          materials: [
            Material(
              id: 'mat3',
              moduleId: 'm2',
              title: 'Typography Basics',
              description: 'Dasar-dasar tipografi dalam design.',
              isCompleted: false,
              hasAssignments: true,
              hasQuizzes: false,
              contents: [
                Content(
                  id: 'c10',
                  title: 'Typography Lecture',
                  type: ContentType.zoom,
                  isCompleted: false,
                ),
                Content(
                  id: 'c11',
                  title: 'Font Selection Guide',
                  type: ContentType.document,
                  isCompleted: false,
                ),
                Content(
                  id: 'c12',
                  title: 'Typography Assignment',
                  type: ContentType.assignment,
                  isCompleted: false,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'c2',
      name: 'Sistem Terdistribusi',
      code: 'ST',
      progress: 0.40,
      instructorName: 'Dr. Ahmad Fauzi',
      modules: [],
    ),
    Course(
      id: 'c3',
      name: 'Kecerdasan Buatan',
      code: 'AI',
      progress: 0.40,
      instructorName: 'Prof. Siti Rahma',
      modules: [],
    ),
    Course(
      id: 'c4',
      name: 'Manajemen Proyek TI',
      code: 'MPT',
      progress: 0.20,
      instructorName: 'Ir. Bambang W.',
      modules: [],
    ),
    Course(
      id: 'c5',
      name: 'Etika Profesi',
      code: 'EP',
      progress: 0.90,
      instructorName: 'Dra. Wulan Sari',
      modules: [],
    ),
  ];

  static final List<Announcement> announcements = [
    Announcement(
      title: 'Jadwal Libur Semester',
      description: 'Libur semester akan dimulai pada tanggal 25 Desember.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Announcement(
      title: 'Maintenance Server',
      description: 'Server LMS akan maintenance pada hari Sabtu pukul 22:00.',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  static final List<Assignment> assignments = [
    Assignment(
      id: 'a1',
      courseId: 'c1',
      title: 'Tugas 1: API Laravel',
      description: 'Buatlah REST API sederhana menggunakan Laravel.',
      deadline: DateTime.now().add(const Duration(days: 2)),
      isSubmitted: false,
    ),
    Assignment(
      id: 'a2',
      courseId: 'c2',
      title: 'Tugas 2: Algoritma A*',
      description: 'Implementasikan algoritma A* untuk pathfinding.',
      deadline: DateTime.now().add(const Duration(days: 5)),
      isSubmitted: true,
    ),
  ];

  static List<CourseMaterial> getMaterials(String courseId) {
    return [
      CourseMaterial(
        id: 'm1',
        courseId: courseId,
        title: 'Pengantar Perkuliahan',
        type: CourseMaterialType.pdf,
        url: '#',
      ),
      CourseMaterial(
        id: 'm2',
        courseId: courseId,
        title: 'Video Penjelasan Bab 1',
        type: CourseMaterialType.video,
        url: '#',
      ),
      CourseMaterial(
        id: 'm3',
        courseId: courseId,
        title: 'Link Zoom Meeting',
        type: CourseMaterialType.zoom,
        url: '#',
      ),
    ];
  }

  static List<Quiz> getQuizzes(String courseId) {
    return [
      Quiz(
        id: 'q1',
        courseId: courseId,
        title: 'Kuis Bab 1',
        durationMinutes: 30,
        questionCount: 20,
      ),
      Quiz(
        id: 'q2',
        courseId: courseId,
        title: 'UTS',
        durationMinutes: 90,
        questionCount: 50,
      ),
    ];
  }

  // Helper methods to get data by ID
  static Course? getCourseById(String id) {
    try {
      return myCourses.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  static Module? getModuleById(String courseId, String moduleId) {
    final course = getCourseById(courseId);
    if (course == null) return null;
    try {
      return course.modules.firstWhere((m) => m.id == moduleId);
    } catch (e) {
      return null;
    }
  }

  static Material? getMaterialById(String moduleId, String materialId) {
    for (var course in myCourses) {
      for (var module in course.modules) {
        if (module.id == moduleId) {
          try {
            return module.materials.firstWhere((m) => m.id == materialId);
          } catch (e) {
            return null;
          }
        }
      }
    }
    return null;
  }

  // New data for notifications, submissions, and quiz results
  static final List<Notification> notifications = [
    Notification(
      id: 'n1',
      title: 'Tugas Berhasil Dikumpulkan',
      description: 'Tugas "Tugas 2: Algoritma A*" telah berhasil dikumpulkan',
      type: NotificationType.assignment,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      relatedId: 'a2',
    ),
    Notification(
      id: 'n2',
      title: 'Pengumuman Baru',
      description: 'Maintenance Pro UAS Semester Genap 2020/2021',
      type: NotificationType.announcement,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
    ),
    Notification(
      id: 'n3',
      title: 'Pembaruan Kelas',
      description: 'Materi baru telah ditambahkan di User Interface Design',
      type: NotificationType.classUpdate,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      relatedId: 'c1',
    ),
  ];

  static final Map<String, AssignmentSubmission> assignmentSubmissions = {
    'a1': AssignmentSubmission(
      assignmentId: 'a1',
      status: SubmissionStatus.notSubmitted,
      gradingStatus: GradingStatus.notGraded,
    ),
    'a2': AssignmentSubmission(
      assignmentId: 'a2',
      status: SubmissionStatus.submitted,
      gradingStatus: GradingStatus.graded,
      submittedAt: DateTime.now().subtract(const Duration(days: 2)),
      lastModified: DateTime.now().subtract(const Duration(days: 2)),
      uploadedFiles: ['assignment_a2.pdf'],
      grade: 85.0,
    ),
  };

  static final Map<String, QuizResult> quizResults = {
    'q1': QuizResult(
      quizId: 'q1',
      score: 85.0,
      totalQuestions: 20,
      correctAnswers: 17,
      duration: const Duration(minutes: 25),
      completedAt: DateTime.now().subtract(const Duration(days: 3)),
      answers: [
        QuestionResult(
          questionNumber: 1,
          question: 'Apa kepanjangan dari UX?',
          userAnswer: 'User Experience',
          correctAnswer: 'User Experience',
          isCorrect: true,
        ),
        QuestionResult(
          questionNumber: 2,
          question: 'Manakah yang termasuk prinsip design?',
          userAnswer: 'Consistency',
          correctAnswer: 'Consistency',
          isCorrect: true,
        ),
        QuestionResult(
          questionNumber: 3,
          question: 'Apa fungsi wireframe?',
          userAnswer: 'Testing',
          correctAnswer: 'Planning',
          isCorrect: false,
        ),
      ],
    ),
  };

  static final List<VideoContent> videos = [
    VideoContent(
      id: 'v1',
      title: 'Interaction Design',
      description: 'Pengantar tentang interaction design dalam UI/UX',
      duration: const Duration(minutes: 15, seconds: 30),
    ),
    VideoContent(
      id: 'v2',
      title: 'Pengantar Desain Antarmuka Pengguna',
      description: 'Video pembelajaran dasar-dasar UI design',
      duration: const Duration(minutes: 20, seconds: 45),
    ),
    VideoContent(
      id: 'v3',
      title: '5 Teori Dasar Desain Antarmuka Pengguna',
      description: 'Membahas 5 teori fundamental dalam UI design',
      duration: const Duration(minutes: 18, seconds: 15),
    ),
    VideoContent(
      id: 'v4',
      title: 'Tutorial Dasar Figma - UI/UX Design Software',
      description: 'Panduan penggunaan Figma untuk pemula',
      duration: const Duration(minutes: 25, seconds: 0),
    ),
  ];

  // Helper methods
  static AssignmentSubmission? getSubmissionByAssignmentId(
    String assignmentId,
  ) {
    return assignmentSubmissions[assignmentId];
  }

  static QuizResult? getQuizResultByQuizId(String quizId) {
    return quizResults[quizId];
  }

  static Assignment? getAssignmentById(String id) {
    try {
      return assignments.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}
