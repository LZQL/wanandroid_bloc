import 'package:wanandroid_bloc/common/index_all.dart';

class WebViewPage extends StatefulWidget {
  final String link;
  final String title;

  WebViewPage({this.link, this.title});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool isLoad = true;

  String link;
  String title;

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.close();

    flutterWebViewPlugin.onUrlChanged.listen((String url) {
//      index++;
//      print(index);
//        print('onUrlChanged : '+url);
    });

    flutterWebViewPlugin.onStateChanged.listen((state) {
      print(state.type);
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  ///================================= 页面Widget ==============================

  @override
  Widget build(BuildContext context) {
    /// 对 中文 进行解码
    link = FluroConvertUtils.fluroCnParamsDecode(widget.link);
    title = FluroConvertUtils.fluroCnParamsDecode(widget.title);
//    print(link);

    return WillPopScope(
      onWillPop: goBack,
      child: Scaffold(
        appBar: MyTitleBar(
          title,
          onLeftImageClick: goBack,
//          rightWidgetList: <Widget>[
//            IconButton(
//              icon: Icon(Icons.more_vert),
//              color: ColorT.color_333333,
//              onPressed: moreClick,
//            )
////            LikeButton(
////              width: 56.0,
////              duration: Duration(milliseconds: 500),
////              onIconClicked: (isLike) {
////                ToastUtil.showShort('isLike', context);
//////              print('onIconCliced  22');
////              },
////            ),
//          ],
          bottom: PreferredSize(
              child: Container(
                  height: Dimens.size(2),
                  child: const LinearProgressIndicator(
                    backgroundColor: ColorT.divider,
                  )),
              preferredSize: const Size.fromHeight(1.0)),
          bottomOpacity: isLoad ? 1.0 : 0.0,
//        rightImageVisible: true,
        ),
        body: Column(
          children: <Widget>[
            Gaps.vGap1,
            Expanded(
              child: WebviewScaffold(
                withZoom: true,
                url: link,
                withLocalStorage: true,
                //缓存，数据存储
                withJavascript: true,
                initialChild: Container(),
//                initialChild: LoadingView(),
              ),
            ),
            buildBottom()
          ],
        ),
      ),
    );
  }

  /// 底部布局
  Widget buildBottom() {
    return Container(
      color: Colors.white,
      height: Dimens.size(89),
      child: Column(
        children: <Widget>[
          DividerHorizontal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// 后退按钮
              buildBottomButton(Icons.arrow_back_ios, webViewGoBack),

              /// 前进按钮
              buildBottomButton(Icons.arrow_forward_ios, webViewGoForward),

              /// 刷新按钮
              buildBottomButton(Icons.autorenew, webViewReload),

              /// 浏览器打开
              buildBottomButton(Icons.language, launchInBrowser),

              /// 分享按钮
              buildBottomButton(Icons.share, share),
            ],
          )
        ],
      ),
    );
  }

  /// 底部按钮
  Widget buildBottomButton(IconData icon, Function onTap) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: Container(
          width: Dimens.size(88),
          height: Dimens.size(88),
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: Dimens.size(40),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  ///================================= 点击事件 ================================

  /// 后退 事件
  Future<bool> goBack() {
    flutterWebViewPlugin.close();
    NavigatorUtils.goBack(context);
  }

  /// webview 后退 按钮
  void webViewGoBack() {
    flutterWebViewPlugin.goBack();
  }

  /// webview 前进 按钮
  void webViewGoForward() {
    flutterWebViewPlugin.goForward();
  }

  /// webview 刷新 按钮
  void webViewReload() {
    flutterWebViewPlugin.reload();
  }

  /// 浏览器打开
  void launchInBrowser() {
    NavigatorUtils.launchInBrowser(link, title: title);
  }

  /// 分享按钮
  void share() {
    RenderBox box = context.findRenderObject();
    Share.share(title + '：' + link,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
