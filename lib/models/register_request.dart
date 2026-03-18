class BusinessHours {
  final List<String> mon;
  final List<String> tue;
  final List<String> wed;
  final List<String> thu;
  final List<String> fri;
  final List<String> sat;
  final List<String> sun;

  BusinessHours({
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.sun,
  });

  Map<String, dynamic> toJson() {
    return {
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
    };
  }
}

class RegisterRequest {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String businessName;
  final String informalName;
  final String address;
  final String city;
  final String state;
  final int zipCode;
  final String? registrationProof;
  final BusinessHours businessHours;
  final String deviceToken;
  final String type;
  final String? socialId;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.businessName,
    required this.informalName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    this.registrationProof,
    required this.businessHours,
    required this.deviceToken,
    required this.type,
    this.socialId,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'business_name': businessName,
      'informal_name': informalName,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipCode,
      if (registrationProof != null) 'registration_proof': registrationProof,
      'business_hours': businessHours.toJson(),
      'device_token': "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
      'type': "email/facebook/google/apple",
      'social_id': "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
    };
  }
}
