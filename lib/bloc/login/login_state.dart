import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class LoginBaseState {
//  LoginBaseState([List props = const []]) : super(props);
}

class InitLoginState extends LoginBaseState {}

class LoginSuccessState extends LoginBaseState {
  final UserModel userModel;

  LoginSuccessState({this.userModel});

  @override
  String toString() {
    return 'LoginSuccessState';
  }
}

class LoginFailState extends LoginBaseState {
  final String errorMsg;

  LoginFailState({this.errorMsg});

  @override
  String toString() {
    return 'LoginFailState';
  }
}

class LoginOutSuccessState extends LoginBaseState {
  @override
  String toString() {
    return 'LoginOutSuccessState';
  }
}

class LoginOutFailState extends LoginBaseState {
  final String errorMsg;

  LoginOutFailState({this.errorMsg});

  @override
  String toString() {
    return 'LoginOutFailState';
  }
}

class RegisterSuccessState extends LoginBaseState {
  @override
  String toString() {
    return 'RegisterSuccessState';
  }
}

class RegisterFailState extends LoginBaseState {
  final String errorMsg;

  RegisterFailState({this.errorMsg});

  @override
  String toString() {
    return 'RegisterFailState';
  }
}
