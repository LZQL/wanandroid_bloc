import 'package:flutter/cupertino.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

void main() {
  /// 初始化 flutter_flipperkit
//  FlipperClient flipperClient = FlipperClient.getDefault();
//  flipperClient.addPlugin(new FlipperNetworkPlugin());
//  flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
//  flipperClient.addPlugin(
//      new FlipperDatabaseBrowserPlugin(SqfliteDriver('libCachedImageData.db')));
//  flipperClient.start();

  /// 注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  /// 初始化Sp
  SpUtil.getInstance();

  /// Bloc
  BlocSupervisor.delegate = SimpleBlocDelegate();

  /// 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiBlocProvider(providers: [
      BlocProvider<CollectBloc>(builder: (context) => CollectBloc()),
      BlocProvider<ApplicationBloc>(builder: (context) => ApplicationBloc()),
      BlocProvider<LoginBloc>(builder: (context) => LoginBloc())
    ], child: MyApp()));

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  Color _themeColor = themeColorMap['main'];

//  Color _themeColor = ColorT.app_main;

  @override
  void initState() {
    super.initState();
    setLocalizedValues(localizedValues);

    /// 开启debug模式
    DioUtil.openDebug();

    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    applicationBloc.state.listen((value) {
      if (value is InitApplicationState) {
        loadThemeAndLanguage();
      } else if (value is ThemeApplicatioinState) {
        setState(() {
          _themeColor = themeColorMap[value.themeColor];
        });
      } else if (value is LanguageApplicationState) {
        setState(() {
          if (value.languageModel != null &&
              value.languageModel.titleId != Ids.languageAuto) {
            _locale = new Locale(value.languageModel.languageCode,
                value.languageModel.countryCode);
          } else {
            _locale = null;
          }
        });
      }
    });
  }

  /// 初始化 国际化  和  主题色
  void loadThemeAndLanguage() {
    setState(() {
      // 国际化
      LanguageModel model = SpHelper.getLanguageModel();
      if (model != null) {
        _locale = new Locale(model.languageCode, model.countryCode);
      } else {
        _locale = null;
      }

      // 主题色
      String _colorKey = SpHelper.getThemeColor();
      if (themeColorMap[_colorKey] != null)
        _themeColor = themeColorMap[_colorKey];
    });
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        textStyle: TextStyle(fontSize: 14, color: Colors.white),
        backgroundColor: Colors.black.withAlpha(150),
        radius: 20.0,
//        position: ToastPosition(align: Alignment.bottomCenter, offset: -40),
        textPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: MaterialApp(
          title: 'Wandroid Bloc',
          locale: _locale,
          theme: ThemeData.light().copyWith(
              primaryColor: _themeColor,
              accentColor: _themeColor,
              indicatorColor: Colors.white,
              bottomAppBarColor: Colors.white,
              primaryColorBrightness: Brightness.dark),
          localizationsDelegates: [
            CustomLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: CustomLocalizations.supportedLocales,

          /// 生成路由
          onGenerateRoute: Application.router.generator,
        ));
  }
}
