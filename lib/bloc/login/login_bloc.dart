import 'package:wanandroid_bloc/common/index_all.dart';


class LoginBloc extends Bloc<LoginBaseEvent, LoginBaseState> {
  @override
  LoginBaseState get initialState => InitLoginState();

  @override
  Stream<LoginBaseState> mapEventToState(LoginBaseEvent event) async* {
    try {

      /// 登录
      if (event is LogineEvent) {

        String username = event.username;
        String password = event.password;

        String errorMsg ;

        try {
          UserModel userModel = await HttpRequestFactory.login(
              username: username, password: password).catchError((error) {
            LogUtil.e("LoginResp error: ${error.toString()}");
            errorMsg = error.toString();
          });

          if(userModel == null) {
            yield LoginFailState(errorMsg: errorMsg);
          }else{
            SpUtil.putString(Constant.SP_KEY_LOGIN, userModel.username);
            yield LoginSuccessState(userModel: userModel);
          }

        } catch (e) {
          yield LoginFailState(errorMsg: e.toString());
        }
      }
      /// 注册
      if (event is RegisterEvent) {

        String username = event.username;
        String password = event.password;
        String repassword = event.repassword;

        String errorMsg ;

        try {
          BaseResponse baseResponse = await HttpRequestFactory.register(
               username, password,repassword).catchError((error) {
            LogUtil.e("RegisterResp error: ${error.toString()}");
            errorMsg = error.toString();
          });

          if (baseResponse == null ){
            yield RegisterFailState(errorMsg: errorMsg);
          } else if(baseResponse.errorCode != Constant.STATUS_SUCCESS) {
            yield RegisterFailState(errorMsg: baseResponse.errorMsg);
          }else{
            yield RegisterSuccessState();
          }

        } catch (e) {
          yield RegisterFailState(errorMsg: e.toString());
        }
      }
      /// 退出登录
      if (event is LogineOutEvent) {
        String errorMsg ;
        BaseResponse baseResponse = await HttpRequestFactory.loginOut().catchError((error) {
          errorMsg = error.toString();
        });

        if(baseResponse == null){
          yield LoginOutFailState(errorMsg: errorMsg);
        }else if(baseResponse.errorCode != Constant.STATUS_SUCCESS){
          yield LoginOutFailState(errorMsg: baseResponse.errorMsg);
        }else{
          SpHelper.putObject(Constant.SP_KEY_LOGIN, null);
          yield LoginOutSuccessState();
        }
      }


    } catch (e) {
      if (event is LogineEvent) {
        yield LoginFailState(errorMsg: e.toString());
      } else if (event is LogineOutEvent) {
        yield LoginOutFailState(errorMsg: e.toString());
      }else if (event is RegisterEvent) {
        yield RegisterFailState(errorMsg: e.toString());
      }
    }
  }
}
