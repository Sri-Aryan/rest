import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/screens/reset.dart';
import '../models/verify.dart';
import '../providers/auth_providers.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final bool isReset;
  const OtpScreen({Key? key, required this.isReset}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E1DA),
      appBar: AppBar(title: Text(widget.isReset ? 'Verify OTP' : 'Verify OTP'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(widget.isReset ? 'Verify OTP' : 'Verify OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Enter the code sent to your mobile', style: TextStyle(color: Colors.black54)),
            SizedBox(height: 48),
            // PinCodeTextField(
            //   controller: _otpController,
            //   length: 6,
            //   appContext: context,
            //   backgroundColor: Colors.transparent,
            //   // Configure to match peach theme
            // ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
                child: Text('VERIFY', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyOtp() {
    ref.read(authProvider.notifier).verifyOtp(VerifyOtpRequest(otp: _otpController.text));
    if (widget.isReset) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
    }
  }
}
