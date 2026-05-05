

abstract class LoginState{}


class InitialState extends LoginState{}

class LoadingState extends LoginState{}

class LoadedState extends LoginState{}

class ErrorState extends LoginState{
   String? message;
   ErrorState(this.message);

}