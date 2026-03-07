import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/models/login_request.dart';
import 'package:rest/screens/forgot.dart';
import 'package:rest/screens/signup_main.dart';
import '../models/api.dart';
import '../providers/auth_providers.dart';
import 'home.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).login(
        LoginRequest(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: "farmer",
          deviceToken: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
          type: "email",
          socialId: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx"
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen<AsyncValue<ApiResponse?>>(authProvider, (previous, next) {
      next.when(
        data: (response) {
          if (response?.isSuccess == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false,
            );
          } else {
            _showError(response?.message ?? 'Login failed');
          }
        },
        error: (error, stack) => _showError('Network error: $error'),
        loading: () {},
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFF8F6),
      body: SafeArea(
        child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'FormerEats',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),

                Spacer(flex: 1),

                Text(
                  'Welcome back!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('New? ', style: TextStyle(fontSize: 16, color: Colors.black54)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainSignupScreen())),
                      child: Text(
                        'Create account',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFE67E5C)),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 48),

                Container(
                  decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: Padding(padding: EdgeInsets.all(16), child: Image.asset('assets/images/email.png', width: 20, height: 20)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                    validator: (value) => value?.isEmpty == true ? 'Email required' : null,
                  ),
                ),

                SizedBox(height: 20),

                // Password Field
                Container(
                  decoration: BoxDecoration(color: Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Padding(padding: EdgeInsets.all(16), child: Image.asset('assets/images/password.png', width: 20, height: 20)),
                      suffixIcon: GestureDetector(
                        onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, size: 20),
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                    validator: (value) => value?.isEmpty == true ? 'Password required' : null,
                  ),
                ),

                SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordScreen())),
                    child: Text(
                      'Forgot?',
                      style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFFE67E5C), Color(0xFFD65A3F)]),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Color(0xFFE67E5C).withOpacity(0.3), blurRadius: 20, offset: Offset(0, 8))],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: authState.isLoading ? null : _login,
                      child: Center(
                        child: authState.isLoading
                            ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                            : Text(
                          'Login',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),

                Spacer(flex: 2),

                Row(
                  children: [
                    Expanded(child: _buildSocialButton('assets/images/google.png', 'Google')),
                    SizedBox(width: 16),
                    Expanded(child: _buildSocialButton('assets/images/apple.png', 'Apple')),
                    SizedBox(width: 16),
                    Expanded(child: _buildSocialButton('assets/images/facebook.png', 'Facebook')),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String assetPath, String label) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(assetPath, width: 24, height: 24),
            SizedBox(width: 8),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
