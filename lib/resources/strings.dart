import 'string_en.dart';
import 'string_cn.dart';
import 'string_hk.dart';

class Ids {
  static const String blogTab = 'blogTab';
  static const String projectTab = 'projectTab';
  static const String publicTab = 'publicTab';
  static const String systemTab = 'systemTab';
  static const String personalTab = 'personalTab';
  static const String latestProject = 'latestProject';
  static const String classify = 'classify';
  static const String projectClassify = 'projectClassify';

  static const String setting = 'setting';
  static const String themeColor = 'themeColor';
  static const String language = 'language';
  static const String languageAuto = 'languageAuto';
  static const String languageZH = 'language_zh';
  static const String languageHK = 'language_hk';
  static const String languageEN = 'language_en';

  static const String save = 'save';
  static const String logout = 'Log out';
  static const String forget_password = 'forget_password';
  static const String login = 'login';
  static const String register = 'register';
  static const String confirm = 'confirm';
  static const String cancel = 'cancel';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String submitted = 'submitted';

  static const String my_collect = 'my_collect';
  static const String cancel_collect = 'cancel_collect';
  static const String are_you_sure_to_cancel_the_collection =
      'are_you_sure_to_cancel_the_collection';
  static const String are_you_sure_to_log_out = 'are_you_sure_to_log_out';

  static const String login_success = 'login_success';
  static const String login_failed = 'login_failed';

  static const String logout_success = 'logout_success';
  static const String logout_failed = 'logout_failed';

  static const String collect_success = 'collect_success';
  static const String collect_failed = 'collect_failed';

  static const String register_success = 'register_success';
  static const String register_failed = 'register_failed';

  static const String username = 'username';
  static const String confirm_password = 'confirm_password';
  static const String please_input_username = 'please_input_username';
  static const String please_input_password = 'please_input_password';
  static const String please_input_confirm_password = 'please_input_confirm_password';
  static const String please_input_search_keywords = 'please_input_search_keywords';
  static const String please_login_first = 'please_login_first';

  static const String cancel_collect_success = 'cancel_collect_success';
  static const String cancel_collect_failed = 'cancel_collect_failed';

  static const String about = 'about';

  /// ===================  ZekingRefresh  ===========================
  static const String no_data_try_again = 'no_data_try_again';
  static const String load_failed_try_again = 'load_failed_try_again';
  static const String failed_to_load_please_click_retry =
      'failed_to_load_please_click_retry';
  static const String all_data_has_been_loaded = 'all_data_has_been_loaded';
  static const String more_data_is_loading = 'more_data_is_loading';
}

Map<String, Map<String, String>> localizedSimpleValues = {
  'en': stringEn,
  'zh': stringCn,
};

Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': stringEn,
  },
  'zh': {
    'CN': stringCn,
    'HK': stringHK,
//    'TW':
  }
};
