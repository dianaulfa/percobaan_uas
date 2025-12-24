import 'package:flutter/material.dart';

class LoginInfoScreen extends StatefulWidget {
  const LoginInfoScreen({super.key});

  @override
  State<LoginInfoScreen> createState() => _LoginInfoScreenState();
}

class _LoginInfoScreenState extends State<LoginInfoScreen> {
  bool _isIndonesian = true; // true = ID, false = EN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_isIndonesian ? "Informasi Login" : "Informasi Login (EN)"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Language Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLanguageButton(
                  flag: '🇮🇩',
                  label: 'ID',
                  isSelected: _isIndonesian,
                  onTap: () => setState(() => _isIndonesian = true),
                ),
                const SizedBox(width: 40),
                _buildLanguageButton(
                  flag: '🇬🇧',
                  label: 'EN',
                  isSelected: !_isIndonesian,
                  onTap: () => setState(() => _isIndonesian = false),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Content
            if (_isIndonesian)
              _buildIndonesianContent()
            else
              _buildEnglishContent(),

            const SizedBox(height: 40),

            // Button to Login
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text(
                  'Lanjut ke Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required String flag,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 45,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFD32F2F) : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? const Color(0xFFD32F2F) : Colors.grey,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(flag, style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFFD32F2F) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndonesianContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Akses hanya untuk Dosen dan Mahasiswa Telkom University.',
          style: TextStyle(fontSize: 14, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          'Login menggunakan Akun Microsoft Office 365 dengan mengikuti petunjuk berikut:',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildBulletPoint(
          'Username (Akun iGracias) ditambahkan "@365.telkomuniversity.ac.id"',
        ),
        _buildBulletPoint('Password (Akun iGracias) pada kolom Password.'),
        const SizedBox(height: 20),
        const Text(
          'Kegagalan yang terjadi pada Autentikasi disebabkan oleh Anda belum mengubah Password Akses menjadi "Strong Password". Pastikan Anda telah melakukan perubahan Password di iGracias.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 20),
        const Text(
          'Informasi lebih lanjut dapat menghubungi Layanan CeLoE Helpdesk di:',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildContactInfo('Mail : infoceloe@telkomuniversity.ac.id'),
        _buildContactInfo('Whatsapp : +62 821-1686-3563'),
      ],
    );
  }

  Widget _buildEnglishContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Access restricted only for Lecturer and Student of Telkom University',
          style: TextStyle(fontSize: 14, height: 1.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        const Text(
          'Login only using your Microsoft Office 365 Account by following these format:',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildBulletPoint(
          'Username (iGracias Account) followed with "@365.telkomuniversity.ac.id"',
        ),
        _buildBulletPoint(
          'Password (SSO / iGracias Account) on Password Field',
        ),
        const SizedBox(height: 20),
        const Text(
          'Failure upon Authentication could be possibly you have not yet change your password into "Strong Password". Make sure to change your Password only at iGracias.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 20),
        const Text(
          'For further information, please contact CeLoE Service Helpdesk:',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildContactInfo('mail : infoceloe@telkomuniversity.ac.id'),
        _buildContactInfo('whatsapp : +62 821-1686-3563'),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Text(text, style: const TextStyle(fontSize: 14)),
    );
  }
}
