import 'package:wanandroid_bloc/common/index_all.dart';
import 'package:flutter/cupertino.dart';

///页面的模式
enum LoginMode {
  ///登录账户
  LOGIN,

  ///注册账户
  REGIST,
}

class LoginModeNotification extends Notification {
  final LoginMode mode;

  LoginModeNotification(this.mode);
}

/// 登录
class LoginPage extends StatefulWidget {
  static const String ROUTER_NAME = "/LoginWanandroidPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  LoginMode mode;
  AnimationController animationController;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    mode = LoginMode.LOGIN;
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.elasticOut);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTitleBar(
        mode == LoginMode.LOGIN
            ? IntlUtil.getString(context, Ids.login)
            : IntlUtil.getString(context, Ids.register),
        gradient: false,
        userThemeStyle: true,
        showDivider: false,
        backgroudColor: Color.fromARGB(
            170,
            Theme.of(context).primaryColor.red,
            Theme.of(context).primaryColor.green,
            Theme.of(context).primaryColor.blue),
      ),
      body: NotificationListener<LoginModeNotification>(
        onNotification: (notification) {
          setState(() {
            mode = notification.mode;
          });
        },
        child: Container(
          color: ColorT.color_background,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: Dimens.size(400),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(
                            170,
                            Theme.of(context).primaryColor.red,
                            Theme.of(context).primaryColor.green,
                            Theme.of(context).primaryColor.blue),
                        Theme.of(context).primaryColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: Dimens.size(100),
                  child: Image.asset(
                    ImageUtil.getImgPath('ic_launcher'),
                    width: Dimens.size(200),
                    height: Dimens.size(150),
                    color: Colors.white,
                  ),
                ),
                ScaleTransition(
                  scale: curvedAnimation,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimens.size(340)),
                    child: LoginCard(
                      mode: mode,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  bool isLogining;
  LoginMode mode;

  LoginCard({
    this.isLogining = false,
    this.mode = LoginMode.LOGIN,
  });

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  TextEditingController userController;
  TextEditingController pwdController;
  TextEditingController pwdAgainController;
  FocusNode usernameFocus;
  FocusNode pwdFocus;
  FocusNode pwdAgainFocus;

  LoginBloc _loginBloc;
  ApplicationBloc _applicationBloc;

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _applicationBloc = BlocProvider.of<ApplicationBloc>(context);

    userController = TextEditingController();
    pwdController = TextEditingController();
    pwdAgainController = TextEditingController();
    usernameFocus = FocusNode();
    pwdFocus = FocusNode();
    pwdAgainFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginBaseState state) {
        if (state is LoginSuccessState) {
          showToast(IntlUtil.getString(context, Ids.login_success));
          _applicationBloc.dispatch(UpdateDataEvent());
          NavigatorUtils.goBack(context);
        }

        if (state is LoginFailState) {
          showToast(state.errorMsg);
          widget.isLogining = false;
        }

        if (state is RegisterSuccessState) {
          showToast(IntlUtil.getString(context, Ids.register_success));
          NavigatorUtils.goBack(context);
        }

        if (state is RegisterFailState) {
          showToast(state.errorMsg);
          widget.isLogining = false;
        }
      },
      child: BlocBuilder(
          bloc: _loginBloc,
          builder: (context, state) {
            return Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: ColorT.divider,
                    blurRadius: 9,
                    spreadRadius: 3,
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                    topRight: Radius.elliptical(25, 25),
                    bottomLeft: Radius.elliptical(25, 25),
                  ),
                ),
              ),
              child: Container(
                  width: Dimens.size(620),
                  padding: EdgeInsets.all(
                    Dimens.size(40),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      //用户名
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: Dimens.size(32)),
                            child: Icon(
                              Icons.account_circle,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onSubmitted: (String str) {
                                FocusScope.of(context).requestFocus(pwdFocus);
                              },
                              textInputAction: TextInputAction.next,
                              focusNode: usernameFocus,
                              controller: userController,
                              style: TextStyle(
                                fontSize: Dimens.sp(32),
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                hintText: IntlUtil.getString(context, Ids.username),
                                hintStyle: TextStyle(
                                  fontSize: Dimens.sp(32),
                                  color: ColorT.color_999999,
                                ),
                                contentPadding: EdgeInsets.only(
                                  top: Dimens.size(40),
                                  bottom: Dimens.size(16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: Dimens.size(40),
                      ),
                      //密码
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: Dimens.size(32)),
                            child: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              onSubmitted: (String str) {
                                if (widget.mode == LoginMode.REGIST) {
                                  FocusScope.of(context)
                                      .requestFocus(pwdAgainFocus);
                                }
                              },
                              textInputAction: widget.mode == LoginMode.LOGIN
                                  ? TextInputAction.done
                                  : TextInputAction.next,
                              focusNode: pwdFocus,
                              controller: pwdController,
                              style: TextStyle(
                                  fontSize: Dimens.sp(32),
                                  fontWeight: FontWeight.w300),
                              decoration: InputDecoration(
                                hintText: IntlUtil.getString(context, Ids.password),
                                hintStyle: TextStyle(
                                  fontSize: Dimens.sp(32),
                                  color: ColorT.color_999999,
                                ),
                                contentPadding: EdgeInsets.only(
                                  top: Dimens.size(20),
                                  bottom: Dimens.size(8),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      //确认密码
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.only(
                            top: widget.mode == LoginMode.LOGIN
                                ? 0
                                : Dimens.size(40)),
                        child: Offstage(
                          offstage: widget.mode != LoginMode.REGIST,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: Dimens.size(32)),
                                  child: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    obscureText: true,
                                    focusNode: pwdAgainFocus,
                                    controller: pwdAgainController,
                                    style: TextStyle(
                                        fontSize: Dimens.sp(32),
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      hintText: IntlUtil.getString(context, Ids.confirm_password),
                                      hintStyle: TextStyle(
                                        fontSize: Dimens.sp(32),
                                        color: ColorT.color_999999,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        top: Dimens.size(20),
                                        bottom: Dimens.size(8),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.size(60),
                      ),
                      //登录注册按钮
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(horizontal: Dimens.size(20)),
                        child: RaisedButton(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.elliptical(14, 14),
                                  bottomLeft: Radius.elliptical(14, 14),
                                  bottomRight: Radius.circular(14)),
                            ),
                            onPressed: widget.isLogining
                                ? null
                                : () {
                                    if (widget.mode == LoginMode.LOGIN) {
                                      login(userController.text,
                                          pwdController.text);
                                    } else {
                                      regist(
                                          userController.text,
                                          pwdController.text,
                                          pwdAgainController.text);
                                    }
                                  },
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimens.size(16)),
                              child: widget.isLogining
                                  ? CupertinoActivityIndicator()
                                  : Text(
                                      widget.mode == LoginMode.LOGIN
                                          ? IntlUtil.getString(
                                              context, Ids.login)
                                          : IntlUtil.getString(
                                              context, Ids.register),
                                      style: TextStyle(fontSize: Dimens.sp(36)),
                                    ),
                            )),
                      ),
                      SizedBox(
                        height: Dimens.size(30),
                      ),
                      //登录注册切换按钮
                      Container(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            child: Text(
                              widget.mode == LoginMode.LOGIN
                                  ? IntlUtil.getString(context, Ids.login)
                                  : IntlUtil.getString(context, Ids.register),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              if (widget.isLogining) {
                                return;
                              }
                              LoginModeNotification(
                                      widget.mode == LoginMode.LOGIN
                                          ? LoginMode.REGIST
                                          : LoginMode.LOGIN)
                                  .dispatch(context);
                            }),
                      ),
                    ],
                  )),
            );
          }),
    );
  }

  ///登录
  Future login(String username, String password) async {
    if (username.length == 0) {
      showToast(IntlUtil.getString(context, Ids.please_input_username));
      return;
    }

    if (password.length == 0) {
      showToast(IntlUtil.getString(context, Ids.please_input_password));
      return;
    }

    usernameFocus.unfocus();
    pwdFocus.unfocus();
    pwdAgainFocus.unfocus();
    setState(() {
      widget.isLogining = true;
    });

    _loginBloc.dispatch(LogineEvent(username, password));
  }

  ///注册并登录
  Future regist(String username, String password, String rePassword) async {
    if (username.length == 0) {
      showToast(IntlUtil.getString(context, Ids.please_input_username));
      return;
    }

    if (password.length == 0) {
      showToast(IntlUtil.getString(context, Ids.please_input_password));
      return;
    }

    if (rePassword.length == 0) {
      showToast(IntlUtil.getString(context, Ids.please_input_confirm_password));
      return;
    }
    usernameFocus.unfocus();
    pwdFocus.unfocus();
    pwdAgainFocus.unfocus();
    setState(() {
      widget.isLogining = true;
    });
    _loginBloc.dispatch(RegisterEvent(username, password, rePassword));
  }
}
