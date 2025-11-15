import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Core/uitls/Loading.dart';
import 'package:movie_app/Data/Cubit/Authcubit.dart';
import 'package:movie_app/Data/Cubit/Authstate.dart';
import 'package:movie_app/Views/Auth/Loginscreen.dart';
import 'package:movie_app/Views/Home.dart';
import 'package:movie_app/Views/navScreen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthCubit, AppAuthState>(
      listener: (context, state) {
        if (state is AppAuthAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/main');
        } else if (state is AppAuthUnauthenticated) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      },
      child: BlocBuilder<AppAuthCubit, AppAuthState>(
        builder: (context, state) {
          // Show loading screen while checking authentication
          if (state is AppAuthLoading) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [LoadingLottie()],
                ),
              ),
            );
          }

          if (state is AppAuthAuthenticated) {
            return Mainscreen();
          }

          return LoginScreen();
        },
      ),
    );
  }
}
