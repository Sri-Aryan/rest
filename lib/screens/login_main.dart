import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/models/login_request.dart';
import 'package:rest/screens/forgot.dart';
import 'package:rest/screens/signup_info.dart';
import 'package:rest/screens/signup_main.dart';

import '../models/api.dart';
import '../providers/auth_providers.dart';
import 'home.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<WelcomeScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<WelcomeScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Listen to auth state changes
    ref.listen<AsyncValue<ApiResponse?>>(authProvider, (previous, next) {
      next.when(
        data: (response) {
          if (response?.success == 'true') {
            // Login successful - navigate to home
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false,
            );
          } else {
            // Show API error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response?.message ?? 'Login failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        loading: () {
          // Show loading (already handled in UI)
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Network error: $error'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });
  }

  void _login() {
    //if (_formKey.currentState!.validate()) {
      // ✅ FIXED: Use .text to get string values from controllers
      ref.read(authProvider.notifier).login(
        LoginRequest(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: "farmer",
          deviceToken: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
          type: 'email',
          // socialId only needed for social login, make optional
        ),
      );
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow + Title
                Row(
                  children: [
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'FormerEats',
                        style: TextStyle(
                          fontSize: 12,
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
                    Text(
                      'New? ',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainSignupScreen())),
                      child: Text(
                        'Create account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE67E5C),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 48),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16),
                        child: Image.asset('assets/images/email.png', width: 20, height: 20), // Add your icon
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(16),
                        child: Image.asset('assets/images/password.png', width: 20, height: 20), // Add your icon
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordScreen())),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Forgot?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      hintStyle: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),

                SizedBox(height: 24),

                SizedBox(height: 32),

               Container(
                  width: double.infinity,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE67E5C), Color(0xFFD65A3F)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFE67E5C).withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _login,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(assetPath, width: 24, height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     // Call your auth provider here
  //     ref.read(authProvider.notifier).login(
  //       LoginRequest(
  //         email: _emailController,
  //         password: _passwordController,
  //         role: "farmer",
  //         deviceToken: "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
  //         type: 'email',
  //         socialId : "0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx",
  //       )
  //     );
  //   }
  // }
}
