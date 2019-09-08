import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class LoginBaseEvent extends Equatable {
  LoginBaseEvent([List props = const []]) : super(props);
}


/// 登录 Event
class LogineEvent extends LoginBaseEvent {
  final String username;
  final String password;

  LogineEvent(this.username, this.password) : super([username, password]);

  @override
  String toString() {
    return 'LogineEvent -> $username:$password';
  }
}

/// 退出登录
class LogineOutEvent extends LoginBaseEvent {
  LogineOutEvent() : super([]);

  @override
  String toString() {
    return 'LogineOutEvent';
  }
}

/// 注册
class RegisterEvent extends LoginBaseEvent {
  final String username;
  final String password;
  final String repassword;

  RegisterEvent(this.username, this.password, this.repassword)
      : super([username, password, repassword]);

  @override
  String toString() {
    return 'RegisterEvent -> $username:$password:$repassword';
  }
}
