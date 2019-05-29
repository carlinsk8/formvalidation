import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:formvalidation/src/blocs/validators.dart';




class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar datos stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool>  get fromValidateStream => 
    Observable.combineLatest2(emailStream, passwordStream, (e,p) => true);

  //Insertar valores
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obtener ultimo valo stream
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}