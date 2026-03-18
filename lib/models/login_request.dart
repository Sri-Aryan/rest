class LoginRequest {
  final String email;
  final String password;
  final String role;
  final String deviceToken;
  final String type;
  final String? socialId;

  LoginRequest({
    required this.email,
    required this.password,
    required this.role,
    required this.deviceToken,
    required this.type,
    this.socialId,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': "farmer",
      'device_token': "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      'type': "email/facebook/google/apple",
      if (socialId != null) 'social_id': socialId,
    };
  }
}
