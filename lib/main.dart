import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/screens/login_main.dart';
import 'package:rest/screens/login_scteen.dart';
import 'package:rest/screens/signup_confirm.dart';
import 'package:rest/screens/signup_hours.dart';
import 'package:rest/screens/signup_info.dart';
import 'package:rest/screens/signup_verify.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: WelcomeScreen(),
      routes: {
        '/login': (context) => WelcomeScreen()  ,
        '/signup-form': (context) => SignupFormInfoScreen(),
        '/signup-hours': (context) => SignupHoursScreen(formData: {}),
        '/signup-verification': (context) => SignupVerificationScreen(formData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
        '/signup-confirmation': (context) => SignupConfirmationScreen(formData: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>),
      },
    );
  }
}
