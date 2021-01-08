import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// localizedSimpleValues exapmle.
/// Map<String, Map<String, String>> _localizedSimpleValues = {
///   'en': {
///     'ok': 'OK',
///   },
///   'zh': {
///     'ok': '确定',
///   },
/// };
Map<String, Map<String, String>> _localizedSimpleValues = {};

/// localizedValues exapmle.
/// Map<String, Map<String, Map<String, String>>> _localizedValues = {
///   'en': {
///     'US': {
///       'ok': 'OK',
///     }
///   },
///   'zh': {
///     'CN': {
///       'ok': '确定',
///     },
///     'HK': {
///       'ok': '確定',
///     },
///     'TW': {
///       'ok': '確定',
///     }
///   }
/// };
Map<String, Map<String, Map<String, String>>> _localizedValues = {};

/// set localized simple values.
/// 配置简单多语言资源.
void setLocalizedSimpleValues(
    Map<String, Map<String, String>> localizedValues) {
  _localizedSimpleValues = localizedValues;
}

/// set localized values.
/// 配置多语言资源.
void setLocalizedValues(
    Map<String, Map<String, Map<String, String>>> localizedValues) {
  _localizedValues = localizedValues;
}

/// CustomLocalizations.
/// 自定义本地化支持.
class CustomLocalizations implements CupertinoLocalizations {
  CustomLocalizations(this.locale);

  final materialDelegate = GlobalMaterialLocalizations.delegate;

  Locale locale;

  static CustomLocalizations instance;

  ///不推荐使用.
  static void init(BuildContext context) {
    instance = of(context);
  }

  static CustomLocalizations of(BuildContext context) {
    return CupertinoLocalizations.of(context);
    /// 实现CupertinoLocalizations抽象类后，取不到对象，得换成CupertinoLocalizations.of(context);
//    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  /// get string by id,Can be specified languageCode,countryCode.
  /// 通过id获取字符串,可指定languageCode,countryCode.
  String getString(String id,
      {String languageCode, String countryCode, List<Object> params}) {
    String value;
    String _languageCode = languageCode ?? locale.languageCode;
    if (_localizedSimpleValues.isNotEmpty) {
      value = _localizedSimpleValues[_languageCode][id];
    } else {
      String _countryCode = countryCode ?? locale.countryCode;
      if (_countryCode == null ||
          _countryCode.isEmpty ||
          !_localizedValues[_languageCode].keys.contains(_countryCode)) {
        _countryCode = _localizedValues[_languageCode].keys.toList()[0];
      }
      value = _localizedValues[_languageCode][_countryCode][id];
    }
    if (params != null && params.isNotEmpty) {
      for (int i = 0, length = params.length; i < length; i++) {
        value = value?.replaceAll('%\$$i\$s', '${params[i]}');
      }
    }
    return value;
  }

  /// supported Locales
  /// 支持的语言
  static Iterable<Locale> supportedLocales = _getSupportedLocales();

  static List<Locale> _getSupportedLocales() {
    List<Locale> list = new List();
    if (_localizedSimpleValues.isNotEmpty) {
      _localizedSimpleValues.keys.forEach((value) {
        list.add(new Locale(value, ''));
      });
    } else {
      _localizedValues.keys.forEach((value) {
        _localizedValues[value].keys.forEach((vv) {
          list.add(new Locale(value, vv));
        });
      });
    }
    return list;
  }

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
//  static const LocalizationsDelegate<CustomLocalizations> delegate =
  _CustomLocalizationsDelegate();


  /// 基于Map，根据当前语言的 languageCode： en或zh来获取对应的文案
  static Map<String, BaseLanguage> _localValue = {
    'en' : EnLanguage(),
    'zh' : ChLanguage()
  };

  /// 返回当前的内容维护类
  BaseLanguage get currentLocalized {
    return _localValue[locale.languageCode];
  }

  @override
  String get selectAllButtonLabel {
    return currentLocalized.selectAllButtonLabel;
  }

  @override
  String get pasteButtonLabel {
    return currentLocalized.pasteButtonLabel;
  }

  @override
  String get copyButtonLabel {
    return currentLocalized.copyButtonLabel;
  }

  @override
  String get cutButtonLabel {
    return currentLocalized.cutButtonLabel;
  }

  @override
  String get todayLabel {
    return "今天";
  }

  static const List<String> _shortWeekdays = <String>[
    '周一',
    '周二',
    '周三',
    '周四',
    '周五',
    '周六',
    '周日',
  ];

  static const List<String> _shortMonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const List<String> _months = <String>[
    '01月',
    '02月',
    '03月',
    '04月',
    '05月',
    '06月',
    '07月',
    '08月',
    '09月',
    '10月',
    '11月',
    '12月',
  ];

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString() + "年";

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex) => dayIndex.toString() + "日";

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => hour.toString() + " 小时";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    return '1 分钟';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.ymd;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get alertDialogLabel => '提示信息';

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => '时';

  @override
  String timerPickerMinuteLabel(int minute) => '分';

  @override
  String timerPickerSecondLabel(int second) => '秒';

  @override
  // TODO: implement modalBarrierDismissLabel
  String get modalBarrierDismissLabel => null;

  @override
  String tabSemanticsLabel({int tabIndex, int tabCount}) {
    // TODO: implement tabSemanticsLabel
    // throw UnimplementedError();
    return 'tabSemanticsLabel : `tabIndex:$tabIndex` and `tabCount:$tabCount`';
  }
}

/// 这个抽象类和它的实现类可以拉出去新建类
/// 中文和英语 语言内容维护
abstract class BaseLanguage {
  String name;
  String selectAllButtonLabel;
  String pasteButtonLabel;
  String copyButtonLabel;
  String cutButtonLabel;
}

class EnLanguage implements BaseLanguage {

  @override
  String name = "This is English";
  @override
  String selectAllButtonLabel = "Select All";//全选 英语
  @override
  String pasteButtonLabel = "Paste"; // 粘贴 英语
  @override
  String copyButtonLabel = "Copy";// 复制 英语
  @override
  String cutButtonLabel = "Shear"; // 剪切 英语
}

class ChLanguage implements BaseLanguage {

  @override
  String name = "这是中文";
  @override
  String selectAllButtonLabel = "全选";
  @override
  String pasteButtonLabel = "粘贴";
  @override
  String copyButtonLabel = "复制";
  @override
  String cutButtonLabel = "剪切";

}

class _CustomLocalizationsDelegate
//    extends LocalizationsDelegate<CustomLocalizations> {
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => (_localizedSimpleValues.isNotEmpty
      ? _localizedSimpleValues.keys.contains(locale.languageCode)
      : _localizedValues.keys.contains(locale.languageCode));
  ///根据locale，创建一个对象用于提供当前locale下的文本显示
  ///Flutter会调用此类加载相应的Locale资源类
  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return new SynchronousFuture<CupertinoLocalizations>(
//    return new SynchronousFuture<CustomLocalizations>(
        new CustomLocalizations(locale));
  }
  ///shouldReload的返回值决定当Localizations Widget重新build时，是否调用load方法重新加载Locale资源
  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) => false;
//  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}
