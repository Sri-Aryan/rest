// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/login_request.dart';
// import '../providers/auth_providers.dart';
// import 'forgot.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authProvider);
//
//     return Scaffold(
//       backgroundColor: Color(0xFFF5E1DA),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   IconButton(icon: Icon(Icons.arrow_back, color: Colors.black54), onPressed: () => Navigator.pop(context)),
//                   Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
//                       ),
//                       SizedBox(height: 16),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock)),
//                       ),
//                       SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 56,
//                         child: ElevatedButton(
//                           onPressed: authState.isLoading ? null : _login,
//                           style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
//                           child: authState.isLoading ? CircularProgressIndicator(color: Colors.white) : Text('LOGIN', style: TextStyle(fontSize: 16, color: Colors.white)),
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordScreen())), child: Text('Forgot Password?')),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _login() {
//     ref.read(authProvider.notifier).login(
//         LoginRequest(
//       email: _emailController.text,
//       password: _passwordController.text,
//       role: 'farmer',
//       deviceToken: '0imfnc8mVLWwsAawjYr4Rx-Af50DDqtlx',
//       type: 'email',
//     ));
//   }
// }
