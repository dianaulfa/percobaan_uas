import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../services/mock_service.dart';
import '../models/models.dart';

class AssignmentSubmissionScreen extends StatefulWidget {
  final String? assignmentId;
  const AssignmentSubmissionScreen({super.key, this.assignmentId});

  @override
  State<AssignmentSubmissionScreen> createState() =>
      _AssignmentSubmissionScreenState();
}

class _AssignmentSubmissionScreenState
    extends State<AssignmentSubmissionScreen> {
  List<String> uploadedFiles = [];

  void _pickFiles() {
    final input = html.FileUploadInputElement()
      ..accept = '.pdf,.doc,.docx,.zip';
    input.multiple = true;

    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        setState(() {
          for (var file in files) {
            if (uploadedFiles.length < 20) {
              uploadedFiles.add(file.name);
            }
          }
        });
      }
    });
  }

  void _removeFile(int index) {
    setState(() {
      uploadedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final assignmentId = widget.assignmentId ?? 'a1';
    final assignment = MockService.getAssignmentById(assignmentId);
    final submission = MockService.getSubmissionByAssignmentId(assignmentId);

    if (assignment == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Assignment Not Found')),
        body: const Center(child: Text('Assignment not found')),
      );
    }

    final timeRemaining = assignment.deadline.difference(DateTime.now());
    final daysRemaining = timeRemaining.inDays;
    final hoursRemaining = timeRemaining.inHours % 24;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Red Header
          Container(
            color: const Color(0xFFD32F2F),
            padding: const EdgeInsets.only(
              top: 40,
              left: 8,
              right: 16,
              bottom: 16,
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Text(
                    assignment.title,
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    assignment.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Status Table
                  const Text(
                    'Status Pengumpulan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        _buildStatusRow(
                          'Status Pengumpulan',
                          _getSubmissionStatusText(submission?.status),
                        ),
                        _buildStatusRow(
                          'Status Penilaian',
                          _getGradingStatusText(submission?.gradingStatus),
                        ),
                        _buildStatusRow(
                          'Batas Waktu',
                          assignment.deadline.toString().split('.')[0],
                        ),
                        _buildStatusRow(
                          'Waktu Tersisa',
                          '$daysRemaining hari $hoursRemaining jam',
                        ),
                        _buildStatusRow(
                          'Terakhir Diubah',
                          submission?.lastModified?.toString().split('.')[0] ??
                              '-',
                        ),
                        if (submission?.grade != null)
                          _buildStatusRow(
                            'Nilai',
                            '${submission!.grade}/100',
                            isLast: true,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Upload Section
                  const Text(
                    'Upload File',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Upload Area
                  InkWell(
                    onTap: _pickFiles,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue[300]!,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cloud_upload,
                            size: 80,
                            color: Colors.blue[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'File yang akan di upload akan tersimpan di sini',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Maximum file 5MB, Maximum Jumlah File 20',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Uploaded Files List
                  if (uploadedFiles.isNotEmpty) ...[
                    const Text(
                      'File Terpilih:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...uploadedFiles.asMap().entries.map((entry) {
                      final index = entry.key;
                      final file = entry.value;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.insert_drive_file,
                              color: Colors.blue[400],
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                file,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, size: 18),
                              onPressed: () => _removeFile(index),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickFiles,
                          icon: const Icon(Icons.attach_file),
                          label: const Text('Pilih File'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: uploadedFiles.isEmpty
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Tugas berhasil dikumpulkan!',
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                          icon: const Icon(Icons.save),
                          label: const Text('Simpan'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD32F2F),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Cancel submission button (if already submitted)
                  if (submission?.status == SubmissionStatus.submitted)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Batalkan Pengiriman?'),
                              content: const Text(
                                'Apakah Anda yakin ingin membatalkan pengiriman tugas ini?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Tidak'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Pengiriman dibatalkan'),
                                      ),
                                    );
                                  },
                                  child: const Text('Ya, Batalkan'),
                                ),
                              ],
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Batalkan Pengiriman'),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, {bool isLast = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  String _getSubmissionStatusText(SubmissionStatus? status) {
    if (status == null) return 'Belum Dikumpulkan';
    switch (status) {
      case SubmissionStatus.submitted:
        return 'Sudah Dikumpulkan';
      case SubmissionStatus.draft:
        return 'Draft';
      case SubmissionStatus.late:
        return 'Terlambat';
      case SubmissionStatus.notSubmitted:
        return 'Belum Dikumpulkan';
    }
  }

  String _getGradingStatusText(GradingStatus? status) {
    if (status == null) return 'Belum Dinilai';
    switch (status) {
      case GradingStatus.graded:
        return 'Sudah Dinilai';
      case GradingStatus.pending:
        return 'Menunggu Penilaian';
      case GradingStatus.notGraded:
        return 'Belum Dinilai';
    }
  }
}
