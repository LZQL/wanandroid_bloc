class BaseResponse<T> {
  T data;
  int errorCode;
  String errorMsg;

  BaseResponse(this.data, this.errorCode, this.errorMsg);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"data\":\"$data\"");
    sb.write(",\"errorCode\":$errorCode");
    sb.write(",\"errorMsg\":\"$errorMsg\"");
    sb.write('}');
    return sb.toString();
  }
}
