class ApiResponse {
  final dynamic success;
  final String? message;
  final dynamic data;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data,
    };
  }

  bool get isSuccess {
    if (success is String) {
      return success == 'true';
    } else if (success is bool) {
      return success as bool;
    }
    return false;
  }
}
