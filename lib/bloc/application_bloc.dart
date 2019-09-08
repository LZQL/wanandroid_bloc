
import 'package:wanandroid_bloc/common/index_all.dart';

//enum ApplicationEvent { theme, intl,user }

class ApplicationBloc extends Bloc<ApplicationEvent,ApplicationState>{


  @override
  ApplicationState get initialState => InitApplicationState();

  @override
  Stream<ApplicationState> mapEventToState(ApplicationEvent event) async*{

    if(event is ThemeApplication){
      /// 保存修改后的主题色到 sp 中
      await SpUtil.putString(Constant.SP_KEY_THEME_COLOR, event.themeColor);
      yield ThemeApplicatioinState(event.themeColor);
    }

    if(event is LanguageApplication){
      ///  保存修改后的语言 到sp 中
      await SpHelper.putObject(
                Constant.SP_KEY_LANGUAGE,
                ObjectUtil.isEmpty(event.languageModel.languageCode)
                    ? null
                    : event.languageModel);
      yield LanguageApplicationState(event.languageModel);
    }

    if(event is UpdateDataEvent){
      yield UpdateDataState();
    }

  }



}