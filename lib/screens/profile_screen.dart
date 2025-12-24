import 'package:flutter/material.dart';
import '../services/mock_service.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockService.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Pengguna")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFD32F2F),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              user.role.toUpperCase(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            _buildProfileField(Icons.email, "Email", user.email),
            const SizedBox(height: 16),
            _buildProfileField(Icons.numbers, "NIM", "12345678"),
            const SizedBox(height: 16),
            _buildProfileField(
              Icons.school,
              "Program Studi",
              "Teknik Informatika",
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildProfileField(IconData icon, String label, String value) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      controller: TextEditingController(text: value),
    );
  }
}
