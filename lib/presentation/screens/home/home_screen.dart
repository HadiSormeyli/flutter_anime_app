import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_anime_app/config/config.dart';
import 'package:flutter_anime_app/data/model/anime/Data.dart' as TopAnimeData;
import 'package:flutter_anime_app/data/model/recommendations/Data.dart'
    as RecommendedAnimeData;
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_state.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_state.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_event.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_state.dart';
import 'package:flutter_anime_app/presentation/screens/details/anime_details_screen.dart';
import 'package:flutter_anime_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../di/injector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final recommendationsAnimeBlock = sl<RecommendationsAnimeBloc>();
  final upComingAnimeBloc = sl<UpComingAnimeBloc>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () => Provider.of<TopAnimeBloc>(context, listen: false)
          .add(const LoadTopAnimeEvent()),
    );
    Future.microtask(
      () => Provider.of<RecommendationsAnimeBloc>(context, listen: false)
          .add(const LoadRecommendationsAnimeEvent()),
    );
    Future.microtask(
      () => Provider.of<UpComingAnimeBloc>(context, listen: false)
          .add(const LoadUpComingAnimeEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          _buildTopAnimeWidget(),
          const SizedBox(
            height: smallDistance,
          ),
          _buildRecommendationsWidget(),
          const SizedBox(
            height: smallDistance,
          ),
          _buildUpComingsWidget()

        ],
      )),
    );
  }

  Widget _buildTopAnimeWidget() {
    return BlocBuilder<TopAnimeBloc, TopAnimeState>(builder: (context, state) {
      return Container(
        margin:
            const EdgeInsets.symmetric(horizontal: smallDistance, vertical: 4),
        height: 400,
        child: Stack(
          children: [

            ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(xLargeRadius),
                            bottomLeft: Radius.circular(xLargeRadius),
                            topLeft: Radius.circular(mediumRadius),
                            topRight: Radius.circular(mediumRadius))),
                    child: const Center(),
                  ),
                )),

            if (state is LoadedTopAnimeState)
              Stack(
                children: [
                  CarouselSlider(
                    items: state.topAnimeList
                        .map(
                          (item) => TrailerPlayerWidget(
                        data: item,
                      ),
                    )
                        .toList(),
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -90,
                    left: (MediaQuery.of(context).size.width - 80) / 2,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(mediumRadius)),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 88, sigmaY: 88),
                            child: Container(
                              color: backgroundColor.withOpacity(0.05),
                              width: 64,
                              height: 112,
                            ))),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: state.topAnimeList.map((item) {
                        int index = state.topAnimeList.indexOf(item);
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: smallDistance, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.grey.shade700,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              )
          ],
        ),
      );
    });
  }

  Widget _buildRecommendationsWidget() {
    return BlocBuilder<RecommendationsAnimeBloc, RecommendationsAnimeState>(
        builder: (context, state) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: mediumDistance),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text.rich(
                  TextSpan(
                    text: 'Recommended ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Anime',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(color: greyColor),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: greyColor,
                        size: 16,
                      )
                    ])
              ],
            ),
          ),
          const SizedBox(
            height: mediumDistance,
          ),
          if (state is LoadedRecommendationsAnimeState)
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.recommendationsAnimeList
                    .map((e) => RecommendedItemWidget(data: e))
                    .toList(),
              ),
            )
        ],
      );
    });
  }

  Widget _buildUpComingsWidget() {
    return BlocBuilder<UpComingAnimeBloc, UpComingAnimeState>(
        builder: (context, state) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: mediumDistance),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'coming',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(color: greyColor),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: greyColor,
                        size: 16,
                      )
                    ])
              ],
            ),
          ),
          const SizedBox(
            height: mediumDistance,
          ),
          if (state is LoadedUpComingAnimeState)
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.upComingAnimeList
                    .map((e) => UpComingItemWidget(data: e))
                    .toList(),
              ),
            )
        ],
      );
    });
  }
}

class UpComingItemWidget extends StatelessWidget {
  final TopAnimeData.Data data;

  const UpComingItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 152,
      margin: const EdgeInsets.only(left: smallDistance),
      child: Column(
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mediumRadius),
              child: Stack(
                children: [
                  Image.network(
                    data.images!.jpg!.largeImageUrl!,
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          width: 10000,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  backgroundColor.withOpacity(0),
                                  backgroundColor.withOpacity(0.5),
                                  backgroundColor.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.4, 1.0],
                                tileMode: TileMode.clamp),
                          ))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data.title!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class RecommendedItemWidget extends StatelessWidget {
  final RecommendedAnimeData.Data data;

  const RecommendedItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: smallDistance),
      child: Column(
        children: [
          Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mediumRadius),
              child: Stack(
                children: [
                  Image.network(
                    data.entry![1].images!.jpg!.largeImageUrl!,
                    fit: BoxFit.cover,
                    height: 152,
                    width: 200,
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                          width: 10000,
                          height: 24,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  backgroundColor.withOpacity(0),
                                  backgroundColor.withOpacity(0.7),
                                  backgroundColor.withOpacity(1),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: const [0.0, 0.4, 1.0],
                                tileMode: TileMode.clamp),
                          ))),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data.entry![1].title!.split(':')[0],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class TrailerPlayerWidget extends StatefulWidget {
  final TopAnimeData.Data data;

  const TrailerPlayerWidget({super.key, required this.data});

  @override
  State<TrailerPlayerWidget> createState() => _TrailerPlayerWidgetState();
}

class _TrailerPlayerWidgetState extends State<TrailerPlayerWidget>
    with WidgetsBindingObserver, RouteAware {
  late YoutubePlayerController _controller;
  bool _mute = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _controller = YoutubePlayerController(
      initialVideoId: widget.data.trailer!.youtubeId!,
      flags: YoutubePlayerFlags(
          showLiveFullscreenButton: false,
          hideControls: true,
          forceHD: true,
          controlsVisibleAtStart: false,
          loop: true,
          useHybridComposition: true,
          mute: _mute),
    );
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller.pause();
    } else if (state == AppLifecycleState.resumed) {
      _controller.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(
            context,
            AnimeDetailsScreen(
              data: widget.data,
            ));
      },
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(xLargeRadius),
              bottomLeft: Radius.circular(xLargeRadius),
              topLeft: Radius.circular(mediumRadius),
              topRight: Radius.circular(mediumRadius)),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              height: 400,
              child: Stack(
                children: [

                  SizedBox(
                      height: 400,
                      child: Transform.scale(
                        scaleY: 2,
                        scaleX: 1.2,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: false,
                            bottomActions: const [],
                            topActions: const [],
                            onEnded: (data) {
                              _controller.seekTo(const Duration(seconds: 0));
                            },
                            onReady: () {
                              _controller.play();
                            },
                          ),
                        ),
                      )),
                  Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              backgroundColor.withOpacity(0.5),
                              backgroundColor.withOpacity(0.3),
                              backgroundColor.withOpacity(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.3, 1.0],
                            tileMode: TileMode.clamp),
                      )),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        width: 10000,
                        height: 144,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                backgroundColor.withOpacity(0),
                                backgroundColor.withOpacity(0.3),
                                backgroundColor.withOpacity(0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.35, 1.0],
                              tileMode: TileMode.clamp),
                        )),
                  ),
                  Positioned(
                      bottom: 24,
                      left: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.data.title!
                                .replaceAll(":", "")
                                .replaceAll("-", "")
                                .split(' ')
                                .join('\n'),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(widget.data.genres![0].name!),
                          const SizedBox(
                            height: smallDistance,
                          ),
                          Text(
                            "${widget.data.studios![0].name!} | ${widget.data.episodes} episodes",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      )),

                  Positioned(
                      bottom: 8,
                      right: 24,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _mute = !_mute;
                            if (_mute) {
                              _controller.mute();
                            } else {
                              _controller.unMute();
                            }
                          });
                        },
                        icon: Icon(
                          (_mute) ? Icons.volume_off : Icons.volume_up,
                          size: 20,
                        ),
                      ))
                ],
              ))),
    );
  }
}
