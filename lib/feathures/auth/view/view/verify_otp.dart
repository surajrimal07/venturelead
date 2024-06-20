import 'package:animated_pin_input_text_field/animated_pin_input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/view/view/reset_password.dart';

class OTPController extends GetxController {
  var otp = "".obs;

  void updateOtp(String value) {
    otp.value = value;
  }
}

class VerifyPasswordView extends StatelessWidget {
  final OTPController otpController = Get.put(OTPController());
  final _forgetemailController = TextEditingController();

  final String email;

  VerifyPasswordView({super.key, required this.email});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Verify your OTP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter the code we sent you to email",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              PinInputTextField(
                automaticFocus: true,
                aspectRatio: 1,
                pinLength: 4,
                onChanged: (String value) {
                  otpController.otp.value = value;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Didn't Receive the Code ?",
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () async {
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Please Wait',
                    message: 'Sending OTP to your email',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                  ));

                  await handleSendOTPController(email);
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.66,
                backgroundColor: Colors.grey.shade300,
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              const Text(
                "2 of 3",
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  if (otpController.otp.value.isEmpty ||
                      otpController.otp.value.length != 4 ||
                      !RegExp(r'^[0-9]*$').hasMatch(otpController.otp.value)) {
                    Get.snackbar("Error", "Please enter a valid OTP",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red);
                    return;
                  }

                  bool isOTPVerified = await handleVerifyOTPController(
                      email, int.parse(otpController.otp.value));

                  if (isOTPVerified) {
                    Get.to(() => ChangePasswordScreen(email: email));
                  }
                },
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
