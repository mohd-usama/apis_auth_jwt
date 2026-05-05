import 'package:apis_auth_jwt/ApiAuth/api_repository.dart';
import 'package:apis_auth_jwt/Login/login_event.dart';
import 'package:apis_auth_jwt/Login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiRepository apiRepository;

  LoginBloc(this.apiRepository) : super(InitialState()) {
    on<LoginButtonEvent>((event, emit) async {
      emit(LoadingState());
      try {
        await apiRepository.login(event.userName, event.password);
        emit(LoadedState());
      } catch (e) {
        emit(ErrorState(e.toString()));
      }
    });
  }
}
