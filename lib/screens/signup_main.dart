import 'package:flutter/material.dart';
import 'package:rest/screens/signup_info.dart';

class MainSignupScreen extends StatefulWidget {
  @override
  _MainSignupScreenState createState() => _MainSignupScreenState();
}

class _MainSignupScreenState extends State<MainSignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),

                Row(
                  children: [
                    Text(
                      'FormerEats',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Sign up • 1 of 4',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 28),

                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 48),

                Row(
                  children: [
                    Expanded(
                      child: _buildSocialButton('Google', 'assets/images/google.png'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildSocialButton('Apple', 'assets/images/apple.png'),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildSocialButton('Facebook', 'assets/images/facebook.png'),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[400])),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or sign up with',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[400])),
                  ],
                ),
                SizedBox(height: 32),

                _buildTextField(
                  controller: _fullNameController,
                  iconAsset: 'assets/images/name.png',
                  hintText: 'Full Name',
                ),
                SizedBox(height: 20),

                _buildTextField(
                  controller: _emailController,
                  iconAsset: 'assets/images/email.png',
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),

                _buildTextField(
                  controller: _phoneController,
                  iconAsset: 'assets/images/call.png',
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 20),

                _buildTextField(
                  controller: _passwordController,
                  iconAsset: 'assets/images/call.png',
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 20),

                _buildTextField(
                  controller: _confirmPasswordController,
                  iconAsset: 'assets/images/call.png',
                  hintText: 'Re-enter Password',
                  obscureText: true,
                ),

                Spacer(),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MainSignupScreen())),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          side: BorderSide(color: Color(0xFFE67E5C)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE67E5C),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: GestureDetector(
                        onTap: _continueToFarmInfo,
                        child: Container(
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
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

  Widget _buildSocialButton(String label, String assetPath) {
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
            // Handle social login
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Image.asset(assetPath, width: 24, height: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String iconAsset,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(iconAsset, width: 20, height: 20),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintStyle: TextStyle(color: Colors.black38),
        ),
        onChanged: (value) {
          formData[hintText.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_')] = value;
        },
      ),
    );
  }

  void _continueToFarmInfo() {
    if (_formKey.currentState!.validate()) {
      formData.addAll({
        'full_name': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'password': _passwordController.text.trim(),
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignupFormInfoScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
