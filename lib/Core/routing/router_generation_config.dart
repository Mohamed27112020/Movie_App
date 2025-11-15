import 'package:flutter/material.dart';
import 'package:movie_app/Views/Auth/AuthWrapper.dart';
import 'package:movie_app/Views/Auth/Loginscreen.dart';
import 'package:movie_app/Views/Auth/Signupscreen.dart';
import 'package:movie_app/Views/Home.dart';
import 'package:movie_app/Views/SplashScreen.dart';
import 'package:movie_app/Views/detailsmovie.dart';
import 'package:movie_app/Views/navScreen.dart';

import 'package:movie_app/Views/watchlistscreen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => Mainscreen());
      case '/Home':
        return MaterialPageRoute(builder: (_) => MovieScreen());
      case '/Details':
        return MaterialPageRoute(builder: (_) => MovieDetailScreen());
      case '/watchlist':
        return MaterialPageRoute(builder: (_) => WatchlistScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/Wrapper':
        return MaterialPageRoute(builder: (_) => AuthWrapper());
      // case '/Cart':
      //   return MaterialPageRoute(builder: (_) => Cartscreen());
      // case '/Login':
      //   return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
