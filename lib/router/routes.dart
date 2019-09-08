import 'package:wanandroid_bloc/common/index_all.dart';

class Routes {
  static String root = "/";
  static String main = "/main";
  static String webview = "/webview";
  static String projectClassify = "/projectClassify";
  static String system = "/system";
  static String setting = "/setting";
  static String language = "/language";
  static String login = "/login";
  static String collectList = "/collectList";
  static String search = "/search";
  static String about = "/about";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root,handler: splashHandler, transitionType: TransitionType.cupertino);
    router.define(main,handler: mainHandler, transitionType: TransitionType.cupertino);
    router.define(webview,handler: webviewHandler, transitionType: TransitionType.cupertino);
    router.define(projectClassify,handler: projectClassifyHandler, transitionType: TransitionType.cupertino);
    router.define(system,handler: systemHandler, transitionType: TransitionType.cupertino);
    router.define(setting,handler: settingHandler, transitionType: TransitionType.cupertino);
    router.define(language,handler: languageHandler, transitionType: TransitionType.cupertino);
    router.define(login,handler: loginHandler, transitionType: TransitionType.cupertino);
    router.define(collectList,handler: colllectListHandler, transitionType: TransitionType.cupertino);
    router.define(search,handler: searchHandler, transitionType: TransitionType.cupertino);
    router.define(about,handler: aboutHandler, transitionType: TransitionType.cupertino);




//    router.define(demoParams, handler: demoParamHandler);
//    router.define(returnParams, handler: returnParamHandler);
//    router.define(transitionDemo, handler: transitionDemoHandler);
//    router.define(transitionCustomDemo, handler: transitionDemoHandler);
//    router.define(transitionCupertinoDemo, handler: transitionDemoHandler);
  }
}
