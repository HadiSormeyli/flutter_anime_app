import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_anime_app/utils/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../config/config.dart';
import '../../../data/model/anime/Data.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final Data data;

  const AnimeDetailsScreen({super.key, required this.data});

  @override
  State<AnimeDetailsScreen> createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  late YoutubePlayerController _controller;
  double _progress = 0.0;
  double _duration = 0.0;
  String _formattedTime = "0";

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.data.trailer!.youtubeId!,
      flags: const YoutubePlayerFlags(
        forceHD: true,
        controlsVisibleAtStart: false,
        hideControls: false,
        showLiveFullscreenButton: false,
        mute: false,
      ),
    )..addListener(_videoProgressListener);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _videoProgressListener() {
    setState(() {
      // Update the progress value based on the current position of the video
      double time = (_controller.value.position.inSeconds /
              _controller.metadata.duration.inSeconds) *
          100;
      _progress = (time.isNaN) ? _progress : time;
      if (_duration == 0 && !_controller.metadata.duration.inSeconds.isNaN) {
        _duration = _controller.metadata.duration.inSeconds.toDouble();
      }
      _formattedTime = convertToTime(_controller.value.position.inSeconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [

            ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(xLargeRadius),
                    bottomLeft: Radius.circular(xLargeRadius)),
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 280,
                    child: Stack(
                      children: [
                        ClipRect(
                          child: BackdropFilter(
                            filter:
                            ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: Container(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ClipRect(
                              child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(smallDistance),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(xLargeRadius),
                                        bottomLeft: Radius.circular(xLargeRadius)),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.15),
                                      width: 2.0,
                                    ),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    widget.data.title!,
                                    maxLines: 1,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              )),
                        ),
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(xLargeRadius),
                              bottomLeft: Radius.circular(xLargeRadius),
                            ),
                            child: SizedBox(
                                height: 240,
                                child: Transform.scale(
                                  scaleY: 1.2,
                                  child: YoutubePlayer(
                                    onEnded: (data) {
                                      _controller
                                          .seekTo(const Duration(seconds: 0));
                                      _controller.pause();
                                    },
                                    bottomActions: const [],
                                    topActions: const [],
                                    controller: _controller,
                                    showVideoProgressIndicator: false,
                                    onReady: () {
                                      setState(() {});
                                      _controller.play();
                                    },
                                  ),
                                ))),
                        Positioned(
                            bottom: 48,
                            left: mediumDistance,
                            right: mediumDistance,
                            child: BackdropFilter(
                                filter:
                                ImageFilter.blur(sigmaX: .0, sigmaY: .0),
                                child: Container(
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: smallDistance),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(mediumRadius)),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 1.0,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(_formattedTime),
                                      const SizedBox(
                                        width: smallDistance,
                                      ),
                                      Expanded(
                                        child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              trackShape:
                                              const RoundedRectSliderTrackShape(),
                                              thumbShape:
                                              const RoundSliderThumbShape(
                                                  enabledThumbRadius: 8.0),
                                              overlayShape:
                                              const RoundSliderOverlayShape(
                                                  overlayRadius: 8.0),
                                            ),
                                            child: Slider(
                                              activeColor: Colors.white,
                                              inactiveColor: greyColor,
                                              thumbColor: Colors.white,
                                              value: _progress,
                                              min: 0,
                                              max: 100,
                                              onChangeEnd: (double value) {
                                                setState(() {
                                                  _progress = value;
                                                  double seekTo =
                                                      (value / 100) * _duration;
                                                  _controller.seekTo(Duration(
                                                      seconds: seekTo.toInt()));
                                                });
                                              },
                                              onChanged: (double value) {},
                                            )),
                                      ),
                                      const SizedBox(
                                        width: smallDistance,
                                      ),
                                      Text(convertToTime(_controller
                                          .metadata.duration.inSeconds)),
                                    ],
                                  ),
                                ))),
                        Container(
                            height: 64,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    backgroundColor.withOpacity(0.5),
                                    backgroundColor.withOpacity(0.3),
                                    backgroundColor.withOpacity(0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.8, 1.0],
                                  tileMode: TileMode.clamp),
                            )),
                        IconButton(
                            onPressed: () {
                              pop(context);
                            },
                            icon: const Icon(Icons.navigate_before)),
                      ],
                    ))),

            const SizedBox(
              height: mediumDistance,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: mediumDistance),
              child: Text(
                widget.data.synopsis!.split("\n")[0],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: mediumDistance,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: mediumDistance,
              ),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(mediumRadius),
                      child: Image.network(
                        widget.data.images!.jpg!.largeImageUrl!,
                        width: 96,
                        height: 96,
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    width: largeDistance,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.status!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: smallDistance,
                      ),
                      RatingBar.builder(
                        initialRating: (widget.data.score! / 2).floorToDouble(),
                        minRating: 0,
                        itemSize: 24,
                        unratedColor: greyColor,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        height: smallDistance,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.remove_red_eye),
                          const SizedBox(
                            width: smallDistance,
                          ),
                          Text(formatNumber(widget.data.members!))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: mediumDistance,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: mediumDistance),
              child: Text(
                widget.data.synopsis!
                    .substring(widget.data.synopsis!.indexOf('\n\n') + 2),
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: smallDistance,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: mediumDistance),
                child: Row(
                  children: widget.data.genres!
                      .map((e) => Text(
                    "#${e.name}\t",
                    style: const TextStyle(color: primaryColor),
                  ))
                      .toList(),
                )),
            const SizedBox(
              height: xLargeDistance,
            ),
          ],
        ),
      )),
    );
  }
}
