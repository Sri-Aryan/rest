import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/screens/signup_verify.dart';

class SignupFormInfoScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignupFormInfoScreen> createState() => _SignupFormInfoScreenState();
}

class _SignupFormInfoScreenState extends ConsumerState<SignupFormInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _businessNameController = TextEditingController();
  final _informalNameController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  final Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FormerEats',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A1A1A),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sign up • 2 of 4',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),

                    Text(
                      'Farm Info',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A),
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 52),

                    _buildInputField(
                      controller: _businessNameController,
                      iconPath: 'assets/images/buissness.png',
                      label: 'Business Name',
                    ),
                    SizedBox(height: 20),

                    _buildInputField(
                      controller: _informalNameController,
                      iconPath: 'assets/images/name.png',
                      label: 'Informal Name',
                    ),
                    SizedBox(height: 20),

                    _buildInputField(
                      controller: _streetAddressController,
                      iconPath: 'assets/images/home.png',
                      label: 'Street Address',
                    ),
                    SizedBox(height: 20),

                    _buildInputField(
                      controller: _cityController,
                      iconPath: 'assets/images/home.png',
                      label: 'City',
                    ),
                    SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            controller: _stateController,
                            iconPath: 'assets/images/home.png',
                            label: 'State',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildInputField(
                            controller: _zipCodeController,
                            iconPath: 'assets/images/home.png',
                            label: 'Zipcode',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 60),

                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE67E5C),
                            Color(0xFFD65A3F),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE67E5C).withOpacity(0.4),
                            blurRadius: 24,
                            offset: Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: _onContinuePressed,
                          child: Center(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String iconPath,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.transparent),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 16, color: Color(0xFF333333)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 14,
            color: Color(0xFF999999),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(16),
            child: Image.asset(
              iconPath,
              width: 20,
              height: 20,
              color: Color(0xFF999999),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFE67E5C), width: 1),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
        onChanged: (value) {
          // Store in formData
          final key = label.toLowerCase().replaceAll(' ', '_');
          formData[key] = value;
        },
      ),
    );
  }

  void _onContinuePressed() {
    // if (_formKey.currentState!.validate()) {
    //   // Collect all form data
      formData.addAll({
        'business_name': _businessNameController.text.trim(),
        'informal_name': _informalNameController.text.trim(),
        'address': _streetAddressController.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'zip_code': int.tryParse(_zipCodeController.text.trim()) ?? 0,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupVerificationScreen(formData: formData),
        ),
      );

  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _informalNameController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }
}
