import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/forgot_request.dart';
import '../providers/auth_providers.dart';
import 'otp.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E1DA),
      appBar: AppBar(title: Text('FarmerEats'), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Forgot Password?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Enter your mobile number', style: TextStyle(color: Colors.black54)),
            SizedBox(height: 48),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.asset('assets/images/call.png', width: 20, height: 20), // Add your icon
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  hintStyle: TextStyle(color: Colors.black38),
                ),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _sendOtp,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
                child: Text('SEND CODE', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendOtp() {
    ref.read(authProvider.notifier).forgotPassword(ForgotPasswordRequest(mobile: _mobileController.text));
    Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(isReset: true, email: '+1984512598',)));
  }
}
