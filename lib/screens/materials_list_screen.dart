import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../widgets/bottom_nav_bar.dart';

class MaterialsListScreen extends StatelessWidget {
  final String courseId;
  final String moduleId;
  
  const MaterialsListScreen({
    super.key,
    required this.courseId,
    required this.moduleId,
  });

  @override
  Widget build(BuildContext context) {
    final module = MockService.getModuleById(courseId, moduleId);
    
    if (module == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Module Not Found')),
        body: const Center(child: Text('Module not found')),
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
          // Red Header
          Container(
            color: const Color(0xFFD32F2F),
            padding: const EdgeInsets.only(top: 40, left: 8, right: 16, bottom: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
                ),
                Expanded(
                  child: Text(
                    module.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Materials List
          Expanded(
            child: module.materials.isEmpty
                ? const Center(child: Text('No materials available'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: module.materials.length,
                    itemBuilder: (context, index) {
                      final material = module.materials[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/material-detail',
                              arguments: material.id,
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
                                                Icons.book,
                                                size: 20,
                                                color: Colors.blue[400],
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  material.title,
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
                                            material.description,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                  // Checkmark
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Icon(
                                      material.isCompleted
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: material.isCompleted
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
                    },
                  ),
          ),
        ],
      ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
