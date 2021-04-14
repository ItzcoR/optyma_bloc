part of 'login_bloc.dart';
class LoginState{
  final String email;
  bool get isValidemail => email.contains('@');
  final String password;
  bool get isValidPassword => password.length > 4;   
  final FormSubmissionStatus formStatus;
  final bool adminFlag;  
  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormSatus(),
    this.adminFlag = false,
  });
  LoginState copyWith({
    String email,
    String password,
    FormSubmissionStatus formStatus,
    bool adminFlag
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus,
        adminFlag: adminFlag ?? this.adminFlag,
    );
  }
}