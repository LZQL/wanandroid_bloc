import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:wanandroid_bloc/common/index_all.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class DioUtil {
  Dio _dio;
  static DioUtil _instance = new DioUtil._internal();
  static bool _isDebug = false;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String _errorCodeKey = "errorCode";

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String _errorMsgKey = "errorMsg";

  /// BaseResp [T data]字段 key, 默认：data.
  String _dataKey = "data";

  PersistCookieJar _persistCookieJar;

  factory DioUtil() {
    return _instance;
  }

  /// 打开debug模式.
  static void openDebug() {
    _isDebug = true;
  }

  //以 _ 开头的函数、变量无法在库外使用
  DioUtil._internal() {
    init();
  }

  init() async {
    BaseOptions options = new BaseOptions(
      baseUrl: Apis.BASE_URL, //基础地址
      connectTimeout: 5000, //连接服务器超时时间，单位是毫秒
      receiveTimeout: 3000, //读取超时
    );
    _dio = new Dio(options);
    Directory directory = await getApplicationDocumentsDirectory();
    var path = Directory(join(directory.path, "cookie")).path;
    _persistCookieJar = PersistCookieJar(dir: path);
    _dio.interceptors.add(CookieManager(_persistCookieJar));
  }

  Future<BaseResponse<T>> request<T>(String method, String url,
      {data, Options options, CancelToken cancelToken,queryParameters}) async {
    int _errorCode;
    String _errorMsg;
    T _data;

    Response response = await _dio.request(url,
        data: data,
        options: _checkOptions(method, options),
        queryParameters: queryParameters,
        cancelToken: cancelToken);
//    print(response.request.headers);
//    print(response.request.data);
//    print(response.data);

    _printHttpLog(response);

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        if (response.data is Map) {
          _errorCode = (response.data[_errorCodeKey] is String)
              ? int.tryParse(response.data[_errorCodeKey])
              : response.data[_errorCodeKey];
          _errorMsg = response.data[_errorMsgKey];
          _data = response.data[_dataKey];
        } else {
          Map<String, dynamic> _dataMap = _decodeData(response);
          _errorCode = (_dataMap[_errorCodeKey] is String)
              ? int.tryParse(_dataMap[_errorCodeKey])
              : _dataMap[_errorCodeKey];
          _errorMsg = _dataMap[_errorMsgKey];
          _data = _dataMap[_dataKey];
        }

        /// 这边做 后台返回的  _errorCode 的一些业务逻辑判断

        return new BaseResponse(_data, _errorCode, _errorMsg);
      } catch (e) {
//        print(e);
//        return new Future.error(new DioError(
//          response: response,
//        ));

        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }

    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  void clearCookie() {
    _persistCookieJar.deleteAll();
  }

  ///   ===========================      工具方法      ===========================

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// print Http Log.
  void _printHttpLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.request));
      _printDataStr("reqdata ", response.request.data);
      _printDataStr("response", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  /// print Data Str.
  void _printDataStr(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }
}
