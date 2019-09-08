import 'package:wanandroid_bloc/common/index_all.dart';

/// 设置 页面
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  LoginBloc _loginBloc;
  ZekingRefreshController _refreshController;
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    _refreshController =  new ZekingRefreshController();
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    return Scaffold(
        appBar: MyTitleBar(
          IntlUtil.getString(context, Ids.setting),
          userThemeStyle: true,
          onLeftImageClick: () {
            NavigatorUtils.goBack(context);
          },
        ),
        body: BlocListener(
          bloc: _loginBloc,
          listener: (BuildContext context, LoginBaseState state) {
            if (state is LoginOutSuccessState) {
              _refreshController.loadingEnd(toastMsg: '退出登录成功');
              _applicationBloc.dispatch(UpdateDataEvent());
              NavigatorUtils.goBack(context);
            }

            if(state is LoginOutFailState){
              _refreshController.loadingEnd(toastMsg: state.errorMsg);
            }
          },
          child: BlocBuilder(
              bloc: _loginBloc,
              builder: (context, state) {
                return MyZekingRefresh(
                  controller: _refreshController,
                  canRefresh: false,
                  canLoadMore: false,
                  child: ListView(
                      children: <Widget>[
                        /// 主题色
                        new ExpansionWidget(
                          backgroundColor: Colors.white,
                          title: Text(
                            IntlUtil.getString(context, Ids.themeColor),
                            style: TextStyles.size28color333333,
                          ),
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: Container(
                                width: SystemScreenUtil.getInstance().screenWidth,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: new Wrap(
                                  children: themeColorMap.keys.map((String key) {
                                    Color value = themeColorMap[key];
                                    return new InkWell(
                                      onTap: () {
                                        applicationBloc
                                            .dispatch(ThemeApplication(key));
                                      },
                                      child: new Container(
                                        margin: EdgeInsets.all(5.0),
                                        width: 36.0,
                                        height: 36.0,
                                        color: value,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          ],
                        ),
                        DividerHorizontalMargin(),

                        /// 语言
                        PersonalItem(
                          title: IntlUtil.getString(context, Ids.language),
                          rightText: SpHelper.getLanguageModel() == null
                              ? IntlUtil.getString(context, Ids.languageAuto)
                              : IntlUtil.getString(
                                  context, SpHelper.getLanguageModel().titleId,
                                  languageCode: 'zh', countryCode: 'CH'),
                          onClick: () {
                            NavigatorUtils.goLanguagePage(context);
                          },
                        ),
                        Gaps.vGap20,

                        /// 退出登录
                        Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: loginOut,
                            child: Container(
                              alignment: Alignment.center,
                              height: Dimens.size(90),
                              child: Text(
                                IntlUtil.getString(context, Ids.logout),
                                style: TextStyles.size28color333333,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                );
              }),
        ));
  }

  void loginOut() {
    if (SpHelper.getIsLogin()) {


      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: new SingleChildScrollView(
              child: new Text(
                IntlUtil.getString(context, Ids.are_you_sure_to_log_out),
                style: TextStyles.size32color333333,
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(IntlUtil.getString(context, Ids.cancel),
                    style: TextStyles.size28color333333),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(IntlUtil.getString(context, Ids.confirm),
                    style:
                    TextStyle(fontSize: Dimens.size(28), color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                  _refreshController.loading();
                  _loginBloc.dispatch(LogineOutEvent());
                },
              ),
            ],
          );
        },
      );

    } else {
      showToast(IntlUtil.getString(context, Ids.please_login_first));
    }
  }
}
