import 'package:wanandroid_bloc/common/index_all.dart';

/// 跳转到 欢迎页面
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new SplashPage();
});

/// 跳转到 主页
var mainHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainPage();
});

/// 跳转到 webview
var webviewHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String link = params['link']?.first;
  String title = params['title']?.first;

  return WebViewPage(
      link: link, title: title);
});

/// 跳转到 项目分类
var projectClassifyHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider(
      builder: (context) => ProjectClassifyBloc(),
      child: ProjectClassifyPage());
  //return ProjectClassifyPage();
});

/// 跳转到 体系 下的文章列表 页面
var systemHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String cid = params['cid']?.first;
  String name = params['name']?.first;
  return BlocProvider(
      builder: (context) => SystemBloc(), child: SystemPage(cid, name));
  //return ProjectClassifyPage();
});

var settingHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingPage();
});

var languageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LanguagePage();
});

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
//      return BlocProvider(
//          builder: (context) => LoginBloc(), child: LoginPage());
});

var colllectListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return  CollectListPage();
//      return BlocProvider(
//          builder: (context) => LoginBloc(), child: LoginPage());
});

var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//      return  SearchPage();
      return BlocProvider(
          builder: (context) => SearchBloc(), child: SearchPage());
    });

var aboutHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return  AboutPage();
    });

//
///// 跳转到主页
//var homeHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  return HomePage();
//});
//
///// 参数传递 int ，double，bool，自定义类型
//var demoParamHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
//  /// params["name"]?.first 相当于 params["name"][0] ，打个debug 你就知道为什么了是个list
//  String name = params["name"]?.first;
//  String age = params["age"]?.first;
//  String sex = params["sex"]?.first;
//  String score = params["score"]?.first;
//  String personjson = params['personjson']?.first;
//  return DemoParamsPage(
//    name: name,
//    age: FluroConvertUtils.string2int(age),
//    score: FluroConvertUtils.string2double(score),
//    sex: FluroConvertUtils.string2bool(sex),
//    personJson: personjson,
//  );
//});
//
///// 关闭页面，返回参数
//var returnParamHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
//  return ReturnParamsPage();
//});
//
///// 转场动画 页面
//var transitionDemoHandler = new Handler(
//    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
//  String title = params["title"]?.first;
//  return TransitionDemoPage(title);
//});
