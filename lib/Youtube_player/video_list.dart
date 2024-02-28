import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key, required this.videoID});
  final List<String> videoID; // Declare videoID as a final variable

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late final List<YoutubePlayerController>
      _controllers; // Declare _controllers as late

  @override
  void initState() {
    super.initState();

    // Initialize _controllers using widget.videoID
    _controllers = widget.videoID
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Videos'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            actionsPadding: EdgeInsets.only(left: 16.0.w),
            bottomActions: [
              CurrentPosition(),
              SizedBox(width: 10.0.w),
              ProgressBar(isExpanded: true),
              SizedBox(width: 10.0.w),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: _controllers.length,
        separatorBuilder: (context, _) => SizedBox(height: 10.0.h),
      ),
    );
  }
}
