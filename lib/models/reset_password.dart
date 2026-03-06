class ResetPasswordRequest {
  final String token;
  final String password;
  final String cpassword;

  ResetPasswordRequest({
    required this.token,
    required this.password,
    required this.cpassword,
  });

  Map<String, dynamic> toJson() => {
    'token': token,
    'password': password,
    'cpassword': cpassword,
  };
}
