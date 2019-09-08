import 'package:flutter/material.dart';
import 'package:wanandroid_bloc/resources/resources.dart';

/// 首页 icon with badge  红点提示，数量提示
class IconWithBadge extends StatelessWidget {
  final Icon icon;
  final Color color;
  final int badgeNumber;

  const IconWithBadge({Key key, this.icon, this.color, this.badgeNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
//      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only( top:Dimens.size(10),left: Dimens.size(40), right: Dimens.size(40)),
          child: icon,
        ),
        Positioned(
            top: Dimens.size(4),
            left: Dimens.size(70),
//            right: 0,
            child: badgeNumber <= 0
                ? Container()
                :
            Container(
              padding: EdgeInsets.fromLTRB(Dimens.size(10), Dimens.size(4),Dimens.size(10), Dimens.size(4)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(Dimens.size(20)))
              ),
              child: Text(
                '${badgeNumber > 99 ? '99+' : badgeNumber}',
                style: TextStyles.size20colorffffff,
              ),
            )
        )
      ],
    );
  }
}