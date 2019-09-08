import 'package:wanandroid_bloc/common/index_all.dart';

/// SharedPreferences 封装类
class SpHelper {
  // T 用于区分存储类型
  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putString(key, value == null ? "" : json.encode(value));
        break;
    }
  }

  /// 获取 语言
  static LanguageModel getLanguageModel() {
    String _saveLanguage = SpUtil.getString(Constant.SP_KEY_LANGUAGE);
    if (ObjectUtil.isNotEmpty(_saveLanguage)) {
      Map userMap = json.decode(_saveLanguage);
      return LanguageModel.fromJson(userMap);
    }
    return null;
  }

  /// 获取 主题色
  static String getThemeColor() {
    String _colorKey = SpUtil.getString(Constant.SP_KEY_THEME_COLOR);
    if (ObjectUtil.isEmpty(_colorKey)) {
      _colorKey = 'white';
    }
    return _colorKey;
  }

//  /// 获取 Splash 模式
//  static SplashModel getSplashModel() {
//    String _splashModel = SpUtil.getString(Constant.KEY_SPLASH_MODEL);
//    if (ObjectUtil.isNotEmpty(_splashModel)) {
//      Map userMap = json.decode(_splashModel);
//      return SplashModel.fromJson(userMap);
//    }
//    return null;
//  }

  /// 获取 Splash 页面 显示状态
  static int getSplashStatus() {
    int _splashStatus = SpUtil.getInt(Constant.KEY_SPLASH_STATUS);
    if (_splashStatus == null) {
      return SplashStatusType.GUIDE.index;
    }
    return _splashStatus;
  }

  /// 获取 是否已登录 状态
  static bool getIsLogin(){
    String username = SpUtil.getString(Constant.SP_KEY_LOGIN);
    if(username == null || username == ''){
      return false;
    }else{
      return true;
    }
  }

  static String getLoginUserName(){
    String username = SpUtil.getString(Constant.SP_KEY_LOGIN);
    return username ;
  }
}
