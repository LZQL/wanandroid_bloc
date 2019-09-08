import 'package:wanandroid_bloc/common/index_all.dart';


/// 自定义全局 ZekingRefresh
class MyZekingRefresh extends StatefulWidget {

  final ZekingRefreshController controller;
  final Function onRefresh; // 下拉刷新回调,
  final Function onLoading; // 加载更多回调
  final Widget child;
  final double displacement;
  final bool canLoadMore; // 是否支持加载更多操作,默认支持
  final ScrollController scrollController;
  final bool canRefresh; // 是否支持下拉刷新操作，默认支持

  final ScrollPhysics physics;
  final bool useScrollController; // 是否自动绑定scrollController

  // 刷新 加载中 widget
  final Widget refreshLoadingWidget;
  final String refreshLoadingImagePath;

  // 刷新 空数据 widget
  final Widget refreshEmptyWidget;
  final String refreshEmptyMessage;
  final String refreshEmptyImagePath;
  final double refreshEmptyImageWidth;
  final double refreshEmptyImageHeight;
  final double refreshEmptyCenterPadding;

  // 刷新 失败 widget
  final Widget refreshFailWidget;
  final String refreshFailMessage;
  final String refreshFailImagePath;
  final double refreshFailImageWidth;
  final double refreshFailImageHeight;
  final double refreshFailCenterPadding;

  // 加载更多 加载中  widget
  final Widget loadLoadingWidget;
  final String loadLoadingMessage;

  // 加载更多 失败 widget
  final Widget loadFailWidget;
  final String loadFailMessage;


  // 加载更多 已加载全部数据 widget
  final Widget loadNoMoreWidget;
  final String loadNoMoreMessage;

  // 加载中 widget （一般用户，事件的操作，比如 登录，上传数据，提交等操作场景）
  final Widget loadingWidget;

  final Function toastMethod; // 支持 自定义 吐司

  MyZekingRefresh({@required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
    this.displacement,
    this.canLoadMore = true,
    this.canRefresh = true,
    this.scrollController,
    this.physics,
    this.useScrollController = true,
    this.refreshLoadingWidget,
    this.refreshLoadingImagePath,
    this.refreshEmptyWidget,
    this.refreshEmptyMessage,
    this.refreshEmptyImagePath,
    this.refreshEmptyImageWidth,
    this.refreshEmptyImageHeight,
    this.refreshEmptyCenterPadding,
    this.refreshFailWidget,
    this.refreshFailMessage,
    this.refreshFailImagePath,
    this.refreshFailImageWidth,
    this.refreshFailImageHeight,
    this.refreshFailCenterPadding,
    this.loadLoadingWidget,
    this.loadLoadingMessage,
    this.loadFailWidget,
    this.loadFailMessage,
    this.loadNoMoreWidget,
    this.loadNoMoreMessage,
    this.loadingWidget,
    this.toastMethod});

  @override
  _MyZekingRefreshState createState() => _MyZekingRefreshState();
}

class _MyZekingRefreshState extends State<MyZekingRefresh> {
  @override
  Widget build(BuildContext context) {
    return ZekingRefresh(
      controller: widget.controller,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      child: widget.child,
      displacement: widget.displacement,
      canLoadMore: widget.canLoadMore,
      canRefresh: widget.canRefresh,
      scrollController: widget.scrollController,
      physics: widget.physics,
      useScrollController: widget.useScrollController,
      refreshLoadingWidget: widget.refreshLoadingWidget,
      refreshLoadingImagePath: widget.refreshLoadingImagePath ?? ImageUtil.getImgPath('common_loading'),
      refreshEmptyWidget: widget.refreshEmptyWidget,
      refreshEmptyMessage: widget.refreshEmptyMessage ?? IntlUtil.getString(context, Ids.no_data_try_again),
      refreshEmptyImagePath: widget.refreshEmptyImagePath ?? ImageUtil.getImgPath('empty'),
      refreshEmptyImageWidth: widget.refreshEmptyImageWidth ?? Dimens.size(273),
      refreshEmptyImageHeight: widget.refreshEmptyImageHeight ?? Dimens.size(244),
      refreshEmptyCenterPadding: widget.refreshEmptyCenterPadding ?? Dimens.size(72),
      refreshFailWidget: widget.refreshFailWidget,
      refreshFailMessage: widget.refreshFailMessage ?? IntlUtil.getString(context, Ids.load_failed_try_again),
      refreshFailImagePath: widget.refreshFailImagePath  ?? ImageUtil.getImgPath('failure'),
      refreshFailImageWidth: widget.refreshFailImageWidth ?? Dimens.size(273),
      refreshFailImageHeight: widget.refreshFailImageHeight ?? Dimens.size(244),
      refreshFailCenterPadding: widget.refreshFailCenterPadding ?? Dimens.size(72),
      loadLoadingWidget: widget.loadLoadingWidget,
      loadLoadingMessage: widget.loadLoadingMessage ?? IntlUtil.getString(context, Ids.more_data_is_loading),
      loadFailWidget: widget.loadFailWidget,
      loadFailMessage: widget.loadFailMessage ?? IntlUtil.getString(context, Ids.failed_to_load_please_click_retry),
      loadNoMoreWidget: widget.loadNoMoreWidget,
      loadNoMoreMessage: widget.loadNoMoreMessage ?? IntlUtil.getString(context, Ids.all_data_has_been_loaded),
      loadingWidget: widget.loadingWidget,
      toastMethod: widget.toastMethod ?? showToast,
    );
  }
}
