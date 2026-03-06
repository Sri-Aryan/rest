class VerifyOtpRequest {
  final String otp;

  VerifyOtpRequest({required this.otp});

  Map<String, dynamic> toJson() => {'otp': otp};
}
