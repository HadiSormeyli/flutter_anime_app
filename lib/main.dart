import 'package:flutter/material.dart';
import 'package:flutter_anime_app/config/config.dart';
import 'package:flutter_anime_app/presentation/blocs/recommendationsanime/recommendations_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/topanime/top_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/blocs/upcominganime/upcoming_anime_bloc.dart';
import 'package:flutter_anime_app/presentation/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../di/injector.dart' as di;
import 'di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<TopAnimeBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<RecommendationsAnimeBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<UpComingAnimeBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeData(context),
          home: const MainScreen(),
        ));
  }
}
