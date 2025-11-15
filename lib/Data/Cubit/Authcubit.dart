import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/Cubit/Authstate.dart';
import 'package:movie_app/Data/model/user_model.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppAuthCubit extends Cubit<AppAuthState> {
  AppAuthCubit() : super(AppAuthInitial()) {
   checkAuthStatus();
  }
  final supabase = Supabase.instance.client;

  Future<void> checkAuthStatus() async {
    try {
      final session = supabase.auth.currentSession;
      if (session != null) {
        final user = UserModel(
          id: session.user.id,
          email: session.user.email!,
          fullName: session.user.userMetadata?['full_name'],
        );
        emit(AppAuthAuthenticated(user));
      } else {
        emit(AppAuthUnauthenticated());
      }
    } catch (e) {
      emit(AppAuthUnauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(AppAuthLoading());
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          fullName: response.user!.userMetadata?['full_name'],
        );
        emit(AppAuthAuthenticated(user));
      }
    } on AuthException catch (e) {
      emit(AppAuthError(e.message));
    } catch (e) {
      emit(AppAuthError('An error occurred: $e'));
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    try {
      emit(AppAuthLoading());
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (response.user != null) {
        final user = UserModel(
          id: response.user!.id,
          email: response.user!.email!,
          fullName: fullName,
        );
        emit(AppAuthAuthenticated(user));
      }
    } on AuthException catch (e) {
      emit(AppAuthError(e.message));
    } catch (e) {
      emit(AppAuthError('An error occurred: $e'));
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    emit(AppAuthUnauthenticated());
  }
}
