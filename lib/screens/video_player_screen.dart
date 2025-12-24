import 'package:flutter/material.dart';
import '../models/models.dart' as models;
import '../services/mock_service.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  const VideoPlayerScreen({super.key, required this.videoId});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late models.VideoContent _currentVideo;

  @override
  void initState() {
    super.initState();
    _currentVideo = MockService.videos.firstWhere(
      (v) => v.id == widget.videoId,
      orElse: () => MockService.videos.first,
    );
  }

  void _onVideoTap(models.VideoContent video) {
    setState(() {
      _currentVideo = video;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Video Pembelajaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Player Mock
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_currentVideo.thumbnailUrl.isNotEmpty)
                      Image.network(
                        _currentVideo.thumbnailUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[900]),
                      )
                    else
                      Container(color: Colors.grey[900]),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(128),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                    // Progress bar mock
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: 0.3,
                            backgroundColor: Colors.white.withAlpha(50),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.pause,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  '04:30 / 15:00',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Video Info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _currentVideo.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentVideo.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Divider with label
                  Row(
                    children: [
                      const Text(
                        'Video Lainnya',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Other Videos List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: MockService.videos.length,
                    itemBuilder: (context, index) {
                      final video = MockService.videos[index];
                      final isPlaying = video.id == _currentVideo.id;

                      return InkWell(
                        onTap: () => _onVideoTap(video),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isPlaying ? Colors.red[50] : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isPlaying
                                  ? Colors.red[200]!
                                  : Colors.grey[200]!,
                            ),
                          ),
                          child: Row(
                            children: [
                              // Thumbnail
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 60,
                                      color: Colors.grey[300],
                                      child: video.thumbnailUrl.isNotEmpty
                                          ? Image.network(
                                              video.thumbnailUrl,
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(
                                              Icons.video_library,
                                              color: Colors.grey,
                                            ),
                                    ),
                                    if (isPlaying)
                                      Container(
                                        width: 100,
                                        height: 60,
                                        color: Colors.black.withAlpha(80),
                                        child: const Icon(
                                          Icons.equalizer,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: isPlaying
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isPlaying
                                            ? const Color(0xFFD32F2F)
                                            : Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${video.duration.inMinutes}:${(video.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
