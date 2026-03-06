import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reset_password.dart';
import '../providers/auth_providers.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _tokenController = TextEditingController(text: 'otp_token_here'); // From previous screen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E1DA),
      appBar: AppBar(title: Text('Reset Password'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text('Reset Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 48),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password', prefixIcon: Icon(Icons.lock)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirm Password', prefixIcon: Icon(Icons.lock)),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _resetPassword,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
                child: Text('RESET PASSWORD', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    ref.read(authProvider.notifier).resetPassword(ResetPasswordRequest(
      token: _tokenController.text,
      password: _passwordController.text,
      cpassword: _confirmController.text,
    ));
  }
}
