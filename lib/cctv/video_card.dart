import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

// class VedioCardScreen extends StatefulWidget {
//   final String streamUrl;
//   final String cameraName;
//
//   const VedioCardScreen({
//     super.key,
//     required this.streamUrl,
//     required this.cameraName,
//   });
//
//   @override
//   State<VedioCardScreen> createState() => _VedioCardScreenState();
// }
//
// class _VedioCardScreenState extends State<VedioCardScreen> {
//   late final Player player;
//   late final VideoController controller;
//   bool _hasError = false;
//   bool _isMuted = true;
//   bool _isPlaying = true;
//
//   @override
//   void initState() {
//     super.initState();
//     player = Player();
//     controller = VideoController(player);
//
//     player.open(Media(widget.streamUrl), play: true);
//     player.setVolume(0);
//
//     player.streams.error.listen((error) {
//       if (error != null && !_hasError) {
//         setState(() {
//           _hasError = true;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.warning_amber_rounded, size: 40, color: Colors.red),
//             SizedBox(height: 8),
//             Text(
//               'Stream failed or stopped',
//               style: TextStyle(color: Colors.red, fontSize: 14),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(6),
//       child: AspectRatio(
//         aspectRatio: 3 / 2,
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Video(
//               controller: controller,
//               controls: (_) => const SizedBox.shrink(), // No controls
//             ),
//             Positioned(
//               bottom: 8,
//               left: 8,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       _isPlaying ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       if (_isPlaying) {
//                         player.pause();
//                       } else {
//                         player.play();
//                       }
//                       setState(() {
//                         _isPlaying = !_isPlaying;
//                       });
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       _isMuted ? Icons.volume_off : Icons.volume_up,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       if (_isMuted) {
//                         player.setVolume(100);
//                       } else {
//                         player.setVolume(0);
//                       }
//                       setState(() {
//                         _isMuted = !_isMuted;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class VideoCardScreen extends StatefulWidget {
  final String streamUrl;
  final String cameraName;

  const VideoCardScreen({
    super.key,
    required this.streamUrl,
    required this.cameraName,
  });

  @override
  State<VideoCardScreen> createState() => _VideoCardScreenState();
}

class _VideoCardScreenState extends State<VideoCardScreen> {
  late final Player player;
  late final VideoController controller;
  late final NativePlayer nativePlayer;
  bool _hasError = false;
  bool _isBuffering = true;


  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        key: widget.key,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, size: 40, color: Colors.red),
            SizedBox(height: 8),
            Text(
              'Stream failed or stopped',
              style: TextStyle(color: Colors.red, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      key: widget.key,
      borderRadius: BorderRadius.circular(6),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Stack(
          children: [
            Video(
              controller: controller,
              controls: null, // Hides default controls
            ),
            if (_isBuffering)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }

  void initPlayer() async {
    player = Player();
    nativePlayer = player.platform as NativePlayer;
    nativePlayer.setProperty('profile', 'low-latency');
    player.platform = nativePlayer;
    controller = VideoController(player,
        configuration: const VideoControllerConfiguration(
          enableHardwareAcceleration: false, // default: true
          // width: 640,
          // height: 480,
        ));
    await nativePlayer.open(Media(
      widget.streamUrl,
    ));

    await nativePlayer.setVolume(0);
    // Listen for playback errors
    nativePlayer.stream.error.listen((error) {
      if (!_hasError) {
        setState(() {
          _hasError = true;
        });
      }
    });
    nativePlayer.stream.buffering.listen((isBuff) {
      debugPrint('Playback: $isBuff');
      if (mounted) {
        setState(() {
          _isBuffering = isBuff;
        });
      }
    });
    nativePlayer.stream.bufferingPercentage.listen((percent) {
      debugPrint('Playback Percent: $percent');
    });
    nativePlayer.stream.buffer.listen((duration) {
      debugPrint('Playback Duration: $duration');
    });
    nativePlayer.stream.position.listen((position) {
      debugPrint('Playback position: $position');
    });
  }
}
