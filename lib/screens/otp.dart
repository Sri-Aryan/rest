import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/providers/auth_providers.dart';
import 'package:rest/screens/reset.dart';
import 'package:rest/screens/home.dart';
import 'package:rest/screens/signup_confirm.dart';
import '../models/api.dart';
import '../models/verify.dart';
import '../models/forgot_request.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final bool isReset;
  final String email;
  const OtpScreen({Key? key, required this.isReset, required this.email}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late final Map<String, dynamic> formData;
  final List<TextEditingController> _otpControllers = List.generate(4, (_) => TextEditingController());
  bool _isLoading = false;
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { focusNodes[0]?.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<ApiResponse?>>(authProvider, (previous, next) {
      next.when(
        data: (response) {
          setState(() => _isLoading = false);
          if (response?.isSuccess == true) {
            if (widget.isReset) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response?.message ?? 'Verification failed'), backgroundColor: Colors.red),
            );
          }
        },
        error: (error, stack) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Network error: $error'), backgroundColor: Colors.red),
          );
        },
        loading: () {},
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5E1DA),
      appBar: AppBar(
        title: Text('Verify OTP', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF8B4513)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify OTP',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: Color(0xFF8B4513)),
            ),
            SizedBox(height: 8),

            Text('Enter the code sent to your mobile',
              style: TextStyle(fontSize: 16, color: Color(0xFF8B4513).withOpacity(0.7)),
            ),
            SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Color(0xFFE67E5C).withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF8B4513)),
                    decoration: InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    onChanged: (value) => _onOtpChanged(index, value),
                  ),
                );
              }),
            ),
            SizedBox(height: 48),

            Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFFE67E5C), Color(0xFFD65A3F)]),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Color(0xFFE67E5C).withOpacity(0.3), blurRadius: 20, offset: Offset(0, 8))],
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(32),
                child: InkWell(
                  onTap: _isLoading || !_isOtpComplete ? null : _verifyOtp,
                  borderRadius: BorderRadius.circular(32),
                  child: Center(
                    child: _isLoading
                        ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                        : Text(
                      'VERIFY',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            Center(
              child: GestureDetector(
                onTap: _isLoading ? null : _resendOtp,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Color(0xFFE67E5C).withOpacity(0.3)),
                  ),
                  child: Text(
                    'Resend Code',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFE67E5C)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      focusNodes[index+1]?.requestFocus();
    }
  }

  bool get _isOtpComplete => _otpControllers.map((c) => c.text).join().length == 4;

  String get _otpCode => _otpControllers.map((c) => c.text).join();

  void _verifyOtp() {
    if (!_isOtpComplete) return;
    setState(() => _isLoading = true);
    ref.read(authProvider.notifier).verifyOtp(
      VerifyOtpRequest(otp: "895642"),
    );

    Navigator.push(context, MaterialPageRoute(builder: (_) => SignupConfirmationScreen(formData: formData)));
  }

  void _resendOtp() {
    ref.read(authProvider.notifier).forgotPassword(
      ForgotPasswordRequest(mobile: widget.email),
    );

    Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPasswordScreen()));
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) controller.dispose();
    for (var focusNode in focusNodes) focusNode.dispose();
    super.dispose();
  }
}