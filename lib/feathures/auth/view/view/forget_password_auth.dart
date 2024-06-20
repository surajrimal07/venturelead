import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/view/view/verify_otp.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _forgetemailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailError;

  @override
  void dispose() {
    _forgetemailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the _formKey to the Form widget
            child: Column(
              children: [
                SizedBox(height: AppBar().preferredSize.height + 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(150, 150),
                      painter: RopesPainter(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Please enter email to reset your password",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _forgetemailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: _emailError,
                    labelStyle: const TextStyle(color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r"\S+@\S+\.\S+").hasMatch(value)) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: 0.33,
                  backgroundColor: Colors.grey.shade300,
                  color: Colors.red,
                ),
                const SizedBox(height: 10),
                const Text(
                  "1 of 3",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize:
                        const Size(double.infinity, 50), // Full-width button
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Please Wait',
                        message: 'Sending OTP to your email',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 1),
                      ));

                      bool isOtpSent = await handleSendOTPController(
                          _forgetemailController.text);

                      if (isOtpSent) {
                        Get.to(VerifyPasswordView(
                            email: _forgetemailController.text));
                      }
                    }
                  },
                  child: const Text(
                    'Send Email OTP',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RopesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.2,
        size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.4,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.6,
        size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.8,
        size.width * 0.5, size.height * 0.9);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
