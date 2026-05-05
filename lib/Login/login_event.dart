abstract class LoginEvent {}

class LoginButtonEvent extends LoginEvent {
  final String userName;
  final String password;

  LoginButtonEvent(this.userName, this.password);
}
