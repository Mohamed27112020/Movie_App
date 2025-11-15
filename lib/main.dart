import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/Core/routing/router_generation_config.dart';

import 'package:device_preview/device_preview.dart';
import 'package:movie_app/Data/Cubit/Authcubit.dart';
import 'package:movie_app/Data/Cubit/Authstate.dart';
import 'package:movie_app/Data/Cubit/Searchcubit.dart';
import 'package:movie_app/Data/Cubit/WatchlistCubit.dart';
import 'package:movie_app/Data/Cubit/moviecubit.dart';
import 'package:movie_app/Data/serivices/Movieservices.dart';
import 'package:movie_app/Data/serivices/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (BuildContext context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => MovieCubit(MovieApiService())),
            BlocProvider(create: (context) => WatchlistCubit()),
            BlocProvider(create: (context) => SearchCubit(MovieService())),
            BlocProvider(
              create: (context) => AppAuthCubit()..checkAuthStatus(),
            ),
          ],
          child: BlocBuilder<AppAuthCubit, AppAuthState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Movie App',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.deepPurple,
                  ),
                ),
                debugShowCheckedModeBanner: false,
                locale: DevicePreview.locale(context),
                builder: DevicePreview.appBuilder,
                onGenerateRoute: AppRouter.generateRoute,
                initialRoute: '/',
              );
            },
          ),
        );
      },
    );
  }
}
