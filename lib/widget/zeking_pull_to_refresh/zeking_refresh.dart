//import 'package:flutter/material.dart';
//import 'package:wanandroid_bloc/common/index_all.dart';
//
//typedef OnRefresh = Future<void> Function();
//
///// 下拉刷新状态
//enum ZekingRefreshStatus {
//  IDLE, // 闲置
////  REFRESHING,
////  DONE,
//  Refreshing_LoadingView,
//  Refreshing_LoadingView_ing,
//  Refreshing,
//  Refresh_Success,
//  Refresh_Faild,
//  Refresh_Empty,
//  LoadMoreing,
//  LoadMore_Success,
//  LoadMore_Faild,
//  LoadMore_NoMore,
//}
//
//class ZekingRefresh extends StatefulWidget {
//  final ZekingRefreshController controller;
//  final Function onRefresh; //下拉刷新回调
//  final Function onLoading; // 加载更多回调
//  final Widget child;
//  final double displacement;
//  final bool canLoadMore; // 是否支持加载更多操作,默认支持
//  final ScrollController scrollController;
//  final bool canRefresh; // 是否支持下拉刷新操作，默认支持
//
//  ZekingRefresh(
//      {this.controller,
//      this.onRefresh,
//      this.onLoading,
//      this.child,
//      this.displacement,
//      this.canLoadMore = true,
//      this.canRefresh = true,
//      this.scrollController});
//
//  @override
//  _ZekingRefreshState createState() => _ZekingRefreshState();
//}
//
//class _ZekingRefreshState extends State<ZekingRefresh> {
//  ScrollController _scrollController;
//
//  @override
//  void initState() {
//    super.initState();
//
//    if (widget.scrollController == null) {
//      _scrollController = widget.child is ScrollView &&
//              (widget.child as ScrollView).controller != null
//          ? (widget.child as ScrollView).controller
//          : new ScrollController();
//    } else {
//      _scrollController = widget.scrollController;
//    }
//
//    if (widget.canLoadMore) {
//      /// 监听滚动事件
//      _scrollController.addListener(() {
//        // 如果滚动到底部
//        if (_scrollController.position.maxScrollExtent ==
//            (_scrollController.position.pixels)) {
//          if (widget.controller.refreshMode.value !=
//                  ZekingRefreshStatus.Refreshing_LoadingView &&
//              widget.controller.refreshMode.value !=
//                  ZekingRefreshStatus.Refreshing &&
//              widget.controller.refreshMode.value !=
//                  ZekingRefreshStatus.LoadMore_Faild &&
//              widget.controller.refreshMode.value !=
//                  ZekingRefreshStatus.LoadMore_NoMore) {
//            widget.onLoading();
//          }
//        }
//      });
//    }
//
//    /// 状态改变监听
//    widget.controller.refreshMode.addListener(_handleRefreshValueChanged);
//  }
//
//  void _handleRefreshValueChanged() {
//    // 如果是 LoadingView  调用 刷新方法
////    if (widget.controller.refreshMode.value ==
////        ZekingRefreshStatus.Refreshing_LoadingView) {
////      widget.onRefresh();
////    }
//
//    if (widget.canLoadMore) {
//      // 如果是 LoadMoreing  调用 加载更多方法
//      if (widget.controller.refreshMode.value ==
//          ZekingRefreshStatus.LoadMoreing) {
//        widget.onLoading();
//      }
//    }
//
//    setState(() {});
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (widget.controller.refreshMode.value ==
//        ZekingRefreshStatus.Refreshing_LoadingView_ing) {  /// 这个状态是为了防止同一个页面有多个请求同时请求的时候，多次调用onRefresh方法
//      return LoadingView();
//    }
//
//    if (widget.controller.refreshMode.value ==
//        ZekingRefreshStatus.Refreshing_LoadingView) {
//      widget.onRefresh();
//      widget.controller.refreshMode.value = ZekingRefreshStatus.Refreshing_LoadingView_ing;
//      return LoadingView();
//    }
//
//    if (widget.controller.refreshMode.value ==
//        ZekingRefreshStatus.Refresh_Empty) {
//      return ZekingRefreshEmptyWidget(
//        controller: widget.controller,
//        message: widget.controller.refreshEmptyTip.value,
//      );
//    }
//
//    if (widget.controller.refreshMode.value ==
//        ZekingRefreshStatus.Refresh_Faild) {
//      return ZekingRefreshFailWidget(
//        controller: widget.controller,
//        message: widget.controller.refreshFaildTip.value,
//      );
//    }
//
//    List<Widget> slivers;
//
//    if (widget.child is ScrollView) {
//      slivers = List.from((widget.child as ScrollView).buildSlivers(context),
//          growable: true);
//
//      /// 是否支持加载更多
//      if (widget.canLoadMore) {
//        /// FootWidget 布局
//        Widget footWidget = SliverToBoxAdapter(
//            child: widget.controller.refreshMode.value ==
//                    ZekingRefreshStatus.LoadMore_Faild
//                ? ZekingLoadFailWidget(
//                    controller: widget.controller,
//                    message: widget.controller.loadMoreFaildTip.value,
//                  )
//                : (widget.controller.refreshMode.value ==
//                        ZekingRefreshStatus.LoadMore_NoMore
//                    ? ZekingLoadNoMoreWidget(
//                        message: widget.controller.loadMoreEmptyTip.value,
//                      )
//                    : ZekingLoadingWidget()));
//        slivers.add(footWidget);
//      }
//    } else {
//      slivers = new List<Widget>();
//      slivers.add(SliverList(
//          delegate: SliverChildListDelegate(<Widget>[widget.child])));
//    }
//
//    if (widget.canRefresh) {
//      return ZekingRefreshIndicator(
//        controller: widget.controller,
//        displacement: widget.displacement == null ? 40.0 : widget.displacement,
//        onRefresh: widget.onRefresh,
//        child: CustomScrollView(
//          controller: _scrollController,
//          physics: RefreshScrollPhysics(enableOverScroll: false),
//          slivers: List.from(slivers, growable: true),
//        ),
//      );
//    } else {
//      return CustomScrollView(
//        controller: _scrollController,
//        physics: RefreshScrollPhysics(enableOverScroll: false),
//        slivers: List.from(slivers, growable: true),
//      );
//    }
//  }
//
//  @override
//  void dispose() {
//    _scrollController.dispose();
//    widget.controller.refreshMode.removeListener(_handleRefreshValueChanged);
//    super.dispose();
//  }
//}
//
//class ZekingRefreshController {
//  ValueNotifier<ZekingRefreshStatus> refreshMode =
//      new ValueNotifier(ZekingRefreshStatus.IDLE);
//
//  ValueNotifier<String> refreshFaildTip = new ValueNotifier(null);
//  ValueNotifier<String> refreshEmptyTip = new ValueNotifier(null);
//  ValueNotifier<String> loadMoreFaildTip = new ValueNotifier(null);
//  ValueNotifier<String> loadMoreEmptyTip = new ValueNotifier(null);
//
//  /// 下拉刷新， 成功
//  void refreshSuccess() {
//    refreshMode?.value = ZekingRefreshStatus.Refresh_Success;
//  }
//
//  /// 下拉刷新， 失败
//  void refreshFaild({String message}) {
//    refreshFaildTip?.value = message;
//    refreshMode?.value = ZekingRefreshStatus.Refresh_Faild;
//  }
//
//  /// 下拉刷新，空数据
//  void refreshEmpty({String message}) {
//    refreshEmptyTip?.value = message;
//    refreshMode?.value = ZekingRefreshStatus.Refresh_Empty;
//  }
//
//  void refreshingWithLoadingView() {
//    refreshMode?.value = ZekingRefreshStatus.Refreshing_LoadingView;
//  }
//
//  // ==============================================
//
//  /// 请求 加载更多
//  void requestLoading() {
//    if (refreshMode?.value == ZekingRefreshStatus.LoadMore_Faild) {
//      refreshMode?.value = ZekingRefreshStatus.LoadMoreing;
//    }
//  }
//
//  /// 加载更多 失败
//  void loadMoreFailed({String message}) {
//    loadMoreFaildTip?.value = message;
//    refreshMode?.value = ZekingRefreshStatus.LoadMore_Faild;
////    print('loadFailed');
//  }
//
//  /// 加载更多 成功
//  void loadMoreSuccess() {
//    refreshMode?.value = ZekingRefreshStatus.LoadMore_Success;
////    print('loadSuccess');
//  }
//
//  /// 加载更多 没有更多内容了
//  void loadMoreNoMore({String message}) {
//    loadMoreEmptyTip?.value = message;
//    refreshMode?.value = ZekingRefreshStatus.LoadMore_NoMore;
////    print('loadNoMore');
//  }
//
//  void dispose() {
//    refreshMode.dispose();
//    refreshMode = null;
//  }
//}
