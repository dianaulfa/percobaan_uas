import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../widgets/bottom_nav_bar.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  int _selectedTab = 1; // Default to "Content" tab

  @override
  Widget build(BuildContext context) {
    final course = MockService.getCourseById(widget.courseId);
    
    if (course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Course Not Found')),
        body: const Center(child: Text('Course not found')),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/dashboard');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(
        children: [
          // Red Header with Instructor Info
          Container(
            color: const Color(0xFFD32F2F),
            padding: const EdgeInsets.only(top: 40, bottom: 0),
            child: Column(
              children: [
                // Back button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
                      ),
                    ],
                  ),
                ),
                
                // Instructor photo and name
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Text(
                    course.instructorName.split(' ').map((n) => n[0]).take(2).join(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  course.instructorName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Tabs
                Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      _buildTab('About Anda', 0),
                      _buildTab('Content', 1),
                      _buildTab('Edit Profile', 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _selectedTab == 1
                ? _buildContentTab(course)
                : Center(
                    child: Text('Tab ${_selectedTab == 0 ? "About" : "Edit Profile"}'),
                  ),
          ),
        ],
      ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? const Color(0xFFD32F2F) : Colors.transparent,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentTab(course) {
    if (course.modules.isEmpty) {
      return const Center(
        child: Text('No modules available'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: course.modules.length,
      itemBuilder: (context, index) {
        final module = course.modules[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/materials-list',
                arguments: {'courseId': widget.courseId, 'moduleId': module.id},
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    module.description,
                    style: TextStyle(
                      color: Colors.white.withAlpha(230),
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
