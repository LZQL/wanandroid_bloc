import 'package:wanandroid_bloc/common/index_all.dart';

class NavigatorUtils {
  /// 返回
  static void goBack(BuildContext context) {
    /// 其实这边调用的是 Navigator.pop(context);
//    Application.router.pop(context);
    Navigator.pop(context);
  }

  /// 带参数的返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

  /// 页面传参与goBackWithParams方法一起使用
  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  ///  跳转到主页
  static goMainPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.main, replace: true);
  }

  /// 跳转到 webview 页面
  static goWebView(
    BuildContext context,
    String link,
    String title,
  ) {
    /// 对中文进行编码
    String tempLink = FluroConvertUtils.fluroCnParamsEncode(link);
    String tempTitle = FluroConvertUtils.fluroCnParamsEncode(title);

    Application.router.navigateTo(
        context, Routes.webview + "?link=$tempLink&title=$tempTitle");
  }

  /// 跳转到 项目分类 页面
  static goProjectClassify(BuildContext context) {
    Application.router.navigateTo(context, Routes.projectClassify);
  }

  /// 跳转到 体系 下的文章列表 页面
  static goSystemPage(BuildContext context, int cid, String name) {
    String mName = FluroConvertUtils.fluroCnParamsEncode(name);
    Application.router
        .navigateTo(context, Routes.system + "?cid=$cid&name=$mName");
  }

  /// 设置
  static goSettingPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.setting);
  }

  /// 语言切换页面
  static goLanguagePage(BuildContext context) {
    Application.router.navigateTo(context, Routes.language);
  }

  /// 登录
  static goLoginPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.login);
  }

  /// 收藏列表
  static goCollectListPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.collectList);
  }

  /// 搜索
  static goSearchPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.search);
  }

  /// 关于
  static goAboutPage(BuildContext context) {
    Application.router.navigateTo(context, Routes.about);
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
