import 'dart:async';
import 'dart:io';
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heamodialysis/cctv/cctv_controller.dart';
import 'package:heamodialysis/cctv/model/institude_wise_cctv.dart';
import 'package:heamodialysis/cctv/video_card.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:screen_recorder/screen_recorder.dart';

class LiveTab extends StatefulWidget {
  final InstitudeWiseCctv? institudeWiseCctv;
  final String? selectedState;
  final String? selectedDiv;
  final String? selectedDist;
  final String? selectedTaluka;
  final String? selectedInst;

  const LiveTab(
      {super.key,
      this.institudeWiseCctv,
      this.selectedState,
      this.selectedDiv,
      this.selectedDist,
      this.selectedTaluka,
      this.selectedInst});

  @override
  State<LiveTab> createState() => _LiveTabState();
}

class _LiveTabState extends State<LiveTab> {
  final CctvController cctvCameraDetController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 3 / 4,
      ),
      // itemCount: cctvCameraDetController.cctvList?.length,
      itemCount: cctvCameraDetController.selectedFromDate != null
          ? cctvCameraDetController.list.length
          : cctvCameraDetController.cctvList.length,
      itemBuilder: (context, index) {
        final camera = cctvCameraDetController.selectedFromDate != null
            ? cctvCameraDetController.list[index]
            : cctvCameraDetController.cctvList[index];
        // final camera = cctvCameraDetController.cctvList?[index].c;
        final videoUrl = camera;

        return GestureDetector(
          onTap: () {
            final isPlaybackMode =
                cctvCameraDetController.selectedFromDate != null;

             isPlaybackMode
                ? buildPlaybackUrl(
                    cameraNumber: index + 1, // c1 to c4
                    startDateTime: DateTime(
                      cctvCameraDetController.selectedFromDate!.year,
                      cctvCameraDetController.selectedFromDate!.month,
                      cctvCameraDetController.selectedFromDate!.day,
                      10, 0, 0, // or user-selected time
                    ),
                    duration: const Duration(minutes: 30),
                  )
                : cctvCameraDetController.cctvList[index];

            Get.to(CCTVPlayerScreen(
              key: ValueKey(camera),
              streamUrl: camera,
              cameraName: getCameranumber(camera) ?? "",
            ));
          },
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                VideoCardScreen(
                  key: ValueKey(videoUrl),
                  streamUrl: videoUrl,
                  cameraName: getCameranumber(videoUrl) ?? "",
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: CustomText(
                      text: getCameranumber(videoUrl) ?? '',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ).paddingOnly(bottom: 6)
              ],
            ),
          ),
        );
      },
    );
  }

  String? getCameranumber(String link) {
    final regex = RegExp(r'c(\d+)', caseSensitive: false);
    final match = regex.firstMatch(link);
    if (match != null) {
      final number = match.group(1);
      return 'CAMERA $number';
    }
    return null;
  }

  String buildPlaybackUrl({
    required int cameraNumber, // 1 to 4
    required DateTime startDateTime,
    required Duration duration, // how long to play
  }) {
    final startTimestamp = startDateTime.millisecondsSinceEpoch ~/ 1000;
    final endTimestamp = startTimestamp + duration.inSeconds;

    // return 'rtsp://admin:lab%401234@61.0.43.177:554/c$cameraNumber/b$startTimestamp/e$endTimestamp/replay';
    return 'rtsp://admin:labadmin%40123@117.212.159.94:554/c$cameraNumber/b$startTimestamp/e$endTimestamp/replay';
  }
}

class CCTVPlayerScreen extends StatefulWidget {
  final String streamUrl;
  final String cameraName;

  const CCTVPlayerScreen({
    super.key,
    required this.streamUrl,
    required this.cameraName,
  });

  @override
  State<CCTVPlayerScreen> createState() => _CCTVPlayerScreenState();
}

class _CCTVPlayerScreenState extends State<CCTVPlayerScreen> {
  late final Player player;
  late final VideoController controller;
  bool isMuted = true;
  final _recorderController = ScreenRecorderController();
  bool _recording = false;
  bool exporting = false;
  Timer? _timer;
  int _recordDuration = 0;
  bool _isBuffering = true;

  @override
  void initState() {
    player = Player(configuration: const PlayerConfiguration());
    controller = VideoController(player);
    player.stream.buffering.listen((isBuff) {
      if (mounted) {
        setState(() {
          _isBuffering = isBuff;
        });
      }
    });

    player.open(Media(widget.streamUrl), play: true);
    player.setVolume(0);
    if (Platform.isAndroid) {
      MediaStore.ensureInitialized();
      MediaStore.appFolder = 'ScreenRecordings';
    }
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    _timer?.cancel();

    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(title: Text(widget.cameraName)),
      body: Column(
        children: [
          Expanded(
            child: ScreenRecorder(
              controller: _recorderController,
              width: double.infinity,
              height: double.infinity,
              background: Colors.black,
              // child: Video(controller: controller),
              child: Stack(
                children: [
                  MaterialVideoControlsTheme(
                    normal: const MaterialVideoControlsThemeData(
                        displaySeekBar: false),
                    fullscreen: const MaterialVideoControlsThemeData(
                        displaySeekBar: false), // Optional
                    child: Video(
                        controller: controller,
                        controls: (state) {
                           controller.player;
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.fullscreen,
                                        color: Colors.white),
                                    onPressed: () {
                                      state.toggleFullscreen();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  if (_isBuffering)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                  stream: player.stream.playing,
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: isPlaying ? Colors.orange : Colors.green,
                      ),
                      onPressed: () => player.playOrPause(),
                    );
                  },
                ),
                StreamBuilder<double>(
                  stream: player.streams.volume,
                  builder: (context, snapshot) {
                    final isMuted = (snapshot.data ?? 0) == 0;
                    return IconButton(
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                        color: isMuted ? Colors.red : Colors.blue,
                      ),
                      onPressed: () => player.setVolume(isMuted ? 100 : 0),
                    );
                  },
                ),
                IconButton(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _recording
                            ? Icons.fiber_manual_record
                            : Icons.fiber_manual_record_outlined,
                        color: _recording ? Colors.red : Colors.grey,
                      ),
                      if (_recording) ...[
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(_recordDuration),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ],
                  ),
                  onPressed: () async {
                    if (!_recording) {
                      _recorderController.exporter.clear();

                      // ✅ Clean temp directory of previous PNG frames
                      final tempDir = await getTemporaryDirectory();
                      final files = tempDir.listSync();
                      for (final file in files) {
                        if (file.path.endsWith('.png') &&
                            file.path.contains('frame_')) {
                          await File(file.path).delete();
                        }
                      }

                      _recorderController.start();
                      setState(() => _recording = true);
                      _recordDuration = 0;
                      _timer?.cancel();
                      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
                        setState(() => _recordDuration++);
                      });

                      setState(() => _recording = true);
                    } else {
                      _recorderController.stop();
                      _timer?.cancel();
                      setState(() => _recording = false);

                      setState(() => exporting = true);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text("Saving video to gallery..."),
                            ],
                          ),
                        ),
                      );

                      final frames =
                          await _recorderController.exporter.exportFrames();
                      if (frames == null || frames.isEmpty) return;

                      final tempDir = await getTemporaryDirectory();
                      final framePaths = <String>[];

                      for (int i = 0; i < frames.length; i++) {
                        final bytes = frames[i].image.buffer.asUint8List();
                        final file = File(
                          '${tempDir.path}/frame_${i.toString().padLeft(3, '0')}.png',
                        );

                        await file.writeAsBytes(bytes);
                        framePaths.add(file.path);
                      }

                      final inputPattern = '${tempDir.path}/frame_%03d.png';
                      final outputPath =
                          '${tempDir.path}/screen_recording_${DateTime.now().millisecondsSinceEpoch}.mp4';

                      final cmd = '-y -framerate 15 -i $inputPattern '
                          '-vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" '
                          '-c:v libx264 -pix_fmt yuv420p $outputPath';

                      final session = await FFmpegKit.execute(cmd);
                      final logs = await session.getAllLogs();
                      for (final log in logs) {
                        debugPrint("FFmpegLog: ${log.getMessage()}");
                      }

                      final rc = await session.getReturnCode();
                      debugPrint("FFmpeg return code: $rc");

                      if (rc?.isValueSuccess() ?? false) {
                        if (Platform.isAndroid) {
                          final saved = await MediaStore().saveFile(
                            tempFilePath: outputPath,
                            dirType: DirType.video,
                            dirName: DirName.movies,
                          );

                          if (saved != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'MP4 saved to gallery: ${saved.name}')),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to save video')),
                        );
                      }

                      setState(() => exporting = false);
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
