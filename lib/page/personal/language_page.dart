//import 'package:fluintl/fluintl.dart';
//import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

/// 语言切换 页面
class LanguagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LanguagePageState();
  }
}

class _LanguagePageState extends State<LanguagePage> {
  List<LanguageModel> _list = new List();

  LanguageModel _currentLanguage;

  @override
  void initState() {
    super.initState();

    _list.add(LanguageModel(Ids.languageAuto, '', ''));
    _list.add(LanguageModel(Ids.languageZH, 'zh', 'CH'));
    _list.add(LanguageModel(Ids.languageHK, 'zh', 'HK'));
    _list.add(LanguageModel(Ids.languageEN, 'en', 'US'));

    _currentLanguage = SpHelper.getLanguageModel();
    if (ObjectUtil.isEmpty(_currentLanguage)) {
      _currentLanguage = _list[0];
    }

    _updateData();
  }

  void _updateData() {
    LogUtil.e('currentLanguage: ' + _currentLanguage.toString());
    String language = _currentLanguage.countryCode;
    for (int i = 0, length = _list.length; i < length; i++) {
      _list[i].isSelected = (_list[i].countryCode == language);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);

    return new Scaffold(
      appBar: MyTitleBar(
        IntlUtil.getString(context, Ids.language),
        userThemeStyle: true,
        onLeftImageClick: (){ NavigatorUtils.goBack(context);},
        rightTextVisible: true,
        rightText: IntlUtil.getString(context, Ids.save),
        onRightTextClick: () {
          bloc.dispatch(LanguageApplication(_currentLanguage));
          NavigatorUtils.goBack(context);
        },
      ),
      body: new ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            LanguageModel model = _list[index];
            return new ListTile(
              title: new Text(
                (model.titleId == Ids.languageAuto
                    ? IntlUtil.getString(context, model.titleId)
                    : IntlUtil.getString(context, model.titleId,
                        languageCode: 'zh', countryCode: 'CH')),
                style: new TextStyle(fontSize: 13.0),
              ),
              trailing: new Radio(
                  value: true,
                  groupValue: model.isSelected == true,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (value) {
                    setState(() {
                      _currentLanguage = model;
                      _updateData();
                    });
                  }),
              onTap: () {
                setState(() {
                  _currentLanguage = model;
                  _updateData();
                });
              },
            );
          }),
    );
  }
}
