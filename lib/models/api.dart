class ApiResponse {
  final String success;
  final String message;
  final String? token;
  final bool? isVerified;

  ApiResponse({required this.success, required this.message, this.token, this.isVerified});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      token: json['token'],
      isVerified: json['isVerified'] == 'true',
    );
  }
}
