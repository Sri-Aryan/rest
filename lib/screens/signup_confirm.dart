import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/register_request.dart';
import '../providers/auth_providers.dart';

class SignupConfirmationScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formData;
  const SignupConfirmationScreen({Key? key, required this.formData}) : super(key: key);

  @override
  _SignupConfirmationScreenState createState() => _SignupConfirmationScreenState();
}

class _SignupConfirmationScreenState extends ConsumerState<SignupConfirmationScreen> {
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Color(0xFFF5E1DA),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20)],
                ),
                child: Icon(Icons.verified, size: 80, color: Color(0xFF4CAF50)),
              ),
              SizedBox(height: 32),
              Text(
                'All Set!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 12),
              Text(
                'Your account has been created successfully',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),

              if (_isSubmitting || authState.isLoading)
                CircularProgressIndicator()
              else
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _submitRegistration,
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
                    child: Text('COMPLETE REGISTRATION', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _submitRegistration() async {
    setState(() => _isSubmitting = true);

    // 1. Instantiate your model (Map your widget.formData to the class)
    final request = RegisterRequest(
      fullName: widget.formData['full_name'],
      email: widget.formData['email'],
      phone: widget.formData['phone'],
      password: widget.formData['password'],
      role: widget.formData['role'],
      businessName: widget.formData['business_name'],
      informalName: widget.formData['informal_name'],
      address: widget.formData['address'],
      city: widget.formData['city'],
      state: widget.formData['state'],
      zipCode: widget.formData['zip_code'],
      businessHours: widget.formData['business_hours'], // Ensure this maps correctly to your BusinessHours class
      deviceToken: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx", // Hardcoded
      type: "email", // Hardcoded
      socialId: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx", // Hardcoded
    );

    // 2. Use the model's toJson() which contains your hardcoded logic
    FormData formData = FormData.fromMap(request.toJson());

    await ref.read(authProvider.notifier).register(formData);

    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registration Complete!')),
    );
  }
  //
  // Future<void> _submitRegistration() async {
  //   setState(() => _isSubmitting = true);
  //
  //   widget.formData['social_id'] = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
  //   widget.formData['type'] = "email/facebook/google/apple";
  //   widget.formData['device_token'] = "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx";
  //
  //   FormData formData = FormData.fromMap({
  //     'registerData': widget.formData,
  //   });
  //
  //
  //   await ref.read(authProvider.notifier).register(formData);
  //
  //   setState(() => _isSubmitting = false);
  //
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Registration Complete!')),
  //   );
  // }
}
