import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/api.dart';
import '../models/forgot_request.dart';
import '../models/login_request.dart';
import '../models/reset_password.dart';
import '../models/verify.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://sowlab.com/assignment/'));
});

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<ApiResponse?>>((ref) {
  return AuthNotifier(ref.watch(dioProvider));
});

class AuthNotifier extends StateNotifier<AsyncValue<ApiResponse?>> {
  final Dio dio;

  AuthNotifier(this.dio) : super(const AsyncValue.data(null));

  Future<void> login(LoginRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/login', data: request.toJson());
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> register(FormData formData) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/register', data: formData);
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/forgot-password', data: request.toJson());
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/verify-otp', data: request.toJson());
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> resetPassword( ResetPasswordRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/reset-password', data: request.toJson());
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
