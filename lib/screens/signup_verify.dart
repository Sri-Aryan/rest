import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/screens/signup_hours.dart';

class SignupVerificationScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> formData;
  const SignupVerificationScreen({Key? key, required this.formData}) : super(key: key);

  @override
  _SignupVerificationScreenState createState() => _SignupVerificationScreenState();
}

class _SignupVerificationScreenState extends ConsumerState<SignupVerificationScreen> {
  String? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E1DA),
      appBar: AppBar(
        title: Text('Verification'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Business Verification', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Upload business license/proof', style: TextStyle(color: Colors.black54)),
            SizedBox(height: 48),

            GestureDetector(
              onTap: _pickVerificationFile,
              child: Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFFE57373), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, size: 48, color: Color(0xFFE57373)),
                    SizedBox(height: 12),
                    Text(selectedFile ?? 'Upload Verification Document',
                        style: TextStyle(color: Color(0xFFE57373))),
                  ],
                ),
              ),
            ),

            if (selectedFile != null) ...[
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 12),
                    Expanded(child: Text(selectedFile!, style: TextStyle(fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
            ],

            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupHoursScreen(formData: widget.formData))),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFE57373)),
                child: Text('COMPLETE', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }


  Future<void> _pickVerificationFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() {
        selectedFile = result.files.single.name;
        widget.formData['verification_proof'] = result.files.single.path;
      });
    }
  }
}
