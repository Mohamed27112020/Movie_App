import 'package:movie_app/Data/model/user_model.dart';

abstract class AppAuthState {}

class AppAuthInitial extends AppAuthState {}

class AppAuthLoading extends AppAuthState {}

class AppAuthAuthenticated extends AppAuthState {
  final UserModel user;
  AppAuthAuthenticated(this.user);
}

class AppAuthUnauthenticated extends AppAuthState {}

class AppAuthError extends AppAuthState {
  final String message;
  AppAuthError(this.message);
}