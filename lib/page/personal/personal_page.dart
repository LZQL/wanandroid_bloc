import 'package:wanandroid_bloc/common/index_all.dart';

/// 个人中心 页面
class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage>
    with AutomaticKeepAliveClientMixin {
  ApplicationBloc _applicationBloc;
  String loginTitle;

  @override
  void initState() {
    super.initState();
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    loginTitle = SpHelper.getLoginUserName();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MyTitleBar(
        IntlUtil.getString(context, Ids.personalTab),
        userThemeStyle: true,
        leftImageVisible: false,
      ),
      body: BlocBuilder(
          bloc: _applicationBloc,
          builder: (context, state) {
            if (state is UpdateDataState) {
              loginTitle = SpHelper.getLoginUserName();
            }

            return Container(
              color: ColorT.color_background,
              child: Column(
                children: <Widget>[
                  PersonalItem(
                    title: SpHelper.getIsLogin()
                        ? loginTitle
                        : IntlUtil.getString(context, Ids.login),
                    onClick: loginClick,
                    showGo: false,
                  ),
                  Gaps.vGap20,
                  PersonalItem(
                    title: IntlUtil.getString(context, Ids.my_collect),
                    onClick: collectListClick,
                  ),
                  Gaps.vGap20,
                  PersonalItem(
                    title: IntlUtil.getString(context, Ids.setting),
                    onClick: settingClick,
                  ),
                  Gaps.vGap20,
                  PersonalItem(
                    title: IntlUtil.getString(context, Ids.about),
                    onClick: about,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void loginClick() {
    if (!SpHelper.getIsLogin()) {
      NavigatorUtils.goLoginPage(context);
    }
  }

  void collectListClick() {
    if (SpHelper.getIsLogin()) {
      NavigatorUtils.goCollectListPage(context);
    } else {
      showToast(IntlUtil.getString(context, Ids.please_login_first));
    }
  }

  void settingClick() {
    NavigatorUtil.pushPage(context, SettingPage());
  }


  void about(){
    NavigatorUtils.goAboutPage(context);
  }

  @override
  bool get wantKeepAlive => true;
}
