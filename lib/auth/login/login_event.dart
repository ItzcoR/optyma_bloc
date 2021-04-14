part of 'login_bloc.dart';

abstract class LoginEvent{
  
}
class LoginEmailChanged extends LoginEvent{
  final String email; 
  LoginEmailChanged({this.email});
}
class LoginPasswordChanged extends LoginEvent{
  final String password; 
  LoginPasswordChanged({this.password});
}
class LoginAdminFlagChanged extends LoginEvent{
  final bool adminFlag;
  LoginAdminFlagChanged({this.adminFlag});
}
class LoginSubmited extends LoginEvent{
}