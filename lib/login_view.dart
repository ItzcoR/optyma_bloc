import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optyma_bloc/auth/auth_repository.dart';
import 'package:optyma_bloc/auth/form_submission_status.dart';
import 'package:optyma_bloc/auth/login/login_bloc.dart';
class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build (BuildContext context){
    //final loginBloc = BlocProvider.of<LoginBloc>(context) ;
    return Scaffold(
      body: BlocProvider(
       create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
        ),
        child: _loginForm(),
        ),
      );
  }
  Widget _loginForm(){
    return BlocListener<LoginBloc,LoginState>(
      listener: (context, state){
        final formStatus = state.formStatus;
        if(formStatus is SubmissionFailed){
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _emailField(),
            _passwordField(),
            _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField(){
    return BlocBuilder<LoginBloc,LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) => state.isValidemail ? null : "Correo no valido",
        onChanged: (value)=> context.read<LoginBloc>().add(
          LoginEmailChanged(email: value)
        ),
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Correo electrónico',
        ),
      );
    });
      
  }

  Widget _passwordField(){
    return BlocBuilder<LoginBloc,LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        validator: (value) => state.isValidPassword ? null: "Contraseña no valida",
        onChanged: (value)=> context.read<LoginBloc>().add(
          LoginPasswordChanged(password: value)
        ),
        decoration: InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Contraseña',
        ),
      );
    });
  }
  Widget _loginButton(){
    return BlocBuilder<LoginBloc,LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting ? CircularProgressIndicator()
      : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Text(
              "Como Administrador",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.amberAccent,
                  ),
            ),
            SizedBox(width: 10),
            Checkbox(value: context.read<LoginBloc>().state.adminFlag,
                onChanged: (bool value){
                  BlocProvider.of<LoginBloc>(context).add(LoginAdminFlagChanged(adminFlag: value));
                }
                ),
          ElevatedButton(
          onPressed: (){
            if(_formKey.currentState.validate()){
                context.read<LoginBloc>().add(LoginSubmited());
              }
            }, 
            child: Text('Login'),
            ),
              ],
      );
    });
  }
  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } 
}