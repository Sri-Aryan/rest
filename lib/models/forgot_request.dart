class ForgotPasswordRequest {
  final String mobile;

  ForgotPasswordRequest({required this.mobile});

  Map<String, dynamic> toJson() => {'mobile': mobile};
}
