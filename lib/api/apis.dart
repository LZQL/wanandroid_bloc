class Apis {

  static final String BASE_URL = "https://www.wanandroid.com/";

  /// 首页banner
  static final String BLOG_BANNER_URL = BASE_URL + "banner/json";

  /// 首页文章列表
  // http://www.wanandroid.com/article/list/0/json
  // 方法：GET
  // 参数：页码，拼接在连接中，从0开始。
  static final String BLOG_LIST_URL = BASE_URL + "article/list";

  /// 最新项目
  static final String NEW_PROJECT_LIST_URL = BASE_URL + "article/listproject";
  /// 项目分类
  static final String PROJECT_CLASSIFY_URL = BASE_URL + "project/tree/json";
  /// 项目列表数据
  static final String PROJECT_LIST_URL = BASE_URL + "project/list";

  /// 公众号分类
  static final String PUBLIC_CLASIFY_URL = BASE_URL + "wxarticle/chapters/json";
  /// 公众号历史数据    wxarticle/list/408/1/json
  static final String PUBLIC_URL = BASE_URL + "wxarticle/list";

  /// 体系 分类
  static final String SYSTEM_CLASSIFY_ONE_URL = BASE_URL + "tree/json";

  /// 体系下的文章列表
  static final String SYSTEM_URL = BASE_URL + "article/list";

  /// 登录
  static final String LOGIN_URL = BASE_URL + "user/login";

  /// 登出
  static final String LOGIN_OUT = BASE_URL + "user/logout/json";

  /// 注冊
  static final String REGISTER_URL = BASE_URL + "user/register";

  /// 收藏文章列表
  static final String COLLECT_LIST_URL = BASE_URL + "lg/collect/list";
  /// 收藏文章
  static final String COLLECT_ARTICLE = BASE_URL + "lg/collect";
  /// 取消收藏文章
  static final String  CANCEL_COLLECT_ARTICLE = BASE_URL + "lg/uncollect_originId";

  /// 搜索
  static final String SEARCH_URL = BASE_URL + "article/query";


  static String getPath({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }
}