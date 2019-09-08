import 'package:wanandroid_bloc/common/index_all.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(IntlUtil.getString(context, Ids.about),userThemeStyle: true,),
      body: Column(
        children: <Widget>[

          PersonalItem(
            title: '掘金',
            onClick: juejin,
          ),
          Gaps.vGap20,
          PersonalItem(
            title: '开源插件 ZekignRefresh',
            onClick: zekingrefresh,
          ),
          Gaps.vGap20,
        ],
      ),
    );
  }

  void juejin(){
    NavigatorUtils.goWebView(
        context, 'https://juejin.im/user/57369dbfc4c97100600364a8', '掘金');
  }

  void zekingrefresh(){
    NavigatorUtils.goWebView(
        context, 'https://pub.dev/packages/zeking_refresh', 'ZekingRefresh');
  }
}
