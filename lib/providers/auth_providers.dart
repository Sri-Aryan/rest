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
      print("$request");
      final response = await dio.post('/user/login', data: request.toJson());
      final apiResponse = ApiResponse.fromJson(response.data);

      state = AsyncValue.data(apiResponse);

    } on DioException catch (e) {
      String errorMessage;

      if (e.response?.data != null) {
        final errorData = e.response!.data;
        errorMessage = errorData['message'] ?? errorData['error'] ?? 'Login failed';

        state = AsyncValue.data(ApiResponse(
          success: false,
          message: errorMessage,
          data: null,
        ));
      } else {
        errorMessage = e.message ?? 'Network error';
        state = AsyncValue.error(errorMessage, StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> register(FormData formData) async {
    state = const AsyncValue.loading();
    try {
      print("$formData");
      final response = await dio.post('/user/register', data: formData);
      print("$response");
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ?? 'Registration failed';
      state = AsyncValue.data(ApiResponse(
        success: 'false',
        message: errorMessage,
        //data: null,
      ));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/forgot-password', data: request.toJson());
      print("$response");
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ?? 'Forgot password failed';
      state = AsyncValue.data(ApiResponse(
        success: 'false',
        message: errorMessage,
        //data: null,
      ));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> verifyOtp(VerifyOtpRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/verify-otp', data: {
        "otp":"895642"
      });
      print("$response");
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ?? 'OTP verification failed';
      state = AsyncValue.data(ApiResponse(
        success: 'false',
        message: errorMessage,
        //data: null,
      ));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    state = const AsyncValue.loading();
    try {
      final response = await dio.post('/user/reset-password', data:
      {
        "token": "895642",
        "password": "12345",
        "cpassword": "12345"
      });
      print("$response");
      state = AsyncValue.data(ApiResponse.fromJson(response.data));
    } on DioException catch (e) {
      String errorMessage = e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ?? 'Reset password failed';
      state = AsyncValue.data(ApiResponse(
        success: 'false',
        message: errorMessage,
       // data: null,
      ));
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
