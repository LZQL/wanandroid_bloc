import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wanandroid_bloc/model/model.dart';

@immutable
abstract class ApplicationState extends Equatable {
  ApplicationState([List props = const []]) : super(props);
}

class InitApplicationState extends ApplicationState{}

class LanguageApplicationState extends ApplicationState {
  final LanguageModel languageModel;

  LanguageApplicationState(this.languageModel) : super([languageModel]);
}

class ThemeApplicatioinState extends ApplicationState {
  final String themeColor;

  ThemeApplicatioinState(this.themeColor) : super([themeColor]);
}

class UpdateDataState extends ApplicationState {

  final int id;

  UpdateDataState({this.id});

}