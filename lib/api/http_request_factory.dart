import 'package:wanandroid_bloc/common/index_all.dart';

class HttpRequestFactory {
  /// 获取 首页 Banner
  static Future<List<BannerModel>> getBanner() async {
    BaseResponse<List> baseResp =
        await DioUtil().request<List>(Method.get, Apis.BLOG_BANNER_URL);

    List<BannerModel> bannerList;
    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((value) {
        return BannerModel.fromJson(value);
      }).toList();
    }
    return bannerList;
  }

  /// 获取 首页 文章 数据
  static Future<BaseRefreshModel> getBlogList({int page, String data}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.get, Apis.getPath(path: Apis.BLOG_LIST_URL, page: page),
            data: data);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 获取 最新项目 列表数据
  static Future<BaseRefreshModel> getNewProjectList(
      {int page, String data}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(Method.get,
            Apis.getPath(path: Apis.NEW_PROJECT_LIST_URL, page: page),
            data: data);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 获取 项目分类
  static Future<List<TagModel>> getProjectClassify() async {
    BaseResponse<List> baseResp =
        await DioUtil().request<List>(Method.get, Apis.PROJECT_CLASSIFY_URL);

    List<TagModel> projectClassifyList;
    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    if (baseResp.data != null) {
      projectClassifyList = baseResp.data.map((value) {
        return TagModel.fromJson(value);
      }).toList();
    }
    return projectClassifyList;
  }

  /// 获取 项目 列表数据
  static Future<BaseRefreshModel> getProjectList(
      {int page, int cid}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
            Method.get, Apis.getPath(path: Apis.PROJECT_LIST_URL, page: page)+"?cid=$cid");


    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 获取 公众号分类
  static Future<List<TagModel>> getPublicClassify() async {
    BaseResponse<List> baseResp =
    await DioUtil().request<List>(Method.get, Apis.PUBLIC_CLASIFY_URL);

    List<TagModel> projectClassifyList;
    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    if (baseResp.data != null) {
      projectClassifyList = baseResp.data.map((value) {
        return TagModel.fromJson(value);
      }).toList();
    }
    return projectClassifyList;
  }

  /// 获取 公众号历史数据 列表数据
  static Future<BaseRefreshModel> getPublicList(
      {int page, int id}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.get, Apis.getPath(path: Apis.PUBLIC_URL + "/$id", page: page));


    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 获取 体系 一级分类 数据
  static Future<List<SystemTabModel>> getSystemClassifyOne() async {
    BaseResponse<List> baseResp =
    await DioUtil().request<List>(Method.get, Apis.SYSTEM_CLASSIFY_ONE_URL);

    List<SystemTabModel> projectClassifyList;
    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    if (baseResp.data != null) {
      projectClassifyList = baseResp.data.map((value) {
        return SystemTabModel.fromJson(value);
      }).toList();
    }
    return projectClassifyList;
  }


  /// 获取 体系下 文章 列表数据
  static Future<BaseRefreshModel> getSystemList(
      {int page, String cid}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.get, Apis.getPath(path: Apis.SYSTEM_URL, page: page)+"?cid=$cid");


    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 登录
  static Future<UserModel> login({String username, String password}) async {
    Map<String, dynamic> queryParameters = {
      'username': username,
      'password':password,
    };


    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.post, Apis.LOGIN_URL,
        queryParameters: queryParameters);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    UserModel baseResponse = null;
    if (baseResp.data != null) {
      baseResponse = UserModel.fromJson(baseResp.data);
      return baseResponse;
    }
    return baseResponse;
  }

  /// 退出登录
  static Future<BaseResponse> loginOut() async{

    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.get, Apis.LOGIN_OUT);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    return baseResp;
  }

  /// 注册
  static Future<BaseResponse> register(String username,String password,String repassword ) async{

    Map<String, dynamic> queryParameters = {
      'username': username,
      'password':password,
      'repassword':repassword,
    };

    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.post, Apis.REGISTER_URL,queryParameters: queryParameters);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    return baseResp;
  }

  /// 收藏列表
  static Future<BaseRefreshModel> getCollectList(
      {int page}) async {
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.get, Apis.getPath(path: Apis.COLLECT_LIST_URL, page: page));


    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }

  /// 收藏文章
  static Future<BaseResponse> collectArticle(int id) async{
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.post, Apis.getPath(path:Apis.COLLECT_ARTICLE,page:id));

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    return baseResp;

  }

  /// 取消收藏文章
  static Future<BaseResponse> cancelCollectArticle(int id) async{
    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.post, Apis.getPath(path:Apis.CANCEL_COLLECT_ARTICLE,page:id));

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }
    return baseResp;

  }

  /// 搜索
  static Future<BaseRefreshModel> search(
      {int page,String k}) async {

    Map<String, dynamic> queryParameters = {
      'k': k,
    };

    BaseResponse<Map<String, dynamic>> baseResp = await DioUtil()
        .request<Map<String, dynamic>>(
        Method.post, Apis.getPath(path: Apis.SEARCH_URL, page: page),queryParameters: queryParameters);

    if (baseResp.errorCode != Constant.STATUS_SUCCESS) {
      return new Future.error(baseResp.errorMsg);
    }

    BaseRefreshModel baseRefreshModel = null;
    if (baseResp.data != null) {
      baseRefreshModel = BaseRefreshModel.fromJson(baseResp.data);
      return baseRefreshModel;
    }
    return baseRefreshModel;
  }


}
