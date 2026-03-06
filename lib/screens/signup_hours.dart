import 'package:flutter/material.dart';
import 'package:rest/screens/signup_confirm.dart';
import 'package:rest/screens/signup_verify.dart';

class SignupHoursScreen extends StatefulWidget {
  final Map<String, dynamic> formData;
  const SignupHoursScreen({Key? key, required this.formData}) : super(key: key);

  @override
  State<SignupHoursScreen> createState() => _SignupHoursScreenState();
}

class _SignupHoursScreenState extends State<SignupHoursScreen> {
  final Map<String, List<String>> businessHours = {
    'mon': ['8:00am - 10:00am', '10:00am - 1:00pm'],
    'tue': ['8:00am - 10:00am', '10:00am - 1:00pm'],
    'wed': ['8:00am - 10:00am', '10:00am - 1:00pm', '1:00pm - 4:00pm'],
    'thu': ['8:00am - 10:00am', '10:00am - 1:00pm', '1:00pm - 4:00pm'],
    'fri': ['8:00am - 10:00am', '10:00am - 1:00pm'],
    'sat': ['8:00am - 10:00am', '10:00am - 1:00pm'],
    'sun': ['8:00am - 7:00pm'],
  };

  @override
  Widget build(BuildContext context) {
    widget.formData['business_hours'] = businessHours;

    return Scaffold(
      backgroundColor: Color(0xFFFFF8F6), // Light peach background
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar - EXACTLY like previous screens
            Container(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                children: [
                  // Back Arrow
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

                  // App Title + Progress
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
                          'Sign up • 3 of 4',
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

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),

                    // Title + Subtitle
                    Text(
                      'Business Hours',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1A1A),
                        height: 1.05,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'This will allow customers to order deliveries',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 38),

                    // Days Toggle Row - EXACTLY like image
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12,),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          _buildDayToggle('M', 0, 'mon'),
                          SizedBox(width: 1),
                          _buildDayToggle('T', 1, 'tue'),
                          SizedBox(width: 1),
                          _buildDayToggle('W', 2, 'wed'),
                          SizedBox(width: 1),
                          _buildDayToggle('T', 3, 'thu'),
                          SizedBox(width: 1),
                          _buildDayToggle('F', 4, 'fri'),
                          SizedBox(width: 1),
                          _buildDayToggle('S', 5, 'sat'),
                          SizedBox(width: 1),
                          _buildDayToggle('S', 6, 'sun'),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),

                    // Time Slots - Multiple selectable times
                    Column(
                      children: [
                        _buildTimeSlot('8:00am - 10:00am', 0),
                        SizedBox(height: 12),
                        _buildTimeSlot('10:00am - 1:00pm', 1),
                        SizedBox(height: 12),
                        _buildTimeSlot('1:00pm - 4:00pm', 2),
                        SizedBox(height: 12),
                        _buildTimeSlot('4:00pm - 7:00pm', 3),
                      ],
                    ),

                    SizedBox(height: 60),

                    // Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFFE67E5C), Color(0xFFD65A3F)],
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
                          onTap: _onSignUpPressed,
                          child: Center(
                            child: Text(
                              'Sign Up',
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

  Widget _buildDayToggle(String label, int index, String dayKey) {
    bool isActive = businessHours[dayKey]!.isNotEmpty;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isActive) {
            businessHours[dayKey] = [];
          } else {
            businessHours[dayKey] = ['8:00am - 10:00am']; // Default time
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFE67E5C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Color(0xFFE67E5C) : Color(0xFFE0E0E0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Color(0xFF666666),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, int index) {
    bool isSelected = businessHours.values.any((times) => times.contains(time));

    return GestureDetector(
      onTap: () {
        setState(() {
          // Toggle time slot for active days
          bool anyDayHasThisTime = businessHours.values.any((times) => times.contains(time));
          if (anyDayHasThisTime) {
            // Remove from all days
            businessHours.forEach((day, times) {
              businessHours[day] = times.where((t) => t != time).toList();
            });
          } else {
            // Add to all active days
            businessHours.forEach((day, times) {
              if (times.isNotEmpty) {
                if (!times.contains(time)) {
                  times.add(time);
                }
              }
            });
          }

          // Clean up empty days
          businessHours.forEach((day, times) {
            if (times.isEmpty) {
              businessHours[day] = [];
            }
          });
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFFFF3E0) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFFE67E5C) : Color(0xFFE0E0E0),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            if (isSelected)
              Icon(Icons.check, color: Color(0xFFE67E5C), size: 20),
          ],
        ),
      ),
    );
  }

  void _onSignUpPressed() {
    widget.formData['business_hours'] = businessHours;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignupConfirmationScreen(formData: widget.formData),
      ),
    );
  }
}
