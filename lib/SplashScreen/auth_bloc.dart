import 'package:apis_auth_jwt/ApiAuth/api_repository.dart';
import 'package:apis_auth_jwt/SplashScreen/auth_event.dart';
import 'package:apis_auth_jwt/SplashScreen/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiRepository apiRepository;

  AuthBloc(this.apiRepository) : super(AuthInitial()) {
    on<CheckSessionEvent>((event, emit) async {
      print("Event Triggered");

      emit(AuthLoading());

      final isLoggedIn = await apiRepository.checkSession();

      print("isLoggedIn: $isLoggedIn");

      if (isLoggedIn) {
        emit(AuthSuccess());
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }
}
