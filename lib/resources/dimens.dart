
import 'package:wanandroid_bloc/common/index_all.dart';
class Dimens {

  static  double size(double tmp){
   return  ScreenUtil.getInstance().setWidth(tmp);
  }

  static double sp(double tmp){

    return ScreenUtil.getInstance().setSp(tmp);

  }

}
