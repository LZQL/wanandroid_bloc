import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class ApplicationEvent extends Equatable {
  ApplicationEvent([List props = const []]) : super(props);
}

/// 主题色 Event
class ThemeApplication extends ApplicationEvent {

  final String themeColor;

  ThemeApplication(this.themeColor) : super([themeColor]);

  @override
  String toString() {
    return 'ThemeApplication -> $themeColor';
  }
}

/// 多语言
class LanguageApplication extends ApplicationEvent {

  final LanguageModel languageModel ;

  LanguageApplication(this.languageModel):super([languageModel]);

  @override
  String toString() {
    return 'IntlApplication -> $languageModel';
  }

}

/// 更新数据
class UpdateDataEvent extends ApplicationEvent {
  final int id;

  UpdateDataEvent({this.id});
}

