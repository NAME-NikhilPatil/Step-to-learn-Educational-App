// import 'package:educational_app/Youtube_api/api_services.dart';
// import 'package:educational_app/components/channel_model.dart';
// import 'package:educational_app/components/video_model.dart';
// import 'package:flutter/material.dart';
// import 'video_screen.dart';

// class PlayList extends StatefulWidget {
//   PlayList({required this.title, required this.playlistId});

//   final String title;
//   final String playlistId;

//   @override
//   _PlayListState createState() => _PlayListState();
// }

// class _PlayListState extends State<PlayList> {
//   Channel? _channel;
//   bool _isLoading = false;
//   String? CHANNEL_ID;

//   @override
//   void initState() {
//     super.initState();
//     _initChannel();
//   }

//   _initChannel() async {
//     Channel channel = await APIService.instance
//         .fetchChannel(channelId: CHANNEL_ID, playlistId: widget.playlistId);
//     setState(() {
//       _channel = channel;
//     });
//   }

//   _buildVideo(Video video) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => VideoScreen(id: video.id),
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//         padding: const EdgeInsets.all(10.0),
//         height: 140.0,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               offset: Offset(0, 1),
//               blurRadius: 6.0,
//             ),
//           ],
//         ),
//         child: Row(
//           children: <Widget>[
//             Image(
//               width: 150.0,
//               image: NetworkImage(video.thumbnailUrl!),
//             ),
//             const SizedBox(width: 10.0),
//             Expanded(
//               child: Text(
//                 video.title!,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _loadMoreVideos() async {
//     _isLoading = true;
//     List<Video> moreVideos = await APIService.instance
//         .fetchVideosFromPlaylist(playlistId: widget.playlistId);
//     List<Video> allVideos = _channel!.videos!..addAll(moreVideos);
//     setState(() {
//       _channel!.videos = allVideos;
//     });
//     _isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: const Color(0xFF62B9BF),
//       ),
//       body: _channel != null
//           ? NotificationListener<ScrollNotification>(
//               onNotification: (ScrollNotification scrollDetails) {
//                 if (!_isLoading &&
//                     _channel!.videos!.length !=
//                         int.parse(_channel!.videoCount!) &&
//                     scrollDetails.metrics.pixels ==
//                         scrollDetails.metrics.maxScrollExtent) {
//                   _loadMoreVideos();
//                 }
//                 return false;
//               },
//               child: ListView.builder(
//                 itemCount: _channel!.videos!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   Video video = _channel!.videos![index];
//                   return _buildVideo(video);
//                 },
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   Theme.of(context).primaryColor, // Red
//                 ),
//               ),
//             ),
//     );
//   }
// }
