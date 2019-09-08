import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

typedef void OnClick();

class MyTitleBar extends StatefulWidget implements PreferredSizeWidget {
  final bool userThemeStyle; // 是否使用 主题模板

  final String title; // 标题

  final Color backgroudColor;

  final bool leftImageVisible; // 左边图片按钮 是否显示
  final String leftImage; // 左边图片按钮 图片
  final double leftImageWidth; //  左边图片 的 宽度
  final double leftImageHeigh; // 左边图片 的 高度
  final OnClick onLeftImageClick; // 左边图片按钮 点击事件

  final bool rightImageVisible; // 右边 图片按钮 是否显示
  final String rightImage; // 右边 图片按钮 图片
  final OnClick onRightImageClick; // 右边  图片按钮 点击事件

  final bool rightTextVisible; // 右边 文字按钮 是否显示
  final String rightText; // 右边 文字按钮 文字
  final OnClick onRightTextClick; // 右边 文字按钮 点击事件

  final List<Widget> rightWidgetList; // 自定义 右边 按钮组

  final PreferredSizeWidget bottom;
  final double bottomOpacity;

  final bool showDivider; // 是否显示底部分割线
  final Color dividerColor; // 分割线 颜色

  final bool gradient;  // 是否使用渐变背景

  MyTitleBar(this.title,
      {this.userThemeStyle = false,
      this.backgroudColor,
      this.leftImageVisible = true,
      this.leftImageWidth,
      this.leftImageHeigh,
      this.leftImage = 'back', // 默认是 后退键图片
      this.onLeftImageClick,
      this.rightImageVisible = false,
      this.rightImage,
      this.onRightImageClick,
      this.rightTextVisible = false,
      this.rightText = '',
      this.onRightTextClick,
      this.rightWidgetList,
      this.bottom,
      this.bottomOpacity = 1.0,
      this.showDivider = true,
      this.dividerColor = Colors.white,
      this.gradient = true});

  @override
  _MyTitleBarState createState() => _MyTitleBarState();

  @override
  Size get preferredSize => Size.fromHeight(Dimens.size(88));
}

class _MyTitleBarState extends State<MyTitleBar> {

  @override
  Widget build(BuildContext context) {

    if(widget.gradient){
      return buildTitleWithGradient(context);
    }else{
      return buildTitle(context);
    }
  }

  Widget buildTitle(context){
    return  Container(
      color: Colors.transparent,
      child: SizedBox(
        height: Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            padding:
            EdgeInsets.only(top: SystemScreenUtil.getStatusBarH(context)),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height: widget.showDivider?Dimens.size(87):Dimens.size(88),
                      child: Stack(
                        children: <Widget>[
                          /// 左边 图片 按钮
                          Offstage(
                            offstage: !widget.leftImageVisible,
                            child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimens.size(34),
                                    right: Dimens.size(32),
                                  ),
                                  child: Image.asset(
                                    MyUtil.getImgPath(widget.leftImage),
                                    width: widget.leftImageWidth == null
                                        ? Dimens.size(20)
                                        : widget.leftImageWidth,
                                    height: widget.leftImageHeigh == null
                                        ? Dimens.size(36)
                                        : widget.leftImageHeigh,
                                    color: widget.userThemeStyle
                                        ? Colors.white
                                        : ColorT.color_333333,
                                  ),
                                ),
                              ),
                              onTap: widget.onLeftImageClick ??
                                      () {
                                    NavigatorUtils.goBack(context);
                                  },
                            ),
                          ),

                          /// 标题
                          Offstage(
                            offstage: false,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 60, right: 60),
                              child: Center(
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimens.sp(36),
                                      color: widget.userThemeStyle
                                          ? Colors.white
                                          : ColorT.color_333333),
                                ),
                              ),
                            ),
                          ),

                          /// 右边 文字按钮
                          Positioned(
                            height: Dimens.size(87),
                            right: 0,
                            child: Row(
                              children: <Widget>[
                                Offstage(
                                  offstage: !widget.rightTextVisible,
                                  child: GestureDetector(
                                    onTap: widget.onRightTextClick,
                                    child: Container(
                                      color: Colors.transparent,
                                      height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: Dimens.size(32),
                                            left: Dimens.size(20)),
                                        child: Text(
                                          widget.rightText,
                                          style: TextStyle(
                                              fontSize: Dimens.sp(30),
                                              color: widget.userThemeStyle
                                                  ? Colors.white
                                                  : ColorT.color_333333),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// 右边 图片 按钮
                          Positioned(
                            height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                            right: 0,
                            child: Offstage(
                              offstage: !widget.rightImageVisible,
                              child: GestureDetector(
                                onTap: widget.onRightImageClick,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimens.size(32),
                                        top: Dimens.size(10),
                                        bottom: Dimens.size(10),
                                        left: Dimens.size(20)),
                                    child: widget.rightImageVisible
                                        ? Image.asset(
                                      MyUtil.getImgPath(
                                          widget.rightImage),
                                      color: widget.userThemeStyle
                                          ? Colors.white
                                          : ColorT.color_333333,
                                      width: Dimens.size(36),
                                      height: Dimens.size(36),
                                    )
                                        : Container(),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// 定义 右边 按钮组
                          widget.rightWidgetList == null
                              ? Container()
                              : Positioned(
                            height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                            right: 0,
                            child: Row(
                              children: widget.rightWidgetList,
                            ),


                          ),
                        ],
                      )),
//                  widget.showDivider
//                      ? DividerHorizontal()
//                      : widget.userThemeStyle
//                      ? DividerHorizontal(
//                      dividerColor: widget.dividerColor ??
//                          Theme.of(context).primaryColor)
//                      : DividerHorizontal(dividerColor: widget.dividerColor)

                  widget.showDivider
                      ? DividerHorizontal()
                      : Container()
                ],
              ),
            ),
          ),
          brightness:
          widget.userThemeStyle ? Brightness.dark : Brightness.light,
//          backgroundColor: widget.userThemeStyle
//              ? widget.backgroudColor ?? Theme.of(context).primaryColor
//              : (widget.backgroudColor == null)
//                  ? Colors.white
//                  : widget.backgroudColor,
          backgroundColor: widget.userThemeStyle
              ? widget.backgroudColor ?? Theme.of(context).primaryColor
              : (widget.backgroudColor == null)
              ? Colors.white
              : widget.backgroudColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          //设置没有返回按钮
          bottom: widget.bottom,
          bottomOpacity: widget.bottomOpacity,
        ),
      ),
    );
  }

  Widget buildTitleWithGradient(context){

    List<Color> tempColor;
    if (widget.userThemeStyle) {
      if (widget.backgroudColor == null) {
        tempColor = [
          Color.fromARGB(
              170,
              Theme.of(context).primaryColor.red,
              Theme.of(context).primaryColor.green,
              Theme.of(context).primaryColor.blue),
          Theme.of(context).primaryColor

        ];
      } else {
        tempColor = [
          Color.fromARGB(170, widget.backgroudColor.red,
              widget.backgroudColor.green, widget.backgroudColor.blue),
          widget.backgroudColor
        ];
      }
    } else {
      if (widget.backgroudColor == null) {
        tempColor = [Colors.white,Colors.white];
      } else {
        tempColor = [
          Color.fromARGB(170, widget.backgroudColor.red,
              widget.backgroudColor.green, widget.backgroudColor.blue),
          widget.backgroudColor
        ];
      }
    }

    return  Container(
      color: Colors.transparent,
      child: SizedBox(
        height: Dimens.size(88) + SystemScreenUtil.getStatusBarH(context),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft,
                  end: Alignment.bottomRight,colors:tempColor
              ),
            ),
            padding:
            EdgeInsets.only(top: SystemScreenUtil.getStatusBarH(context)),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                      child: Stack(
                        children: <Widget>[
                          /// 左边 图片 按钮
                          Offstage(
                            offstage: !widget.leftImageVisible,
                            child: GestureDetector(
                              child: Container(
                                color: Colors.transparent,
                                height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: Dimens.size(34),
                                    right: Dimens.size(32),
                                  ),
                                  child: Image.asset(
                                    MyUtil.getImgPath(widget.leftImage),
                                    width: widget.leftImageWidth == null
                                        ? Dimens.size(20)
                                        : widget.leftImageWidth,
                                    height: widget.leftImageHeigh == null
                                        ? Dimens.size(36)
                                        : widget.leftImageHeigh,
                                    color: widget.userThemeStyle
                                        ? Colors.white
                                        : ColorT.color_333333,
                                  ),
                                ),
                              ),
                              onTap: widget.onLeftImageClick ??
                                      () {
                                    NavigatorUtils.goBack(context);
                                  },
                            ),
                          ),

                          /// 标题
                          Offstage(
                            offstage: false,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 60, right: 60),
                              child: Center(
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: Dimens.sp(36),
                                      color: widget.userThemeStyle
                                          ? Colors.white
                                          : ColorT.color_333333),
                                ),
                              ),
                            ),
                          ),

                          /// 右边 文字按钮
                          Positioned(
                            height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                            right: 0,
                            child: Row(
                              children: <Widget>[
                                Offstage(
                                  offstage: !widget.rightTextVisible,
                                  child: GestureDetector(
                                    onTap: widget.onRightTextClick,
                                    child: Container(
                                      color: Colors.transparent,
                                      height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: Dimens.size(32),
                                            left: Dimens.size(20)),
                                        child: Text(
                                          widget.rightText,
                                          style: TextStyle(
                                              fontSize: Dimens.sp(30),
                                              color: widget.userThemeStyle
                                                  ? Colors.white
                                                  : ColorT.color_333333),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// 右边 图片 按钮
                          Positioned(
                            height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                            right: 0,
                            child: Offstage(
                              offstage: !widget.rightImageVisible,
                              child: GestureDetector(
                                onTap: widget.onRightImageClick,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: Dimens.size(32),
                                        top: Dimens.size(10),
                                        bottom: Dimens.size(10),
                                        left: Dimens.size(20)),
                                    child: widget.rightImageVisible
                                        ? Image.asset(
                                      MyUtil.getImgPath(
                                          widget.rightImage),
                                      color: widget.userThemeStyle
                                          ? Colors.white
                                          : ColorT.color_333333,
                                      width: Dimens.size(36),
                                      height: Dimens.size(36),
                                    )
                                        : Container(),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// 定义 右边 按钮组
                          widget.rightWidgetList == null
                              ? Container()
                              : Positioned(
                            height:  widget.showDivider?Dimens.size(87):Dimens.size(88),
                            right: 0,
                            child: Row(
                              children: widget.rightWidgetList,
                            ),
                          ),
                        ],
                      )),
                  widget.showDivider
                      ? DividerHorizontal()
                      : Container()
//                  widget.showDivider
//                      ? DividerHorizontal()
//                      : widget.userThemeStyle
//                      ? DividerHorizontal(
//                      dividerColor: widget.dividerColor ??
//                          Theme.of(context).primaryColor)
//                      : DividerHorizontal(dividerColor: widget.dividerColor)
                ],
              ),
            ),
          ),
          brightness:
          widget.userThemeStyle ? Brightness.dark : Brightness.light,
//          backgroundColor: widget.userThemeStyle
//              ? widget.backgroudColor ?? Theme.of(context).primaryColor
//              : (widget.backgroudColor == null)
//                  ? Colors.white
//                  : widget.backgroudColor,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          //设置没有返回按钮
          bottom: widget.bottom,
          bottomOpacity: widget.bottomOpacity,
        ),
      ),
    );
  }
}
