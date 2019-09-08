import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/common/index_all.dart';

///自定义Dialog
class CustomDialog extends StatefulWidget {
  //------------------不带图片的dialog------------------------
  final String title; //弹窗标题
  final String content; //弹窗内容
  final String confirmContent; //按钮文本
  final Color confirmTextColor; //确定按钮文本颜色
  final bool isCancel; //是否有取消按钮，默认为true true：有 false：没有
  final Color confirmColor; //确定按钮颜色
  final Color cancelColor; //取消按钮颜色
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭
  final Function confirmCallback; //点击确定按钮回调
  final Function dismissCallback; //弹窗关闭回调

  //------------------带图片的dialog------------------------
  final String image; //dialog添加图片
  final String imageHintText; //图片下方的文本提示

  const CustomDialog(
      {Key key,
      this.title,
      this.content,
      this.confirmContent,
      this.confirmTextColor,
      this.isCancel = true,
      this.confirmColor,
      this.cancelColor,
      this.outsideDismiss = false,
      this.confirmCallback,
      this.dismissCallback,
      this.image,
      this.imageHintText})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomDialogState();
  }
}

class _CustomDialogState extends State<CustomDialog> {
  _confirmDialog() {
    _dismissDialog();
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
  }

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  Widget _buildBottomButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: widget.isCancel
                ? Container(
                    decoration: BoxDecoration(
                        color: widget.cancelColor == null
                            ? Colors.white
                            : widget.cancelColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimens.size(12)))),
                    child: FlatButton(
                      child: Text(IntlUtil.getString(context, Ids.cancel),
                          style: TextStyle(
                            fontSize: Dimens.sp(32),
                            color: widget.cancelColor == null
                                ? ColorT.color_333333
                                : Color(0xFFFFFFFF),
                          )),
                      onPressed: _dismissDialog,
                      splashColor: widget.cancelColor == null
                          ? Color(0xFFFFFFFF)
                          : widget.cancelColor,
                      highlightColor: widget.cancelColor == null
                          ? Color(0xFFFFFFFF)
                          : widget.cancelColor,
                    ),
                  )
                : Text(''),
            flex: widget.isCancel ? 1 : 0),
        SizedBox(
            width: widget.isCancel ? Dimens.size(1.0) : 0,
            child: Container(color: ColorT.divider)),
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: widget.confirmColor == null
                      ? Color(0xFFFFFFFF)
                      : widget.confirmColor,
                  borderRadius: widget.isCancel
                      ? BorderRadius.only(
                          bottomRight: Radius.circular(Dimens.size(12)))
                      : BorderRadius.only(
                          bottomLeft: Radius.circular(Dimens.size(12)),
                          bottomRight: Radius.circular(Dimens.size(12)))),
              child: FlatButton(
                onPressed: _confirmDialog,
                child: Text(
                    widget.confirmContent == null
                        ? IntlUtil.getString(context, Ids.confirm)
                        : widget.confirmContent,
                    style: TextStyle(
                      fontSize: Dimens.sp(32),
                      color: widget.confirmColor == null
                          ? (widget.confirmTextColor == null
                              ? Theme.of(context).primaryColor
                              : widget.confirmTextColor)
                          : Color(0xFFFFFFFF),
                    )),
                splashColor: widget.confirmColor == null
                    ? Color(0xFFFFFFFF)
                    : widget.confirmColor,
                highlightColor: widget.confirmColor == null
                    ? Color(0xFFFFFFFF)
                    : widget.confirmColor,
              ),
            ),
            flex: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    Column _columnText = Column(
      children: <Widget>[
        SizedBox(height: widget.title == null ? 0 : Dimens.size(32)),
        Text(widget.title == null ? '' : widget.title,
//            style: TextStyle(fontSize: Dimens.sp(34))
        style: TextStyles.size34color333333,
            ),
        Expanded(
            child: Center(
              child: Text(widget.content == null ? '' : widget.content,
//                  style: TextStyle(fontSize: Dimens.sp(30))
              style:TextStyles.size30color333333,
              ),
            ),
            flex: 1),
        DividerHorizontal(),
        Container(height: Dimens.size(100), child: _buildBottomButton()),
      ],
    );

    Column _columnImage = Column(
      children: <Widget>[
        SizedBox(
          height:
              widget.imageHintText == null ? Dimens.size(43) : Dimens.size(35),
//          height: widget.imageHintText == null ? 35.0 : 23.0,
        ),
        Image(
          image: AssetImage(widget.image == null ? '' : widget.image),
          width: Dimens.size(130),
          height: Dimens.size(130),
        ),
//        Gaps.vGap10,
        Expanded(
            child: Center(
              child: Text(
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: Dimens.size(20)),
//
//                ),
                widget.imageHintText == null ? "" : widget.imageHintText,
                style: TextStyles.size32color333333,
              ),
            ),
            flex: 1),

        DividerHorizontal(),

        Container(height: Dimens.size(100), child: _buildBottomButton())
      ],
    );

    return WillPopScope(
        child: GestureDetector(
          onTap: () => {widget.outsideDismiss ? _dismissDialog() : null},
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Container(
                width: width - Dimens.size(130.0),
//                height: Dimens.w_291,
                height: widget.image == null
                    ? Dimens.size(291.0)
                    : Dimens.size(387.0),
                alignment: Alignment.center,
                child: widget.image == null ? _columnText : _columnImage,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimens.size(12))),
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.outsideDismiss;
        });
  }
}
